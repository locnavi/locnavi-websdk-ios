//
//  XJmapLocationManger.h
//  XJmapSDK
//
//  Created by zhangty on 2017/5/18.
//  Copyright © 2017年 XJmap. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XJmapLocationManger;
@class XJLocationInfo;
@protocol XJmapLocationDelegate <NSObject>

- (void)xjmapLocationManager:(XJmapLocationManger *_Nullable)manager didUpdateLocation:(XJLocationInfo *_Nullable)location;

@end

@interface XJmapLocationManger : NSObject

@property (nonatomic, weak, nullable)id<XJmapLocationDelegate> delegate;

@property (nonatomic, assign)NSUInteger locationTimeOut;


- (void)startLocationEngine:(nonnull NSString *)mapId;

- (void)stopLocatingEngine;

@end
