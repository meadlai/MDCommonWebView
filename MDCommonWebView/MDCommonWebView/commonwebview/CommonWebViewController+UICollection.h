//
//  CommonWebViewController+UICollection.h
//  tcmp
//
//  Created by Mead on 10/15/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//

#import "CommonWebViewController.h"

//category,所有的UI渲染都在这里.
@interface CommonWebViewController (UICollection){
}

//显示ui界面:底部按钮列表
-(void)uiShowActionSheet:(NSString*)data;

//显示ui界面:Action操作
-(void)uiShowAlert:(NSString*)idata;
@end
