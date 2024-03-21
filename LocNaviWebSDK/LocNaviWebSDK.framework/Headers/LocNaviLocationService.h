//
//  LocNaviLocationService.h
//  LocNaviWebSDK
//
//  Created by zhangty on 2024/3/19.
//  Copyright © 2024 locnavi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LocNaviLocationModeAuto,
    LocNaviLocationModeOnlyBeacon,
    LocNaviLocationModeOnlyGPS,
    LocNaviLocationModeGPSAndBeacon
} LocNaviLocationMode;

#define LOCNAVI_NOTI_LOCATION   @"LOCNAVI_NOTI_LOCATION"

@interface LocNaviLocationService : NSObject

+ (nonnull instancetype)sharedInstance;
//有预设值，也可设置定位用的服务器地址
- (void)setServerUrl:(NSString *)serverUrl;
//无界面定位需要指定MapId
- (void)setMapId:(nonnull NSString *)mapId;

//开始定位
- (void)start:(LocNaviLocationMode)mode;
//停止定位
- (void)stop:(LocNaviLocationMode)mode;

//WebView接收beacon数据，此处停止网络定位
- (void)startReceiveBeacon:(id)delegate;
- (void)stopReceiveBeacon;

@end

NS_ASSUME_NONNULL_END
