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

@interface ViewController ()<XJmapLocationDelegate>

@property (nonatomic, strong)XJmapLocationManger *locationManger;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"启动引擎" forState:UIControlStateNormal];
    [btn setTitle:@"停止引擎" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(onControlEngine:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(50, 100, 100, 40);
    [self.view addSubview:btn];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 setTitle:@"进入地图" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(onShowMap) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(170, 100, 100, 40);
    [self.view addSubview:btn2];
    
    self.locationManger = [XJmapLocationManger new];
    self.locationManger.delegate = self;
}

- (void)onControlEngine:(UIButton *)btn {
    if (btn.selected) {
        [self.locationManger stopLocatingEngine];
    } else {
        [self.locationManger startLocationEngine:@"HHrzBwF5dY"];
    }
    btn.selected = !btn.selected;
}

- (void)onShowMap {
    NSLog(@"sss");
    LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:@"HHrzBwF5dY"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)xjmapLocationManager:(XJmapLocationManger *_Nullable)manager didUpdateLocation:(XJLocationInfo *_Nullable)location {
    NSLog(@"%@", location.inThisMap ? @"在院内" : @"不在院内");
    NSLog(@"%lf %lf", location.coordinate.longitude, location.coordinate.latitude);
    NSLog(@"%@", location.floor);
    NSLog(@"%@", location.floorDescription);
    NSLog(@"%@", location.strDesc);
}


@end
