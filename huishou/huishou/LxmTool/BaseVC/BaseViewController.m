//
//  BaseViewController.m
//  Lxm
//
//  Created by Lxm on 15/10/13.
//  Copyright © 2015年 Lxm. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end
@implementation BaseViewController


- (LTSCNoneView *)noneView {
    if (!_noneView) {
        _noneView= [[LTSCNoneView alloc] init];
    }
    return _noneView;
}

- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
	return NO;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGGrayColor;
    self.navigationController.navigationBar.tintColor = CharacterDarkColor;
    
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_back"] style:UIBarButtonItemStyleDone target:self action:@selector(baseLeftBtnClick)];
        leftItem.tintColor = CharacterDarkColor;
        //        leftItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
}


- (void)baseLeftBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //开启iOS7的滑动返回效果
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        //只有在二级页面生效
//        if ([self.navigationController.viewControllers count] > 1) {
//            self.navigationController.interactivePopGestureRecognizer.delegate = self;
//        } else {
//            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//        }
//    }
}


- (void)loadMyUserInfoWithOkBlock:(void(^)(BOOL isOk))okBlock {
    
    UIViewController * tvc = [UIApplication sharedApplication].keyWindow.rootViewController;
    NSString * str = my_info;
    if ([tvc isKindOfClass:[LxmTabBarVC class]]) {
        str = app_user_get_userInfo;
    }
    
    //获取个人信息
    [LxmNetworking networkingPOST:str parameters:@{@"token":TOKEN} returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"key"] integerValue] == 1000) {
            
            if ([str isEqualToString:my_info]) {
                NSString * heaPic = [LxmTool ShareTool].userModel.head_pic;
                NSString *useName = [LxmTool ShareTool].userModel.username;
                
                [LxmTool ShareTool].userModel = [LxmUserInfoModel mj_objectWithKeyValues:responseObject[@"result"][@"map"]];
                [LxmTool ShareTool].userModel.username = useName;
                [LxmTool ShareTool].userModel.head_pic = heaPic;
            }else {
                [LxmTool ShareTool].userModel = [LxmUserInfoModel mj_objectWithKeyValues:responseObject[@"result"][@"map"]];
                [LxmTool ShareTool].userModel.imPass = [LxmTool ShareTool].userModel.im_pass;
                [LxmTool ShareTool].userModel.imCode = [LxmTool ShareTool].userModel.im_code;
            }
            
            [LxmEventBus sendEvent:@"userInfo" data:nil];
            if (okBlock) {
                okBlock(YES);
            }
        }else if ([responseObject[@"key"] integerValue] == 1001) {
            [LxmTool ShareTool].isLogin = NO;
            [LxmTool ShareTool].session_token = nil;
            [[EMClient sharedClient] logout:YES];
            if (okBlock) {
                okBlock(NO);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}



-(CGSize)getImageSizeWithURL:(id)imageURL {
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]) {
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]) {
        URL = [NSURL URLWithString:imageURL];
    }
    NSData *data = [NSData dataWithContentsOfURL:URL];UIImage *image = [UIImage imageWithData:data];
    return CGSizeMake(image.size.width, image.size.height);
}

- (void)gotoLogin {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[LxmLoginVC new]] animated:YES completion:nil];
    
}



@end
