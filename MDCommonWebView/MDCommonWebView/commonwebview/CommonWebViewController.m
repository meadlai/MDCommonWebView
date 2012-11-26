//
//  CommonWebViewController.m
//  tcmp
//
//  Created by Mead on 9/21/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "CommonWebViewController.h"
#import "CommonWebViewController+UICollection.h"
#import "WebViewBridge.h"

#import "SearchWebViewController.h"

#import "JSONKit.h"
#import "ConfigInfo.h"
#import "RootViewController.h"



@interface CommonWebViewController (){
    //内部按钮状态保存,0表示正常,1表示高亮,2表示不可用.
    //多个按钮,从index=0开始,按顺序记录状态
    //如:010,表示[正常,高亮,正常]三个按钮
    //如:222,表示[禁用,禁用,禁用]三个按钮,都变灰,无法使用.
    NSString* _leftButtonStatus;
    NSString* _rightButtonStatus;
    //NSString* _store;
    //
}
//默认返回按钮.
-(void) defaultGoBackAction;
@end

@implementation CommonWebViewController

/**
 NSString* _path;
 NSString* _fileName;
 NSString* _arg;
 NSString* _viewTitle;
 **/

@synthesize path = _path;
@synthesize fileName = _fileName;
@synthesize url = _url;
@synthesize arg = _arg;
@synthesize viewTitle = _viewTitle;

@synthesize leftButtonTitle = _leftButtonTitle;
@synthesize leftButtonIcon = _leftButtonIcon;
@synthesize leftButtonAction = _leftButtonAction;
@synthesize rightButtonTitle = _rightButtonTitle;
@synthesize rightButtonIcon = _rightButtonIcon;
@synthesize rightButtonAction = _rightButtonAction;
//inner
@synthesize webview = _webview;

#pragma mark
#pragma mark 4个默认操作:跳转,后退,左按钮,右按钮,
/*
 页面跳转
 */
-(void)doRedirect:(NSString*)data{
    //NSLog(@"doAction with: %@",data);
    //parse args
    NSDictionary* json = [data objectFromJSONString];
    //
    CommonWebViewController* innerVC = [[[CommonWebViewController alloc]init] autorelease];
    innerVC.path = [json objectForKey:@"path"];
    innerVC.fileName = [json objectForKey:@"fileName"];
    innerVC.url = [json objectForKey:@"url"];
    innerVC.arg = [json objectForKey:@"arg"];
    innerVC.viewTitle = [json objectForKey:@"viewTitle"];
    
    innerVC.rightButtonTitle = [json objectForKey:@"rightButtonTitle"];
    innerVC.rightButtonIcon = [json objectForKey:@"rightButtonIcon"];
    innerVC.rightButtonAction = [json objectForKey:@"rightButtonAction"];
    
    innerVC.leftButtonTitle = [json objectForKey:@"leftButtonTitle"];
    innerVC.leftButtonIcon = [json objectForKey:@"leftButtonIcon"];
    innerVC.leftButtonAction = [json objectForKey:@"leftButtonAction"];
    
    innerVC.navigationItem.titleView = nil;
    innerVC.navigationItem.title = [json objectForKey:@"viewTitle"];
    
    [self.navigationController pushViewController:innerVC animated:YES];
}

//绑定右上角js回调
-(void)doRightCallBack{
    NSString* jsAction = [[NSString alloc]initWithFormat:@"%@()",_rightButtonAction];
    [_webview stringByEvaluatingJavaScriptFromString:jsAction];
    NSLog(@"==========rightButton_callback is %@",jsAction);
}
//绑定左上角js回调
-(void)doLeftCallBack{
    NSString* jsAction = [[NSString alloc]initWithFormat:@"%@()",_leftButtonAction];
    [_webview stringByEvaluatingJavaScriptFromString:jsAction];
    NSLog(@"==========leftButton_callback is %@",jsAction);
}

//后退方法,step要传入负数
//TODO:后退几步step.未支持js-callback
-(void)goBack:(NSString*)idata{
    //parse args
    NSDictionary* json = [idata objectFromJSONString];
    NSString* root = [json objectForKey:@"root"];
    NSString* step = [json objectForKey:@"step"];//负数-1,-2
    NSString* callback = [json objectForKey:@"callback"];
    NSString* data = [json objectForKey:@"data"];
    //
    int count = [self.navigationController.viewControllers count];
    //后退回调==callback
    if(callback!=nil){
        NSString* jsAction = [[NSString alloc]initWithFormat:@"%@('%@')",callback,data];
        id vc = [self.navigationController.viewControllers objectAtIndex:count-2];
        if([vc isKindOfClass:[CommonWebViewController class]]){
            CommonWebViewController* viewController = vc;
            [viewController.webview stringByEvaluatingJavaScriptFromString:jsAction];
            //NSLog(@"==========goBack_action = %@",jsAction);
        }
    }
    
    //返回根节点
    if(root !=nil && [root isEqualToString:@"true"]){
        if(callback!=nil){
            NSString* jsAction = [[NSString alloc]initWithFormat:@"%@('%@')",callback,data];
            
            // Inside anotherViewController
            NSArray *viewControllers = self.navigationController.viewControllers;
            id vc = [viewControllers objectAtIndex:0];
            //TODO:fixed bug, eval js function
            //NSLog(@"class is %@",[vc class]);
            RootViewController* root = vc;
            int selected = root.selectedIndex;
            CommonWebViewController* viewController = [root.viewControllers objectAtIndex:selected];
            if([vc isKindOfClass:[UIViewController class]]){
                //NSLog(@"==========isKindOfClass");
                [viewController.webview stringByEvaluatingJavaScriptFromString:jsAction];
            }
            
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    //返回step节点
    if (step!=nil) {
        //delt is negative.
        NSInteger delt = [step intValue];
        if(count+delt<0){
            return;
        }
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(count+delt-1)] animated:YES];
        return;
    }
    
    //默认返回一层
    [self.navigationController popViewControllerAnimated:YES];
}

//通用查询界面
-(void)doSearch:(NSString*)idata{
    //parse args
    NSDictionary* json = [idata objectFromJSONString];
    NSString* ipath = [json objectForKey:@"path"];
    NSString* ifileName = [json objectForKey:@"fileName"];
    NSString* iarg = [json objectForKey:@"arg"];
    NSString* ikeyword = [json objectForKey:@"keyword"];
    NSString* iplacehold = [json objectForKey:@"placehold"];
    NSString* icallback = [json objectForKey:@"callback"];
    
    //
    SearchWebViewController* searchVC = [[[SearchWebViewController alloc]initWithLocalFilePath:ipath withFileName:ifileName withArg:iarg callback:icallback] autorelease];
    searchVC.keyword = ikeyword;
    searchVC.placehold = iplacehold;
    
    [self.navigationController pushViewController:searchVC animated:NO];
}


#pragma mark
#pragma mark 渲染页面titleView
//处理按钮.
- (void) viewWillAppear:(BOOL)animated{
    if (self.tabBarController) {
        self.tabBarController.navigationItem.rightBarButtonItem = nil;
        self.tabBarController.navigationItem.leftBarButtonItem = nil;
        self.tabBarController.navigationItem.title = self.viewTitle;
    }else{
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.title = self.viewTitle;
    }
    //右边按钮
    if(_rightButtonAction != nil){
        UIBarButtonItem* rightButtonItem = nil;
        rightButtonItem = [[[UIBarButtonItem alloc] initWithTitle:_rightButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(doRightCallBack)] autorelease];
        if (self.tabBarController) {
            self.tabBarController.navigationItem.rightBarButtonItem = rightButtonItem;
        }else{
            self.navigationItem.rightBarButtonItem = rightButtonItem;
        }
    }
    //左边按钮
    if(_leftButtonAction != nil){
        UIBarButtonItem* leftButtonItem = nil;
        leftButtonItem = [[[UIBarButtonItem alloc] initWithTitle:_leftButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(doLeftCallBack)] autorelease];
        if (self.tabBarController) {
            self.tabBarController.navigationItem.leftBarButtonItem = leftButtonItem;
        }else{
        self.navigationItem.leftBarButtonItem = leftButtonItem;
        }
    }
    //默认后退按钮
    if([_leftButtonAction isEqualToString:@"back"]){
        UIBarButtonItem* backButtonItem = [[[UIBarButtonItem alloc] initWithTitle:_leftButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(defaultGoBackAction)] autorelease];
        backButtonItem.title = @"返回";
        //NSLog(@"!! _leftButtontitle = %@, _rightButtonAction = %@",@"+默认返回",@"+默认返回");
        self.navigationItem.leftBarButtonItem = backButtonItem;
    }
}

-(void) defaultGoBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark 初始化view
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = self.view.frame;
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0.0f,0.0f,rect.size.width,rect.size.height-44)];
    [_webview setBackgroundColor:[UIColor whiteColor]];
    //
    [self.view addSubview:_webview];
    //添加bridge4OC+JS
    WebViewBridge* bridge = [[WebViewBridge alloc]init];
    bridge.target = self;
    _webview.delegate = bridge;
    [_webview setScalesPageToFit:YES];

    //处理URL
    NSString *encodedArgs = [_arg stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL* myUrl = nil;
    NSString* encodedUrl = nil;
    NSString* fullUrl = nil;
    if (_url) {//##########加载外部URL#########
        encodedUrl = [_url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        if ([_url rangeOfString:@"://"].location == NSNotFound) {
            fullUrl = [[NSString alloc]initWithFormat:@"http://%@?%@",encodedUrl,encodedArgs];
        }else{
            fullUrl = [[NSString alloc]initWithFormat:@"%@?%@",encodedUrl,encodedArgs];
        }
        NSLog(@"#URL is %@",fullUrl);
        myUrl = [NSURL URLWithString:fullUrl];
    }else if (_fileName) {//##########加载静态HTML#########
        fullUrl = [[NSBundle mainBundle] pathForResource:_fileName ofType:@"html" inDirectory:_path];
        encodedUrl = [fullUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        fullUrl = [[NSString alloc]initWithFormat:@"%@?%@",encodedUrl,encodedArgs];
        NSLog(@"#htmlPath is %@",fullUrl);
        myUrl = [NSURL URLWithString:fullUrl];
    }
    
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:myUrl];
    [_webview loadRequest:request];
}


- (void)viewDidUnload
{
    _webview = nil;
    [super viewDidUnload];
}
- (void)dealloc{
    [_webview release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark
#pragma mark 性能调试方法,
-(void)time:(NSString*)idata{
    NSDictionary* json = [idata objectFromJSONString];
    NSString* o_mark = [json objectForKey:@"mark"];
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    
    NSLog(@"TTY3=%@  ##%@",date,o_mark);
}

-(void)doOpen:(NSString*)idata{
    NSDictionary* json = [idata objectFromJSONString];
    NSString* itype = [json objectForKey:@"type"];
    NSString* iarg = [json objectForKey:@"arg"];
    NSString* iurl = [json objectForKey:@"url"];
    if (!itype ) {
        itype = @"http";
    }
    if (!iarg) {
        iarg = @"";
    }
    
    NSString* encodedUrl = [iurl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSString* encodedArgs = [iarg stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSString* fullUrl = nil;
    if ([iurl rangeOfString:@"://"].location == NSNotFound) {
        fullUrl = [[NSString alloc]initWithFormat:@"%@://%@?%@",itype,encodedUrl,encodedArgs];
    }else{
        fullUrl = [[NSString alloc]initWithFormat:@"%@?%@",encodedUrl,encodedArgs];
    }
    NSURL* myUrl = [NSURL URLWithString:fullUrl];
    //NSLog(@"##openning url %@",fullUrl);
    BOOL result = [[UIApplication sharedApplication] openURL:myUrl];
    
}


@end


