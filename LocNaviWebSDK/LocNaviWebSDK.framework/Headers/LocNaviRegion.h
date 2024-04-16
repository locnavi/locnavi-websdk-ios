//
//  LocNaviRegion.h
//  LocNaviWebSDK
//
//  Created by zhangty on 2024/4/16.
//  Copyright © 2024 locnavi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocNaviRegion : NSObject

@property (nonatomic, copy)NSString *uuid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *level;
@property (nonatomic, copy)NSNumber *area;
@property (nonatomic, copy)NSNumber *distance;

+ (LocNaviRegion *)infoWithData:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
