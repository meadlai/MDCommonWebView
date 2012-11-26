//
//  CommonWebViewController+UICollection.m
//  tcmp
//
//  Created by Mead on 10/15/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//

#import "CommonWebViewController+UICollection.h"


#import "JSONKit.h"
#import "ConfigInfo.h"
#import "CommonWebViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation CommonWebViewController (UICollection)


//ActionSheet
-(void)uiShowActionSheet:(NSString*)idata{
}

//Alert
-(void)uiShowAlert:(NSString*)idata{
    //parse args
    NSDictionary* json = [idata objectFromJSONString];
    NSString* ititle = [json objectForKey:@"title"];
    NSString* imessage = [json objectForKey:@"message"];
    __block NSString* icallback = [[json objectForKey:@"callback"] copy];
    NSString* ibuttons = [json objectForKey:@"buttons"];
    //split it
    NSArray* xbutton= [ibuttons componentsSeparatedByString:@","];
}

@end


