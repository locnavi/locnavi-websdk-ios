//
//  XJLocationInfo.h
//  XJmapSDK
//
//  Created by zhangty on 2017/5/18.
//  Copyright © 2017年 XJmap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface XJLocationInfo : NSObject

@property (nonatomic, assign)BOOL inThisMap;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic, strong)NSString *floor;
@property (nonatomic, strong)NSString *floorDescription;
@property (nonatomic, copy)NSString *strDesc;

@end
