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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [LocNaviMapService setAppKey:@"nqB6HPIU2C"];
    //获取到用户信息之后,设置userId即可
    NSString * uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    [LocNaviMapService setUserId:uuid];
    [XJLocationService initServices: @"nqB6HPIU2C"];
    XJUserInfo *user = [XJUserInfo new];
    user.userId = uuid;
    [XJLocationService sharedInstance].userInfo = user;
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
