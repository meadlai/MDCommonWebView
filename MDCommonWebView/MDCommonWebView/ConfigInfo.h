//
//  ConfigInfo.h
//  tcmp
// 所有全局配置参数,都放在这里.
//
//  Created by Mead on 9/12/12.
//  Copyright (c) 2012 Mead. All rights reserved.
//

//##网络NET
//登录地址
//#define NET_URL_LOGIN @"http://192.168.190.150:8080/mtcmp_server/login.jsp"
#define NET_URL_LOGIN @"http://60.191.25.162:7100/login.jsp"

//#define NET_URL_LOGOUT @"http://192.168.190.150:8080/mtcmp_server/logout.jsp"
#define NET_URL_LOGOUT @"http://60.191.25.162:7100/logout.jsp"

//
//#define NET_URL_WORKFLOW_CATALOG @"http://192.168.190.150:8080/mtcmp_server/data.jsp?interfaceid=R8107"
#define NET_URL_WORKFLOW_CATALOG @"http://60.191.25.162:7100/data.jsp?interfaceid=R8107"



//##整形INT
//列表:多少条后,出现[刷新]
#define INT_SHOW_REFRESH_COUNT 3
//列表:[刷新],小菊花滚动,延时时间
#define INT_REFRESH_FINISHED 0.5
//列表:[刷新],view高度
#define INT_REFRESH_HEIGHT 200
//小菊花:停顿秒数
#define INT_POPINFO_DELAY 1.2

//##UI尺寸呢
#define UI_BTN_WIDTH 26
#define UI_BTN_HEIGHT 26

//##UI颜色
//导航条
#define UI_NAV_COLOR [UIColor colorWithRed:20.0/255.0 green:130.0/255.0 blue:211/255.0 alpha:.8]
//高亮按钮
#define UI_BTN_HIGHLIGHT_COLOR [UIColor colorWithRed:5.0/255.0 green:192.0/255.0 blue:0.0 alpha:1.0]
//搜索条,高度
#define UI_SEARCH_BAR_HEIGHT 50

//toolbar底部位置,botton
#define UI_TOOLBAR_POSITION_DOWN CGRectMake(0,367,320,50)
//toolbar顶部位置,top
#define UI_TOOLBAR_POSITION_TOP CGRectMake(0,0,320,50)
//toolbar颜色,top
#define UI_TOOLBAR_BUTTON_COLOR [UIColor colorWithRed:127.0/255.0 green:133.0/255.0 blue:137.0/255.0 alpha:1.0]
//
#define UI_TOOLBAR_BUTTON_HEIGHT 47.5
//5个button以后,显示[更多]
#define UI_TOOLBAR_MORE_INDEX 4

#define KEY_BOOL_SAVE_NAME_PSWD @"KEY_BOOL_SAVE_NAME_PSWD"
#define KEY_BOOL_AUTO_LOGIN @"KEY_BOOL_AUTO_LOGIN"
#define KEY_STRING_USERNAME @"KEY_STRING_USERNAME"
#define KEY_STRING_PASSWORD @"KEY_STRING_PASSWORD"

#define KEK_STRING_USERID @"KEK_STRING_USERID"



#define G_CLIENT_TYPE @"iphone"

#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)






#import <Foundation/Foundation.h>

@interface ConfigInfo : NSObject{
    //NSString* NET_URL_LOGIN;
}

@end
