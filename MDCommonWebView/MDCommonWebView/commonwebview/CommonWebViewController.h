//
//  CommonWebViewController.h
//  tcmp
//
//  Created by Mead on 9/21/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonWebViewController : UIViewController{
    NSString* _path;
    NSString* _fileName;
    NSString* _url;
    NSString* _arg;
    NSString* _viewTitle;
    //
    NSString* _leftButtonTitle;
    NSString* _leftButtonIcon;
    NSString* _leftButtonAction;
    NSString* _rightButtonTitle;
    NSString* _rightButtonIcon;
    NSString* _rightButtonAction;
    //inner
    UIWebView* _webview;
}

@property(nonatomic,retain) NSString* path;
@property(nonatomic,retain) NSString* fileName;
@property(nonatomic,retain) NSString* url;
@property(nonatomic,retain) NSString* arg;
@property(nonatomic,retain) NSString* viewTitle;
//
@property(nonatomic,retain) NSString* leftButtonTitle;
@property(nonatomic,retain) NSString* leftButtonIcon;
@property(nonatomic,retain) NSString* leftButtonAction;
@property(nonatomic,retain) NSString* rightButtonTitle;
@property(nonatomic,retain) NSString* rightButtonIcon;
@property(nonatomic,retain) NSString* rightButtonAction;

//inner
@property(nonatomic,retain) UIWebView* webview;

//新建一个CommonWebViewController相当于HTML的<a>标签打开一个新页面
-(void)doRedirect:(NSString*)data;
//绑定右上角js回调
-(void)doRightCallBack;
//绑定左上角js回调
-(void)doLeftCallBack;
//后退方法
-(void)goBack:(NSString*)data;
//通用查询界面
-(void)doSearch:(NSString*)data;
//打开url,调用其它app
-(void)doOpen:(NSString*)data;
//调试性能,计时器
-(void)time:(NSString*)data;

@end
