//
//  LocNaviLocation.h
//  LocNaviWebSDK
//
//  Created by zhangty on 2022/7/20.
//  Copyright © 2022 locnavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocNaviRegion.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocNaviLocation : NSObject

@property (nonatomic, assign)BOOL inThisMap;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
//默认wgs84
@property (nonatomic, strong)NSString *coordSystem;
@property (nonatomic, strong)NSString *floor;
@property (nonatomic, strong)NSString *floorDescription;
@property (nonatomic, copy)NSString *strDesc;
@property (nonatomic, strong)NSArray<LocNaviRegion *> *region;
@property (nonatomic, strong)LocNaviRegion *nearestRegion;

+ (LocNaviLocation *)infoWithData:(NSDictionary *)dic;
+ (LocNaviLocation *)infoWithJSONString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
