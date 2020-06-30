//
//  AppDelegate.m
//  回收
//
//  Created by 李晓满 on 2020/3/11.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "AppDelegate.h"
#import "LxmTabBarVC.h"
#import "LxmLoginVC.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LYGuideViewController.h"
#import "HSPayTwoVC.h"
#import "LTSCOrderDetailVC.h"
//https://huishou.zftgame.com/normal/index.html   回收的用户协议
//https://huishou.zftgame.com/normal/yinse.html   回收的隐私政策
//https://huishou.zftgame.com/normal/yyunfei.html   回收的运费说明
//https://www.zmzt99.com/submit/submitRule.html 电商的用户协议

//https://lanhuapp.com/url/YR5KS-b3iNv   电商
//https://lanhuapp.com/url/KCZf4-VpZB9   回收
//https://www.czmakj.com/collect/API%E6%96%87%E6%A1%A3.html
//禅道 http://www.biuworks.com/zentao/user-login.html
#define HuanXin_AppKey @"1109200401065660#happybuy"
#define HuanXin_ClientID @"YXA6BamKTFFURNq0UkMbx4aBdg"
#define HuanXin_ClientSecret @"YXA6xOVoGkR4fi9LXTMOocb6k-ke8Gw"

#define UMKey @"5eb3873a167edd7ff40002a6"
#define UMSecert @"ctx7jj2elfiucnqkzb0wkixqjf80s3ga"


//新浪
#define SinaAppKey @"3386016286"
#define SinaAppSecret @"081a4efee947710f9082ab3f0a7b8de8"

//微信
#define WXAppID @"wxfddee11c3b802965"
#define WXAppSecret @"894c75fccdcb602c3ddc5484837b6abd"

//QQ
#define QQAppID @"1110578584"
#define QQAppKey @"jGXKaMYUoJgFyasP"

//回收苹果帐号：yipbwf@163.com     中富通公司名称
//帐号密码：Hh11223344
//邮箱密码：m61555
//验证手机：13316478532

@interface AppDelegate ()<UNUserNotificationCenterDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
 
    
    self.window.rootViewController = [self instantiateRootVC];
    
    
    [WXApi registerApp:WXAppID universalLink:@"https://www.zftgame.com/huishou/"];
    [self initPush];
    [self initUMeng:launchOptions];
    
    // U-Share 平台设置
    [self configUSharePlatforms];
    
    [self initHuanXin];
    
   
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)configUSharePlatforms
{
    
    //打开图片水印
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    //关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID/*设置QQ平台的appID*/  appSecret:QQAppKey redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    
}

-(void)initPush
{
    //1.向系统申请推送
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    }
    else
    {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
}


-(void)initUMeng:(NSDictionary *)launchOptions
{
    [UMConfigure initWithAppkey:UMKey channel:@"App Store"];
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
        
    } else {
        // Fallback on earlier versions
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        
        if (error) {
            NSLog(@"error===%@",error.description);
        }
        
        if (granted) {
            
        }else{
        }
    }];
    
}



//设置根视图控制器
- (UIViewController *)instantiateRootVC{
    
    //    //没有引导页
    //    TabBarController *BarVC=[[TabBarController alloc] init];
    //    return BarVC;
    
    
    
    //获取app运行的版本号
    NSString *currentVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    //取出本地缓存的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [defaults objectForKey:@"appversion"];
    if ([currentVersion isEqualToString:localVersion]) {
        
        LxmTabBarVC * tabrVC =  [LxmTabBarVC new];
        
        return tabrVC;
        //        TabBarController * tabVc = [[TabBarController alloc] init];
        //        return tabVc;
        
    }else{
        LYGuideViewController *guideVc = [[LYGuideViewController alloc] init];
        return guideVc;
    }
}

//跳转主页
- (void)showHomeVC{
    self.window.rootViewController = [LxmTabBarVC new];
    //更新本地储存的版本号
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"appversion"];
    //同步到物理文件存储
    [[NSUserDefaults standardUserDefaults] synchronize];
}




- (BOOL)initLocationPush:(UIApplication *)application finishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
    [application registerUserNotificationSettings:setting];
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 这里添加处理代码
    }
    return YES;
}

//iOS10以下使用这两个方法接收通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    //过滤掉Push的撤销功能，因为PushSDK内部已经调用的completionHandler(UIBackgroundFetchResultNewData)，
    //防止两次调用completionHandler引起崩溃
    if(![userInfo valueForKeyPath:@"aps.recall"])
    {
        completionHandler(UIBackgroundFetchResultNewData);
    }
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"===\n3===%@",userInfo);
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [UMessage didReceiveRemoteNotification:userInfo];
            [UMessage setAutoAlert:NO];
            //应用处于前台时的远程推送接受
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
            
            
            LxmPushModel *model = [LxmPushModel mj_objectWithKeyValues:userInfo];
            // 1-系统通知(infoUrl有值时跳转)，2-订单消息(跳转订单详情) 3-普通消息(不做操作) 4-充值成功(跳转充值结果页面) 5-充值失败(跳转充值结果页面)
            LxmTabBarVC * bar = (LxmTabBarVC *)self.window.rootViewController;
//            bar.selectedIndex = 0;
            BaseNavigationController * nav  = (BaseNavigationController *)bar.selectedViewController;
            [self pageTo:model nav:nav];
            
        }else{
            //应用处于前台时的本地推送接受
            LxmPushModel *model = [LxmPushModel mj_objectWithKeyValues:userInfo];
            // 1-系统通知(infoUrl有值时跳转)，2-订单消息(跳转订单详情) 3-普通消息(不做操作) 4-充值成功(跳转充值结果页面) 5-充值失败(跳转充值结果页面)
            LxmTabBarVC * bar = (LxmTabBarVC *)self.window.rootViewController;
//            bar.selectedIndex = 0;
            BaseNavigationController * nav  = (BaseNavigationController *)bar.selectedViewController;
            [self pageTo:model nav:nav];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
    
    
    
}



//在用户接受推送通知后系统会调用
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    //    self.pushToken = deviceToken;
    //    if (![LxmTool ShareTool].isClosePush)
    //    {
    [UMessage registerDeviceToken:deviceToken];
    NSString * token = @"";
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13) {
        if (![deviceToken isKindOfClass:[NSData class]]) {
            //记录获取token失败的描述
            return;
        }
        const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
        token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                 ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                 ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                 ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        NSLog(@"deviceToken1:%@", token);
    } else {
        token = [NSString
                 stringWithFormat:@"%@",deviceToken];
        token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        
    }
    //将deviceToken给后台
    NSLog(@"send_token:%@",token);
    [LxmTool ShareTool].deviceToken = token;
    [[LxmTool ShareTool] uploadDeviceToken];
    
}
//10一下的系统
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [UMessage didReceiveRemoteNotification:userInfo];
    
    NSLog(@"===\n1===%@",userInfo);
    
    LxmPushModel *model = [LxmPushModel mj_objectWithKeyValues:userInfo];
    if (![LxmTool ShareTool].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"您目前处于离线状态"];
        return;
    }
    //1-系统通知，2-代理变动，3-钱包消息，4-接单消息，5-订单消息，6-投诉消息，7-素材消息
    LxmTabBarVC * bar = (LxmTabBarVC *)self.window.rootViewController;
//    bar.selectedIndex = 0;
    BaseNavigationController * nav  = (BaseNavigationController *)bar.selectedViewController;
    [self pageTo:model nav:nav];
    
}

- (void)pageTo:(LxmPushModel *)model nav:(BaseNavigationController *)nav {

    NSInteger type = model.infoType.intValue;
    if ( type == 1) {
        if (model.infoUrl.isValid) {
                       LxmWebViewController *vc = [[LxmWebViewController alloc] init];
                       vc.navigationItem.title = @"系统消息";
                       vc.loadUrl = [NSURL URLWithString:model.infoUrl];
                       vc.hidesBottomBarWhenPushed = YES;
                       [nav pushViewController:vc animated:YES];
                   }
    }else if (type == 2) {
        LxmOrderDetailVC *vc = [[LxmOrderDetailVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                   vc.orderId = model.infoId;
                   vc.hidesBottomBarWhenPushed = YES;
                   [nav pushViewController:vc animated:YES];
    }else if (type == 3) {
        
    }else if (type == 4) {
        HSPayTwoVC *vc = [[HSPayTwoVC alloc] init];
        vc.type = 2;
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
    }else if (type == 5) {
        HSPayTwoVC *vc = [[HSPayTwoVC alloc] init];
        vc.type = 3;
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
    }else if (type >= 100) {
        if (model.infoType.intValue == 101) {
            if (model.infoUrl.isValid) {
                LxmWebViewController *vc = [[LxmWebViewController alloc] init];
                vc.navigationItem.title = @"系统消息";
                vc.loadUrl = [NSURL URLWithString:model.infoUrl];
                vc.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:vc animated:YES];
            }
        }else if (model.infoType.intValue <= 105) {
            LTSCOrderDetailVC *vc = [[LTSCOrderDetailVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            vc.orderID = model.infoId;
            vc.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:vc animated:YES];
        }else if (model.infoType.intValue  == 106) {//
            HSPayTwoVC *vc = [[HSPayTwoVC alloc] init];
            vc.type = 2;
            vc.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:vc animated:YES];
        }else if (model.infoType.intValue == 107) {
            HSPayTwoVC *vc = [[HSPayTwoVC alloc] init];
            vc.type = 3;
            vc.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:vc animated:YES];
        }
        
    }
    
    
}



#pragma mark -支付宝 微信支付
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wxfddee11c3b802965://pay"] ) {
        //微信
        [WXApi handleOpenURL:url delegate:self];
        
    }else {//友盟
        //        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    return YES;
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知,告诉支付界面要做什么
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wxfddee11c3b802965://pay"] ) {
        
        [WXApi handleOpenURL:url delegate:self];
        
        
    }else {
        //        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wxfddee11c3b802965://pay"] ) {
        [WXApi handleOpenURL:url delegate:self];
        
    }else {
        //        [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    }
    return YES;
}
//微信支付结果
- (void)onResp:(BaseResp *)resp {
    //发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPAY" object:resp];
}



/// 注册环信
- (void)initHuanXin {
    //     appkey替换成自己在环信管理后台注册应用中的appkey
    EMOptions *options = [EMOptions optionsWithAppkey:HuanXin_AppKey];
    // apnsCertName是证书名称，可以先传nil，等后期配置apns推送时在传入证书名称
    options.apnsCertName = @"huishoupush";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}

@end
