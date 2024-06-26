//
//  LocNaviWebViewController.h
//  LocNaviWebSDK
//
//  Created by zhangty on 2020/7/3.
//  Copyright © 2020 locnavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "LocNaviLocation.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^LNLocationBlcok)(LocNaviLocation * _Nullable location, NSError * _Nullable error);

@interface LocNaviWebViewController : UIViewController

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign)BOOL isReady;

- (nonnull instancetype)initWithMapId:(nullable NSString *)mapId;

- (nonnull instancetype)initWithMapId:(nonnull NSString *)mapId poi:(nonnull NSString*)poiId;
//params支持 search=ceshi&poi=1,2传参凭借到链接中
- (nonnull instancetype)initWithMapId:(NSString *)mapId params:(nonnull NSString*)params;

//获取当前定位数据
- (void)getLocation:(_Nullable LNLocationBlcok)handler;
//持续获取当前定位数据
- (void)startListenLocation:(_Nullable LNLocationBlcok)handler;
//停止获取获取当前定位数据
- (void)stopListenLocation;
//传递扫描到的beacons
- (void)updateBeacons:(NSArray *)beacons error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
