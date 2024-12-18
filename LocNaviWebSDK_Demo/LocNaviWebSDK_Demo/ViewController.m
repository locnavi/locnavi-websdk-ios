//
//  ViewController.m
//  LocNaviWebSDK_Demo
//
//  Created by zhangty on 2020/7/3.
//  Copyright © 2020 locnavi. All rights reserved.
//

#import "ViewController.h"
#import <LocNaviWebSDK/LocNaviWebSDK.h>
#import <XJLocation/XJLocation.h>

@interface ViewController ()<XJmapLocationDelegate, LocNaviNavigationDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfAppKey;
@property (weak, nonatomic) IBOutlet UITextField *tfMapId;
@property (weak, nonatomic) IBOutlet UITextField *tfUserId;
@property (weak, nonatomic) IBOutlet UITextField *tfPoi;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;

@property (nonatomic, strong)XJmapLocationManger *locationManger;

@end

@implementation ViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [LocNaviMapService setNavigationDelegate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tfAppKey.text = [LocNaviMapService sharedInstance].appKey;
    self.tfMapId.text = @"sSNn0QJk3r";
    NSString *userId = [LocNaviMapService sharedInstance].userId;
    if (!userId) {
        NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
        userId = [uuid copy];
    }
    self.tfUserId.text = userId;
    self.tfPoi.text = @"3015";
    [self.btnLocation setTitle:@"开始定位" forState:UIControlStateNormal];
    [self.btnLocation setTitle:@"停止定位" forState:UIControlStateSelected];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self.view addGestureRecognizer:recognizer];
    
    self.locationManger = [XJmapLocationManger new];
    self.locationManger.delegate = self;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localNotification:) name:nil object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localNotification:) name:@"exit-navigation" object:nil];
    [LocNaviMapService setNavigationDelegate:self];
}

//控制定位引擎
- (IBAction)onControlEngine:(UIButton *)btn {
//    if (btn.selected) {
//        [self.locationManger stopLocatingEngine];
//    } else {
//        [self.locationManger startLocationEngine:self.tfMapId.text ? self.tfMapId.text : @"iyJKZCjhrW"];
//    }
//    btn.selected = !btn.selected;
    
// 无界面定位
    LocNaviLocationService *service = [LocNaviLocationService sharedInstance];
    if (btn.selected) {
        [service stop:LocNaviLocationModeAuto];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:LOCNAVI_NOTI_LOCATION object:nil];
    } else {
        [service start:LocNaviLocationModeAuto];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:LOCNAVI_NOTI_LOCATION object:nil];
    }
    btn.selected = !btn.selected;
}

- (IBAction)onShowMap:(UIButton *)btn {
    LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:self.tfMapId.text ? self.tfMapId.text : @"iyJKZCjhrW"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    //只获取当前的定位信息
    [vc getLocation:^(LocNaviLocation * _Nullable location, NSError * _Nullable error) {
        
    }];
    //持续获取定位数据
//    [vc startListenLocation:^(LocNaviLocation * _Nullable location, NSError * _Nullable error) {
//
//    }];
//    [vc stopListenLocation];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)onTap {
    [self.view endEditing:YES];
}

#pragma mark- XJmapLocationDelegate
- (void)xjmapLocationManager:(XJmapLocationManger *_Nullable)manager didUpdateLocation:(XJLocationInfo *_Nullable)location {
    NSMutableString *mutable = [[NSMutableString alloc] init];
    [mutable appendFormat:@"%@\n", location.inThisMap ? @"在院内" : @"不在院内"];
    [mutable appendFormat:@"%lf %lf \n", location.coordinate.longitude, location.coordinate.latitude];
    [mutable appendFormat:@"%@ \n", location.floor];
    [mutable appendFormat:@"%@ \n", location.floorDescription];
    [mutable appendFormat:@"%@ \n", location.strDesc];
    
    self.textView.text = [mutable copy];
}

#pragma mark- 本地通知
- (void)localNotification:(NSNotification *)noti {
    NSLog(@"localNotification:%@", noti.name);
    NSString *str = noti.object;
    if ([noti.name isEqualToString:@"exit-navigation"]) {
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"JSON解析失败 %@", str);
        }
        
    }
}

//无界面定位
- (void)updateLocation:(NSNotification *)noti {
    NSLog(@"收到通知：%@",noti);
    if (noti.object == nil) {
        return;
    }
    LocNaviLocation *loc = noti.object;
    NSMutableString *mutable = [[NSMutableString alloc] init];
    [mutable appendFormat:@"%@\n", loc.inThisMap ? @"在院内" : @"不在院内"];
    [mutable appendFormat:@"%lf %lf \n", loc.coordinate.longitude, loc.coordinate.latitude];
    [mutable appendFormat:@"%@ \n", loc.floor];
    [mutable appendFormat:@"%@ \n", loc.floorDescription];
    [mutable appendFormat:@"%@ \n", loc.strDesc];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 在主线程更新 UI
        self.textView.text = [mutable copy];
    });
}

#pragma mark- LocNaviNavigationDelegate
- (void)locnaviService:(LocNaviMapService *)service didFinishNavigation:(LocNaviLocation *)loc {
    NSLog(@"----%@", loc);
}


@end
