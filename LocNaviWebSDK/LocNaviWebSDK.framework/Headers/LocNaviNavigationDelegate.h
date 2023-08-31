//
//  LocNaviNavigationDelegate.h
//  LocNaviWebSDK
//
//  Created by zhangty on 2023/8/30.
//  Copyright © 2023 locnavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocNaviMapService.h"
#import "LocNaviLocation.h"

#ifndef LocNaviNavigationDelegate_h
#define LocNaviNavigationDelegate_h



//导航事件回调
@class LocNaviMapService;
@protocol LocNaviNavigationDelegate <NSObject>


//导航结束返回
- (void)locnaviService:(LocNaviMapService *)service didFinishNavigation:(LocNaviLocation *)loc;

@end

#endif /* LocNaviNavigationDelegate_h */
