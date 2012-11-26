//
//  SearchWebViewController.h
//  tcmp
//
//  Created by Mead on 10/9/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchWebViewController : UIViewController<UISearchBarDelegate>{
    NSString* _path;
    NSString* _fileName;
    NSString* _arg;
    
    NSString* _keyword;
    NSString* _placehold;
    NSString* _callback;
//  NSString* _cancelAction;
//  NSString* _searchActon;
    
    //inner
    UIWebView* _webview;
    UISearchBar* _searchbar;

}

@property(nonatomic,retain) NSString* path;
@property(nonatomic,retain) NSString* fileName;
@property(nonatomic,retain) NSString* arg;
@property(nonatomic,retain) NSString* keyword;
@property(nonatomic,retain) NSString* placehold;
@property(nonatomic,retain) NSString* callback;
//inner
@property(nonatomic,retain) UIWebView* webview;

-(id) initWithLocalFilePath:(NSString*)path withFileName:(NSString*)fileName withArg:(NSString*)arg callback:(NSString*)callback;

@end
