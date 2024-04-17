# LocNaviWebSDK-iOS

LocNaviWebSDK-iOS 是一套基于 iOS 10.0 及以上版本的室内Web地图应用程序开发接口，供开发者在自己的iOS应用中加入室内地图、定位、导航功能。

## 获取AppKey
请点击链接 https://locnavi.com/application 填写相关信息获取AppKey、mapId、

## 使用CocoaPods部署
在Podfile中使用命令如下：
```bash
pod 'LocNaviWebSDK', '~> 0.1.14'
```
然后运行以下命令

```bash
$ pod install
```

## 手动集成
1. 将SDK文件中包含的LocNaviWebSDK.framework添加到工程中。
2. 开发者需要在工程中链接上： "CoreLocation", "WebKit"。
3. 同时需要在Embedded Binaries 中链接上LocNaviWebSDK.framework(动态链接库）

### 注意
导入LocNaviWebSDK后需要
- 在Info.plist中添加授权申明
```bash
  <key>NSBluetoothAlwaysUsageDescription</key>
	<string>室内定位需要使用蓝牙功能</string>
	<key>NSCameraUsageDescription</key>
	<string>AR需要使用摄像头功能</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>请求在App使用期间使用定位功能</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>请求在App使用期间使用定位功能</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>语音识别需要用到麦克风功能</string>
	<key>NSSpeechRecognitionUsageDescription</key>
	<string>请求在App使用期间使用语音识别功能</string>
  ```
  
## 使用说明
### SDK初始化
  在 didFinishLaunchingWithOptions里面添加以下代码即可，appKey为邮件中获取的
```objective-c
    //初始化SDK
    [LocNaviMapService setAppKey:@"nqB6HPIU2C"];
    //获取到用户信息之后,设置userId即可
    [LocNaviMapService setUserId:@"demo"];
    //设置访问的h5服务地址
    [LocNaviMapService setServerUrl:@"h5服务url"];
```
### 显示室内地图
```objective-c
    LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:@"HHrzBwF5dY"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
```

### 显示室内地图并打开相应的poi，若定位成功会立刻规划路径
```objective-c
    //poi若传入的是中文则需要urlencode后再传入
    LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:@"HHrzBwF5dY" poi:@"123"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
```

### 显示室内地图并执行一些特殊操作
```objective-c
    //poi若传入的是中文则需要urlencode后再传入, search=123&k=1,2,3
    LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:@"HHrzBwF5dY" params:@"search=%E5%8E%95%E6%89%80"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
```

### 获取当前定位数据
```objective-c
    [vc getLocation:^(LocNaviLocation * _Nullable location, NSError * _Nullable error) {
        
    }];
```

### 持续获取定位数据
```objective-c
    //开始获取
    [vc startListenLocation:^(LocNaviLocation * _Nullable location, NSError * _Nullable error) {

    }];
    //停止获取
    [vc stopListenLocation];
```

### 导航事件-完成导航回调
```objective-c
    //添加监听
    [LocNaviMapService setNavigationDelegate:self];
    //回调
    - (void)locnaviService:(LocNaviMapService *)service didFinishNavigation:(LocNaviLocation *)loc {
    
    }
    //不用时可以移除
    [LocNaviMapService setNavigationDelegate:NULL];
```

### 不显示WebView时就能Beacon定位 (需要定位授权)
```java
    //提前设置相关参数
    LocNaviLocationService *service= [LocNaviLocationService sharedInstance];
    //mapId一定要设置
    [service setMapId:@"sSNn0QJk3r"];
    //定位相关的url，一般情况可不用设置
    [service setServerUrl:@"https://l.locnavi.com"];
    
    //开始定位
    LocNaviLocationService *service = [LocNaviLocationService sharedInstance];
    //可指定只开启蓝牙定位，暂时未使用GPS定位，默认使用LocNaviConstants.LOCATION_MODE_AUTO
    //service.start(LocNaviConstants.LOCATION_MODE_ONLY_BEACON);
    //[service start:LocNaviLocationModeAuto];
    //获取更详细的定位信息
    [service start:LocNaviLocationModeAuto detail:YES];
    //添加广播监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:LOCNAVI_NOTI_LOCATION object:nil];

    - (void)updateLocation:(NSNotification *)noti {
      //noti.object 传递LocNaviLocation对象
      NSLog(@"收到通知：%@",noti);
    }

    //停止定位
    [service stop:LocNaviLocationModeAuto];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOCNAVI_NOTI_LOCATION object:nil];
```

### 本地广播
目前添加了以下几个通知
取消(退出)导航：exit-navigation
退出路径规划：exit-route
完成导航：navigation-done
已在目的地：already-there
实时定位：location
```objective-c
    //添加监听，自行决定添加的地方，但需要在不需要的时候移除监听
    - (void)viewDidLoad {
      [super viewDidLoad];
    
      //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localNotification:) name:nil object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localNotification:) name:@"exit-navigation" object:nil];
    
    }

    //移除监听
    - (void)dealloc {
      [[NSNotificationCenter defaultCenter] removeObserver:self];
    }

    //数据处理
    - (void)localNotification:(NSNotification *)noti {
      NSString *str = noti.object;
      if ([noti.name isEqualToString:@"exit-navigation"]) {
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"JSON解析失败 %@", str);
        }
        //数据解析...
      }
    }
    
```
