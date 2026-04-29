# LocNaviWebSDK-iOS

LocNaviWebSDK-iOS 是一套基於 iOS 10.0 及以上版本的室內 Web 地圖應用程式開發介面，供開發者在自己的 iOS 應用中加入室內地圖、定位、導航功能。

## 獲取 AppKey
appKey、mapId、targetName、targetId 請向 richard.chin@locnavi.com 申請。

## 使用 CocoaPods 部署
在 `Podfile` 中使用如下命令：
```bash
pod 'LocNaviWebSDK', '~> 0.1.17'
```
然後執行以下命令：

```bash
$ pod install
```

## 手動整合
1. 將 SDK 文件中包含的 `LocNaviWebSDK.framework` 新增到工程中。
2. 開發者需要在工程中連結： `CoreLocation`, `WebKit`。
3. 同時需要在 **Embedded Binaries** 中連結 `LocNaviWebSDK.framework`（動態連結函式庫）。

### 注意事項
匯入 LocNaviWebSDK 後需要：
- 在 `Info.plist` 中新增授權聲明：
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>室內定位需要使用藍牙功能</string>
<key>NSCameraUsageDescription</key>
<string>AR需要使用攝影機功能</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>請求在App使用期間使用定位功能</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>請求在App使用期間使用定位功能</string>
<key>NSMicrophoneUsageDescription</key>
<string>語音識別需要用到麥克風功能</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>請求在App使用期間使用語音識別功能</string>
```

---

## 使用說明
### SDK 初始化
在 `didFinishLaunchingWithOptions` 裡面新增以下程式碼即可，`appKey` 為郵件中獲取的：
```objective-c
// 初始化 SDK
[LocNaviMapService setAppKey:@"nqB6HPIU2C"];
// 獲取到使用者資訊之後, 設置 userId 即可
[LocNaviMapService setUserId:@"demo"];
// 設置訪問的 H5 服務地址
[LocNaviMapService setServerUrl:@"h5服務url"];
```

### 顯示室內地圖
```objective-c
LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:@"HHrzBwF5dY"];
vc.modalPresentationStyle = UIModalPresentationFullScreen;
[self presentViewController:vc animated:YES completion:nil];
```

### 顯示室內地圖並開啟相應的 POI
若定位成功會立刻規劃路徑：
```objective-c
// poi 若傳入的是中文則需要 urlencode 後再傳入
LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:@"HHrzBwF5dY" poi:@"123"];
vc.modalPresentationStyle = UIModalPresentationFullScreen;
[self presentViewController:vc animated:YES completion:nil];
```

### 顯示室內地圖並執行特定操作
```objective-c
// poi 若傳入的是中文則需要 urlencode 後再傳入, 例如: search=123&k=1,2,3
LocNaviWebViewController *vc = [[LocNaviWebViewController alloc] initWithMapId:@"HHrzBwF5dY" params:@"search=%E5%8E%95%E6%89%80"];
vc.modalPresentationStyle = UIModalPresentationFullScreen;
[self presentViewController:vc animated:YES completion:nil];
```

### 獲取當前定位數據
```objective-c
[vc getLocation:^(LocNaviLocation * _Nullable location, NSError * _Nullable error) {
    
}];
```

### 持續獲取定位數據
```objective-c
// 開始獲取
[vc startListenLocation:^(LocNaviLocation * _Nullable location, NSError * _Nullable error) {

}];
// 停止獲取
[vc stopListenLocation];
```

### 導航事件 - 完成導航回呼
```objective-c
// 新增監聽
[LocNaviMapService setNavigationDelegate:self];

// 回呼方法
- (void)locnaviService:(LocNaviMapService *)service didFinishNavigation:(LocNaviLocation *)loc {
    
}

// 不使用時可以移除
[LocNaviMapService setNavigationDelegate:NULL];
```

### 不顯示 WebView 時進行 Beacon 定位 (需要定位授權)
```objective-c
// 提前設置相關參數
LocNaviLocationService *service = [LocNaviLocationService sharedInstance];
// mapId 一定要設置
[service setMapId:@"sSNn0QJk3r"];
// 定位相關的 url，一般情況可不用設置
[service setServerUrl:@"https://l.locnavi.com"];

// 開始定位
// 可指定只開啟藍牙定位，暫時未使用 GPS 定位，預設使用 LocNaviConstants.LOCATION_MODE_AUTO
// [service start:LocNaviLocationModeAuto];
// 獲取更詳細的定位資訊
[service start:LocNaviLocationModeAuto detail:YES];

// 預設每秒返回定位，若調用下面方法，請確保 ScanPeriods 大於 1000。
[service updateScanPeriods:1500 betweenScanPeriod:1000];

// 新增廣播監聽
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:LOCNAVI_NOTI_LOCATION object:nil];

- (void)updateLocation:(NSNotification *)noti {
    // noti.object 傳遞 LocNaviLocation 物件
    NSLog(@"收到通知：%@", noti);
}

// 停止定位
[service stop:LocNaviLocationModeAuto];
[[NSNotificationCenter defaultCenter] removeObserver:self name:LOCNAVI_NOTI_LOCATION object:nil];
```

### 本地廣播
目前新增了以下幾個通知：
- 取消 (退出) 導航：`exit-navigation`
- 退出路徑規劃：`exit-route`
- 完成導航：`navigation-done`
- 已在目的地：`already-there`
- 即時定位：`location`

```objective-c
// 新增監聽，自行決定新增的地方，但需要在不需要時移除監聽
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localNotification:) name:@"exit-navigation" object:nil];
}

// 移除監聽
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 數據處理
- (void)localNotification:(NSNotification *)noti {
    NSString *str = noti.object;
    if ([noti.name isEqualToString:@"exit-navigation"]) {
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"JSON 解析失敗 %@", str);
        }
        // 數據解析...
    }
}
```
