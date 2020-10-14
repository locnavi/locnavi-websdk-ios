//
//  XJLocationService.h
//  XJLocation
//
//  Created by zhangty on 2017/9/25.
//  Copyright © 2017年 LocNavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJUserInfo.h"

@interface XJLocationService : NSObject


@property (nonatomic, readonly)NSString * _Nullable appKey;
//用户信息
@property (nonatomic, strong)XJUserInfo * _Nullable userInfo;
//debug 模式可以请求到测试的地图资料
@property (nonatomic, assign)BOOL       debug;

+ (nonnull instancetype)sharedInstance;

+ (void)initServices:(nonnull NSString *)appKey;

+ (NSString *_Nullable)SDKVersion;

@end
