//
//  LTSCHeader.h
//  salaryStatus
//
//  Created by 李晓满 on 2019/1/25.
//  Copyright © 2019年 李晓满. All rights reserved.
//

#ifndef LTSCHeader_h
#define LTSCHeader_h

#import <UIKit/UIKit.h>
#import "LTSCNetworking.h"
#import "LxmTool.h"
#import "LTSCURLDefine.h"
#import "NSString+Size.h"
#import "UIAlertController+AlertWithKey.h"
#import "UITextField+MaxLength.h"
#import "UIViewController+TopVC.h"
#import "LTSCEventBus.h"
#import "LTSCLoadingView.h"
#import "LTSCRefreshHeader.h"
#import "LTSCNoneView.h"
#import "LTSCToastView.h"
#import "LTSCShopModel.h"
#import "LTSCBaseModel.h"

#import "LTSCMyOrderVC.h"
//#import "LTSCMineModel.h"
#import "LTSCCateModel.h"
#import "LTSCTabBarVC.h"
#import <MBProgressHUD.h>
#import "EMConversationsViewController.h"

// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define kDevice_Is_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define TableViewBottomSpace (kDevice_Is_iPhoneX ? 34 : 0)

#define NavigationSpace (kDevice_Is_iPhoneX ? 88 : 64)

//文字三种颜色
#define CharacterDarkColor [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1]
#define CharacterGrayColor [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
#define CharacterLightGrayColor [UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1]
#define LightGrayColor [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]

#define ISLOGIN [LxmTool ShareTool].isLogin
#define SESSION_TOKEN [LxmTool ShareTool].session_token

/**
 屏幕的长宽
 */
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define StateBarH [UIApplication sharedApplication].statusBarFrame.size.height

/**
 分割线
 */
#define  LineColor [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1]

/**
 背景两种颜色
 */
#define BGGrayColor [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]

#define  SCRedColor [UIColor colorWithRed:69/255.0 green:94/255.0 blue:245/255.0 alpha:1]

/**
 主色调
 */
#define MineColor [UIColor colorWithRed:251/255.0 green:158/255.0 blue:43/255.0 alpha:1]

#define WeakObj(_obj)    __weak typeof(_obj) _obj##Weak = _obj;

//iPhoneX iPhoneXS CGSizeMake(375, 812), iPhoneXR iPhoneXs max CGSizeEqualToSize(CGSizeMake(414, 896)

#endif /* LTSCHeader_h */
