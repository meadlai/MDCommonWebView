//
//  SearchWebViewController.m
//  tcmp
//
//  Created by Mead on 10/9/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//

#import "SearchWebViewController.h"
#import "ConfigInfo.h"
#import "WebViewBridge.h"

@interface SearchWebViewController ()


@end

@implementation SearchWebViewController

@synthesize path = _path;
@synthesize fileName = _fileName;
@synthesize arg = _arg;
@synthesize keyword = _keyword;
@synthesize placehold = _placehold;
@synthesize callback = _callback;
//
@synthesize webview = _webview;

-(id) initWithLocalFilePath:(NSString*)path withFileName:(NSString*)fileName withArg:(NSString*)arg callback:(NSString*)callback{
    if(self=[super init]){
        _path = [path copy];
        _fileName = [fileName copy];
        _arg = [arg copy];
        _callback = [callback copy];
        return self;
    }
    return nil;
}

- (void)viewDidLoad
{
    //###############
    //TODO:debuging code
    if (!_path) {
        _path = @"html";
    }
    if(!_callback){
        _callback = @"doSearchAction";
    }
    if(!_placehold){
        _placehold = @"Enter...";
    }
    //###############
    [super viewDidLoad];
    
    //searchbar
    _searchbar = [[UISearchBar alloc]
                                initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, UI_SEARCH_BAR_HEIGHT)];
    _searchbar.delegate = self;
    _searchbar.showsCancelButton = YES;
    _searchbar.barStyle=UIBarStyleDefault;
    _searchbar.keyboardType=UIKeyboardTypeNamePhonePad;
    //
    if (_placehold) {
        _searchbar.placeholder=_placehold;
    }
    if(_keyword){
        _searchbar.text = _keyword;
    }
    [self.view addSubview:_searchbar];
    [_searchbar becomeFirstResponder];
    
    //webview
    CGRect rect = self.view.frame;
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0.0f,UI_SEARCH_BAR_HEIGHT,rect.size.width,rect.size.height-UI_SEARCH_BAR_HEIGHT)];
    //
    NSLog(@"!! webview.frame.size.height = %f",rect.size.height);
    //_webview = [[UIWebView alloc]initWithFrame:CGRectMake(0.0f,0.0f,320,640)];
    [self.view addSubview:_webview];
    //添加bridge4OC+JS
    WebViewBridge* bridge = [[WebViewBridge alloc]init];
    bridge.target = self;
    _webview.delegate = bridge;
    
    //TODO:重构为一个方法,加载webview的内容项目.
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:_fileName ofType:@"html" inDirectory:_path];
    NSString *encodedPath = [htmlPath stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSString *encodedArgs = [_arg stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    htmlPath = [[NSString alloc]initWithFormat:@"%@?%@",encodedPath,encodedArgs];
    NSLog(@"SearchWebViewController#htmlPath is %@",htmlPath);
    NSURL *htmlUrl = [NSURL URLWithString:htmlPath];
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:htmlUrl];
    //
    [_webview loadRequest:request];
    
    return;
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // called when keyboard search button pressed
    NSString* inputKWD = searchBar.text;
    NSLog(@"searching keyword is %@",inputKWD);
    NSString* jsAction = [[NSString alloc]initWithFormat:@"%@('%@')",_callback,inputKWD];
    [_webview stringByEvaluatingJavaScriptFromString:jsAction];
    NSLog(@"==========search Clicked, action is: %@",jsAction);
    [jsAction release];
    
    [_searchbar resignFirstResponder];
//    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"搜索" message:@"矮油!!! 空空如也..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
    //[self.navigationController popViewControllerAnimated:NO];

}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    // called when cancel button pressed
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload{
    _searchbar = nil;
    [super viewDidUnload];
}

-(void)dealloc{
    [_searchbar release];
    [super dealloc];
}

//取消按钮处理.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    // Search for Cancel button in searchbar, enable it and add key-value observer.
    for (id subview in [_searchbar subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview setEnabled:YES];
            [subview addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
            UIButton *btn = (UIButton *)subview;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn autorelease];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    // Remove observer for the Cancel button in searchBar.
    for (id subview in [_searchbar subviews]) {
        if ([subview isKindOfClass:[UIButton class]]){
            [subview removeObserver:self forKeyPath:@"enabled"];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // Re-enable the Cancel button in searchBar.
    if ([object isKindOfClass:[UIButton class]] && [keyPath isEqualToString:@"enabled"]) {
        UIButton *button = object;
        if (!button.enabled){
            button.enabled = YES;
        }
    }
}

@end
