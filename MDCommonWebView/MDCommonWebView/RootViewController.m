//
//  MainViewController.m
//  tcmp
//
//  Created by Mead on 9/11/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//

#import "RootViewController.h"
#import "CommonWebViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

#pragma mark
#pragma mark 初始化tab页面
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0.0f,0.0f,320,460);
    //
    CommonWebViewController* newVC = [[CommonWebViewController alloc]init];
    newVC.path = @"html";
    newVC.fileName = @"tab1_new";
    newVC.arg = @"date=2012&count=21";
    newVC.viewTitle = @"新闻";
    newVC.rightButtonTitle = @"刷新";
    newVC.rightButtonAction = @"doRightCallBack";
    newVC.leftButtonTitle = @"搜索";
    newVC.leftButtonAction = @"doLeftCallBack";
    newVC.title = @"新闻";
    [newVC autorelease];
    //
    CommonWebViewController* messageVC = [[CommonWebViewController alloc]init];
    messageVC.path = @"html";
    messageVC.fileName = @"tab2_message";
    messageVC.arg = @"date=2012&count=21";
    messageVC.viewTitle = @"消息";
    messageVC.rightButtonTitle = @"新建";
    messageVC.rightButtonAction = @"doRightCallBack";
    messageVC.title = @"消息";
    [messageVC autorelease];
    //
    CommonWebViewController* settingVC = [[CommonWebViewController alloc]init];
    settingVC.path = @"html";
    settingVC.fileName = @"tab3_setting";
    settingVC.viewTitle = @"设置";
    settingVC.title = @"设置";
    [settingVC autorelease];
    //
    self.viewControllers = [[NSArray alloc]initWithObjects:newVC,messageVC,settingVC,nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
