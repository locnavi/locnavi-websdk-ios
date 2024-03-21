//
//  AppDelegate.m
//  LocNaviWebSDK_Demo
//
//  Created by zhangty on 2020/7/3.
//  Copyright © 2020 locnavi. All rights reserved.
//

#import "AppDelegate.h"
#import <LocNaviWebSDK/LocNaviWebSDK.h>
#import <XJLocation/XJLocation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置访问的h5服务url
    //[LocNaviMapService setServerUrl:@"https://"];
    [LocNaviMapService setAppKey:@"HnHWJWhx0E"];
    //获取到用户信息之后,设置userId即可
    NSString * uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    [LocNaviMapService setUserId:uuid];
//    [XJLocationService initServices: @"lzDrdAv0y5"];
//    XJUserInfo *user = [XJUserInfo new];
//    user.userId = uuid;
//    [XJLocationService sharedInstance].userInfo = user;
    
    //无界面定位相关
    LocNaviLocationService *service= [LocNaviLocationService sharedInstance];
    //mapId一定要设置
    [service setMapId:@"sSNn0QJk3r"];
    //定位相关的url，一般情况可不用设置
    [service setServerUrl:@"https://l.locnavi.com"];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
