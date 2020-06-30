//
//  LxmMineVC.m
//  回收
//
//  Created by 李晓满 on 2020/3/11.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmMineVC.h"
#import "LxmMineView.h"
#import "LxmUserInfoVC.h"
#import "LxmYuEVC.h"
#import "LxmYiJianFanKuiVC.h"
#import "LxmSettingVC.h"
#import "LxmMyOrderVC.h"
#import "EMConversationsViewController.h"
@interface LxmMineVC ()

@property (nonatomic, strong) UIImageView *bgImgView;//背景

@property (nonatomic, strong) UIImageView *headerImgView;//y头像

@property (nonatomic, strong) UILabel *phoneLabel;//手机号

@property (nonatomic, strong) LxmMineOrderView *orderView;//我的订单

@property (nonatomic, strong) UIView *yinyingView;

@property (nonatomic, strong) LxmMineView *otherView;//

@property (nonatomic, strong) LxmOrderNumRootModel *numModel;
@property(nonatomic,strong)UIButton *messageBt;



@end

@implementation LxmMineVC

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        _bgImgView.image = [UIImage imageNamed:@"bg_mine"];
        _bgImgView.userInteractionEnabled = YES;
    }
    return _bgImgView;
}

- (LxmMineOrderView *)orderView {
    if (!_orderView) {
        _orderView = [LxmMineOrderView new];
        _orderView.backgroundColor = [UIColor whiteColor];
        _orderView.layer.cornerRadius = 10;
        _orderView.layer.masksToBounds = YES;
        [_orderView.titleButton addTarget:self action:@selector(myOrderClick) forControlEvents:UIControlEventTouchUpInside];
        WeakObj(self);
        _orderView.orderStatusClickBlock = ^(NSInteger index) {
            [selfWeak pageToOrder:index];
        };
    }
    return _orderView;
}

- (UIView *)yinyingView {
    if (!_yinyingView) {
        _yinyingView = [UIView new];
        _yinyingView.backgroundColor = [UIColor whiteColor];
        _yinyingView.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.5].CGColor;
        _yinyingView.layer.shadowRadius = 10;
        _yinyingView.layer.shadowOpacity = 0.5;
        _yinyingView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _yinyingView;
}

- (LxmMineView *)otherView {
    if (!_otherView) {
        _otherView = [[LxmMineView alloc] initWithFrame:CGRectMake(20, ScreenW * 166/375 + 86, ScreenW - 20, 270)];
        _otherView.backgroundColor = [UIColor clearColor];
        [_otherView.yueButton addTarget:self action:@selector(yuECLick) forControlEvents:UIControlEventTouchUpInside];
        [_otherView.suggestionButton addTarget:self action:@selector(yijianfankuiClick) forControlEvents:UIControlEventTouchUpInside];
        [_otherView.settingButton addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_otherView.aboutButton addTarget:self action:@selector(aboutUs) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _otherView;
}

- (void)aboutUs {
    
    if (ISLOGIN) {
        LxmWebViewController * vc =[[LxmWebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.loadUrl = [NSURL URLWithString:@"https://huishou.zftgame.com/normal/aboutMe.html"];
        vc.navigationItem.title = @"关于我们";
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self gotoLogin];
    }
    
    
    
    
    
    
}


- (UIImageView *)headerImgView {
    if (!_headerImgView) {
        _headerImgView = [UIImageView new];
        _headerImgView.backgroundColor = [UIColor brownColor];
        _headerImgView.layer.cornerRadius = 22;
        _headerImgView.layer.masksToBounds = YES;
        _headerImgView.layer.borderColor = UIColor.whiteColor.CGColor;
        _headerImgView.layer.borderWidth = 1;
        _headerImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImgClick:)];
        [_headerImgView addGestureRecognizer:tap];
    }
    return _headerImgView;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [UILabel new];
        _phoneLabel.textColor = UIColor.whiteColor;
        _phoneLabel.font = [UIFont boldSystemFontOfSize:17];
        _phoneLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImgClick:)];
        [_phoneLabel addGestureRecognizer:tap];
    }
    return _phoneLabel;
}

- (UIButton *)messageBt {
    if (_messageBt == nil) {
        _messageBt = [[UIButton alloc] init];
        [_messageBt addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
        [_messageBt setImage:[UIImage imageNamed:@"mmd"] forState:UIControlStateNormal];
    }
    return _messageBt;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (!ISLOGIN) {
        [self setheadWithNoLogin];
        return;
    }
    
    [self loadMyUserInfoWithOkBlock:^(BOOL isOk){
        
        if (isOk == NO || !ISLOGIN) {
            [self endRefrish];
             [self setheadWithNoLogin];
            return;
            
        }

        [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:LxmTool.ShareTool.userModel.head_pic] placeholderImage:[UIImage imageNamed:@"789789"] options:SDWebImageRetryFailed];
        self.otherView.yueButton.detailLabel.text = [NSString stringWithFormat:@"%.2f", [LxmTool ShareTool].userModel.balance.doubleValue];
        NSString *phone = LxmTool.ShareTool.userModel.telephone;
        if (phone.length == 11) {
            NSString *rePhone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
            self.phoneLabel.text = rePhone;
        }
        
        if (LxmTool.ShareTool.userModel.username.length > 0) {
            self.phoneLabel.text = LxmTool.ShareTool.userModel.username;
        }
        
    }];
    
    if (ISLOGIN) {
        [self loadOrderNumData];
        self.messageBt.hidden = NO;
        
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSInteger unreadCount = 0;
        for (EMConversation *conversation in conversations) {
            unreadCount += conversation.unreadMessagesCount;
        }
        if (unreadCount > 0) {
            [self.messageBt setImage:[UIImage imageNamed:@"mmd"] forState:UIControlStateNormal];
        }else {
            [self.messageBt setImage:[UIImage imageNamed:@"mmk"] forState:UIControlStateNormal];
        }
        
        
    }else {
        [self setheadWithNoLogin];
    }
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initHeaderView];
    WeakObj(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        StrongObj(self);
        [self loadOrderNumData];
    }];
    
    
}

- (void)initHeaderView {
    self.view.backgroundColor = self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgImgView];
    [self.bgImgView addSubview:self.headerImgView];
    [self.bgImgView addSubview:self.phoneLabel];
    [self.bgImgView addSubview:self.messageBt];
    [self.view addSubview:self.yinyingView];
    [self.view addSubview:self.orderView];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(ScreenW * 166/375));
    }];
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgImgView).offset(15);
        make.bottom.equalTo(self.orderView.mas_top).offset(-28);
        make.width.height.equalTo(@44);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.headerImgView.mas_trailing).offset(10);
        make.centerY.equalTo(self.headerImgView);
    }];
    
    [self.messageBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@35);
        make.centerY.equalTo(self.headerImgView);
        make.right.equalTo(self.bgImgView.mas_right).offset(-10);
    }];
    
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImgView.mas_bottom).offset(-48);
        make.leading.equalTo(self.view).offset(15);
        make.trailing.equalTo(self.view).offset(-15);
        make.height.equalTo(@134);
    }];
    [self.yinyingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImgView.mas_bottom).offset(-38);
        make.leading.equalTo(self.view).offset(25);
        make.trailing.equalTo(self.view).offset(-25);
        make.height.equalTo(@114);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_bottom).offset(10);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    self.tableView.tableHeaderView = self.otherView;
}

//点击消息
- (void)messageAction{
    
    
    if (ISLOGIN) {
        
        if ([LxmTool ShareTool].userModel.imCode.length == 0) {
                   [[LxmTool ShareTool] getHuanXinCodeTwo];
                   return;
               }
        
        EMConversationsViewController *conversationVC = [[EMConversationsViewController alloc] init];
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
        backBarButtonItem.title = @"";
         self.navigationItem.backBarButtonItem = backBarButtonItem;
        [self.navigationController pushViewController:conversationVC animated:YES];
    }else {
        [self gotoLogin];
    }
    
    
    
    
}

/// 点击头像
- (void)headerImgClick:(UITapGestureRecognizer *)gesture {
    
    
    if (ISLOGIN) {
        LxmUserInfoVC *vc = [LxmUserInfoVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self gotoLogin];
    }
    
    
}

/// 余额
- (void)yuECLick {
    
    if (ISLOGIN) {
        LxmYuEVC *vc = [LxmYuEVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self gotoLogin];
    }
    
    
}

/// 意见反馈
- (void)yijianfankuiClick {
    
    if (ISLOGIN) {
        LxmYiJianFanKuiVC *vc = [LxmYiJianFanKuiVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self gotoLogin];
    }
    
    
}

/// 设置
- (void)setClick {
    
    if (ISLOGIN) {
        LxmSettingVC *vc = [LxmSettingVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self gotoLogin];
    }
    
    
}

/// 我的订单
- (void)myOrderClick {
    
    if (ISLOGIN) {
        LxmMyOrderVC *vc = [LxmMyOrderVC new];
        vc.selectIndex = 0;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self gotoLogin];
    }
    
    
}

/// 跳转我的订单列表
/// @param index 0待处理 1待发货 2待处理 3已完成 4已取消
- (void)pageToOrder:(NSInteger)index {
    
    if (ISLOGIN) {
        LxmMyOrderVC *vc = [LxmMyOrderVC new];
        vc.selectIndex = index + 1;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
       [self gotoLogin];
    }
    
    
    
}

/// 用户-我的订单数
- (void)loadOrderNumData {
    if (!self.numModel) {
        [SVProgressHUD show];
    }
    WeakObj(self);
    [LxmNetworking networkingPOST:my_count_order parameters:@{@"token":SESSION_TOKEN} returnClass:LxmOrderNumRootModel.class success:^(NSURLSessionDataTask *task, LxmOrderNumRootModel *responseObject) {
        [selfWeak endRefrish];
        if (responseObject.key.intValue == 1000) {
            selfWeak.numModel = responseObject;
            selfWeak.orderView.orderNumModel = selfWeak.numModel.result.map;
        } else {
            //            [UIAlertController showAlertWithmessage:responseObject.message];
            
            [self setheadWithNoLogin];
            
            [SVProgressHUD showErrorWithStatus:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfWeak endRefrish];
    }];
}

- (void)setheadWithNoLogin {
    
    self.phoneLabel.text = @"点击登录";
    self.headerImgView.image = [UIImage imageNamed:@"user"];
    self.messageBt.hidden = YES;
    self.orderView.orderNumModel = nil;
    self.otherView.yueButton.detailLabel.text = @"0.00";
    [self.tableView reloadData];
    
}

@end
