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

@property (nonatomic, copy)NSString *uuid;  //唯一id
@property (nonatomic, copy)NSString *name;  //名称
@property (nonatomic, copy)NSString *level; //级别，2:院外、3院内、4：院内室外、5：楼栋、10：楼层、20：科室病区、25：小病区、30：房间
@property (nonatomic, copy)NSNumber *area;  //面积, 所在Region按面积从小到大返回
@property (nonatomic, copy)NSNumber *distance;  //距离（米），最近的region会有值

+ (LocNaviRegion *)infoWithData:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
