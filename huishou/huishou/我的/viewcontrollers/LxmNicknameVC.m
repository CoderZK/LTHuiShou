//
//  LxmNicknameVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/18.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmNicknameVC.h"

@interface LxmNicknameVC ()

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *nickView;//昵称view

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UILabel *nichengLabel;//昵称

@property (nonatomic, strong) UITextField *nickTF;//输入

@end

@implementation LxmNicknameVC

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        [_rightButton setTitle:@"保存" forState:UIControlStateNormal];
        [_rightButton setTitleColor: [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightButton addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    }
    return _headerView;
}

- (UIView *)nickView {
    if (!_nickView) {
        _nickView = [UIView new];
        _nickView.backgroundColor = [UIColor whiteColor];
    }
    return _nickView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        _textLabel.text = @"10个字以内，仅支持汉字、字母、数字或下划线";
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (UILabel *)nichengLabel {
    if (!_nichengLabel) {
        _nichengLabel = [UILabel new];
        _nichengLabel.font = [UIFont systemFontOfSize:15];
        _nichengLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _nichengLabel.text = @"昵称";
    }
    return _nichengLabel;
}

- (UITextField *)nickTF {
    if (!_nickTF) {
        _nickTF = [UITextField new];
        _nickTF.font = [UIFont systemFontOfSize:15];
        _nickTF.placeholder = @"请输入";
        _nickTF.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _nickTF.maxLength = 10;
    }
    return _nickTF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改昵称";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.tableView.tableHeaderView = self.headerView;
    self.nickTF.text = LxmTool.ShareTool.userModel.username;
    [self initHeaderView];
}

- (void)initHeaderView {
    [self.headerView addSubview:self.nickView];
    [self.headerView addSubview:self.textLabel];
    [self.nickView addSubview:self.nichengLabel];
    [self.nickView addSubview:self.nickTF];
    [self.nickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(10);
        make.leading.trailing.equalTo(self.headerView);
        make.height.equalTo(@50);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickView.mas_bottom).offset(10);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
    }];
    [self.nichengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nickView).offset(15);
        make.centerY.equalTo(self.nickView);
        make.width.equalTo(@40);
    }];
    [self.nickTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nichengLabel.mas_trailing).offset(5);
        make.trailing.equalTo(self.nickView).offset(-15);
        make.top.bottom.equalTo(self.nickView);
    }];
}


/// 保存
- (void)saveClick:(UIButton *)btn {
    [self.nickTF endEditing:YES];
    if (!self.nickTF.text.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称!"];
        return;
    }
    if (![NSString isHeFa:self.nickTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入合法的昵称!"];
        return;
    }
    NSDictionary *dict = @{
                           @"username" : self.nickTF.text,
                           @"token" : SESSION_TOKEN
                           };
    [SVProgressHUD show];
    btn.userInteractionEnabled = NO;
    WeakObj(self);
    [LxmNetworking networkingPOST:app_user_username parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
         btn.userInteractionEnabled = YES;
        if ([responseObject[@"key"] integerValue] == 1000) {
            [SVProgressHUD showSuccessWithStatus:@"昵称已修改!"];
            LxmTool.ShareTool.userModel.username = selfWeak.nickTF.text;
            [selfWeak.navigationController popViewControllerAnimated:YES];
        } else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        btn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}

@end
