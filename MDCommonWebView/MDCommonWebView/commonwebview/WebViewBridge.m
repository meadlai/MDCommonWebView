//
//  WebViewBridge.m
//  tcmp
//
//  Created by Mead on 9/25/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//

#import "WebViewBridge.h"
#import <Foundation/Foundation.h>

@implementation WebViewBridge
@synthesize target = _target;




- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    //NSLog(@"----scheme is %@",scheme);
    if ([[url scheme] isEqualToString:@"meadprotocal"]) {
        NSString* encodeURL = [url description];
        NSString *normal = [encodeURL stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSRange range = [normal rangeOfString:@":"];
        normal = [normal substringFromIndex:range.location+1];
        //切分url
        range = [normal rangeOfString:@"?"];
        NSString* method = [normal substringToIndex:range.location];
        NSString* args = [normal substringFromIndex:range.location+1];
//        NSLog(@"---------代理target值为：%@",[_target class]);
//        NSLog(@"---------截取的method值为：%@",method);
//        NSLog(@"---------截取的args值为：%@",args);
        NSString* selectString = [[NSString alloc] initWithFormat:@"%@:",method];
        
        [_target performSelector:NSSelectorFromString(selectString) withObject:args];
        return NO;
    } else {
        
        return YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //统一处理错误
}

-(void)dealloc{
    [_target dealloc];
    [super dealloc];
}

@end
