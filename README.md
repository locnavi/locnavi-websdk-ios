# LocNaviWebSDK-iOS

LocNaviWebSDK-iOS 是一套基于 iOS 10.0 及以上版本的室内Web地图应用程序开发接口，供开发者在自己的iOS应用中加入室内地图、定位、导航功能。

## 获取AppKey
请点击链接 https://locnavi.com/application 填写相关信息获取AppKey、mapId、

## 使用CocoaPods部署
在Podfile中使用命令如下：
```bash
pod 'LocNaviWebSDK', '~> 0.1.7'
```
然后运行以下命令

```bash
$ pod install
```
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

