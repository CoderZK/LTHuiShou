//
//  LxmYiJianFanKuiVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/18.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmYiJianFanKuiVC.h"


@interface LxmYiJianFanKuiVC ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) IQTextView *putinView;

@property (nonatomic, strong) UIButton *submitButton;//提交

@end

@implementation LxmYiJianFanKuiVC

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.view.bounds.size.height)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (IQTextView *)putinView {
    if (!_putinView) {
        _putinView = [IQTextView new];
        _putinView.placeholder = @"请输入内容";
        _putinView.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _putinView.font = [UIFont systemFontOfSize:15];
        _putinView.backgroundColor = [UIColor clearColor];
    }
    return _putinView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton new];
        [_submitButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 3;
        _submitButton.layer.masksToBounds = YES;
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"意见反馈";
    self.tableView.tableHeaderView = self.headerView;
    [self initHeaderView];
    [self setConstrains];
}

- (void)initHeaderView {
    [self.view addSubview:self.lineView];
    [self.headerView addSubview:self.bgView];
    [self.bgView addSubview:self.putinView];
    [self.headerView addSubview:self.submitButton];
}

- (void)setConstrains {
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@0.5);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(10);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@((ScreenW - 30)*248/345));
    }];
    [self.putinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.bgView).offset(10);
        make.bottom.trailing.equalTo(self.bgView).offset(-10);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom).offset(26);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@40);
    }];
}

/// 提交
- (void)submitClick:(UIButton *)btn {
    NSString *content = self.putinView.text;
    if (!content.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容!"];
        return;
    }
    [SVProgressHUD show];
    WeakObj(self);
    btn.userInteractionEnabled = NO;
    [LxmNetworking networkingPOST:lxm_feedback parameters:@{@"token" : SESSION_TOKEN, @"content" : content} returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel *responseObject) {
        [SVProgressHUD dismiss];
        btn.userInteractionEnabled = YES;
        if (responseObject.key.intValue == 1000) {
            [SVProgressHUD showSuccessWithStatus:@"意见已提交反馈！"];
            [selfWeak.navigationController popViewControllerAnimated:YES];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        btn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}

@end
