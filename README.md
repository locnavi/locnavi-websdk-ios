# LocNaviWebSDK-iOS

LocNaviWebSDK-iOS 是一套基于 iOS 8.0 及以上版本的室内Web地图应用程序开发接口，供开发者在自己的iOS应用中加入室内地图、定位、导航功能。

## 获取AppKey
请点击链接 https://locnavi.com/application 填写相关信息获取AppKey、mapId、

## 使用CocoaPods部署
在Podfile中使用命令如下：
```bash
pod 'LocNaviWebSDK', '~> 0.0.5'
```
然后运行以下命令

```bash
$ pod install
```
### 注意
导入LocNaviWebSDK后需要
- 在Info.plist中添加授权申明
```bash
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>App会在室外定位及导航等服务中使用您的位置信息</string>
  ```
  
## 使用说明
### SDK初始化
  在 didFinishLaunchingWithOptions里面添加以下代码即可，appKey为邮件中获取的
```objective-c
    //初始化SDK
    [LocNaviMapService setAppKey:@"nqB6HPIU2C"];
    //获取到用户信息之后,设置userId即可
    [LocNaviMapService setUserId:@"demo"];
```
### 显示室内地图
```objective-c
    LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:@"HHrzBwF5dY"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
```


