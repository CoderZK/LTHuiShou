//
//  LxmModifyPasswordVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/19.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmModifyPasswordVC.h"
#import "LxmLoginVC.h"

@interface LxmModifyPasswordVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) LxmPutinView *oldPasswordView;//旧密码

@property (nonatomic, strong) LxmPutinView *xinPasswordView;//新密码

@property (nonatomic, strong) LxmPutinView *surePasswordView;//确认密码

@property (nonatomic, strong) UIButton *submitButton;//提交

@end

@implementation LxmModifyPasswordVC

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.view.bounds.size.height - 1)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (LxmPutinView *)oldPasswordView {
    if (!_oldPasswordView) {
        _oldPasswordView = [LxmPutinView new];
        _oldPasswordView.putinTF.placeholder = @"请输入旧密码";
        _oldPasswordView.putinTF.delegate = self;
        [_oldPasswordView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_oldPasswordView layoutIfNeeded];
        _oldPasswordView.putinTF.secureTextEntry = YES;
    }
    return _oldPasswordView;
}

- (LxmPutinView *)xinPasswordView {
    if (!_xinPasswordView) {
        _xinPasswordView = [LxmPutinView new];
        _xinPasswordView.putinTF.placeholder = @"请输入新密码";
        [_xinPasswordView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_xinPasswordView layoutIfNeeded];
        _xinPasswordView.putinTF.delegate = self;
        _xinPasswordView.putinTF.secureTextEntry = YES;
    }
    return _xinPasswordView;
}

- (LxmPutinView *)surePasswordView {
    if (!_surePasswordView) {
        _surePasswordView = [LxmPutinView new];
        _surePasswordView.putinTF.placeholder = @"请重复新密码";
        [_surePasswordView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_surePasswordView layoutIfNeeded];
        _surePasswordView.putinTF.delegate = self;
        _surePasswordView.putinTF.secureTextEntry = YES;
    }
    return _surePasswordView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton new];
        [_submitButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 3;
        _submitButton.layer.masksToBounds = YES;
        [_submitButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [_submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"修改密码";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    [self initView];
    [self setConstrains];
}

- (void)initView {
    [self.view addSubview:self.lineView];
    [self.headerView addSubview:self.oldPasswordView];
    [self.headerView addSubview:self.xinPasswordView];
    [self.headerView addSubview:self.surePasswordView];
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
    [self.oldPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    [self.xinPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.oldPasswordView.mas_bottom);
           make.leading.equalTo(self.headerView).offset(15);
           make.trailing.equalTo(self.headerView).offset(-15);
           make.height.equalTo(@60);
    }];
    [self.surePasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.xinPasswordView.mas_bottom);
           make.leading.equalTo(self.headerView).offset(15);
           make.trailing.equalTo(self.headerView).offset(-15);
           make.height.equalTo(@60);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.surePasswordView.mas_bottom).offset(60);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@40);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.headerView endEditing:YES];
    NSString *oldpassworw = self.oldPasswordView.putinTF.text;
    NSString *xinpassworw = self.xinPasswordView.putinTF.text;
    NSString *surexinpassworw = self.surePasswordView.putinTF.text;
    if (![oldpassworw isValid] || ![xinpassworw isValid] || ![surexinpassworw isValid]) {
        [self.submitButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        return;
    }
    [self.submitButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
}

/// 确认修改
- (void)submitClick:(UIButton *)btn {
    [self.headerView endEditing:YES];
    NSString *oldpassworw = self.oldPasswordView.putinTF.text;
    NSString *xinpassworw = self.xinPasswordView.putinTF.text;
    NSString *surexinpassworw = self.surePasswordView.putinTF.text;
    if (![oldpassworw isValid]) {
        [SVProgressHUD showErrorWithStatus:@"请输入旧密码!"];
        return;
    }
    if ([oldpassworw isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"不能输入带有空格的旧密码!"];
        return;
    }
    if (![xinpassworw isValid]) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码!"];
        return;
    }
    if ([xinpassworw isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"不能输入带有空格的新密码!"];
        return;
    }
    if (![surexinpassworw isValid]) {
        [SVProgressHUD showErrorWithStatus:@"请重复输入新密码!"];
        return;
    }
    if ([surexinpassworw isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"不能重复输入带有空格的新密码!"];
        return;
    }
    if (![xinpassworw isEqualToString:surexinpassworw]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的新密码不一致!"];
        return;
    }
    NSDictionary *dict = @{
                           @"token" : SESSION_TOKEN,
                           @"oldPassword" : oldpassworw,
                           @"newPassword" : xinpassworw
                           };
    [SVProgressHUD show];
    btn.userInteractionEnabled = NO;
    [LxmNetworking networkingPOST:app_user_updatePassword parameters:dict returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel *responseObject) {
        [SVProgressHUD dismiss];
        btn.userInteractionEnabled = YES;
        if (responseObject.key.intValue == 1000) {
            [SVProgressHUD showSuccessWithStatus:@"密码已重置!"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self gotoLogin];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        btn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}


@end
