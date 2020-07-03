//
//  ViewController.m
//  LocNaviWebSDK_Demo
//
//  Created by zhangty on 2020/7/3.
//  Copyright © 2020 locnavi. All rights reserved.
//

#import "ViewController.h"
#import <LocNaviWebSDK/LocNaviWebSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"进入地图" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onShowMap) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [self.view addSubview:btn];
}

- (void)onShowMap {
    NSLog(@"sss");
    LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:@"HHrzBwF5dY"];
    vc.view.backgroundColor = [UIColor blueColor];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
