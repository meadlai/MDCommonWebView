//
//  WebViewBridge.h
//  tcmp
//
//  Created by Mead on 9/25/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface WebViewBridge : NSObject<UIWebViewDelegate>{
    id _target;
}
@property(nonatomic,retain)id target;

@end
