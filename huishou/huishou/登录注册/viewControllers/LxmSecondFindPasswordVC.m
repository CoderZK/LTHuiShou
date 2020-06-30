//
//  LxmSecondFindPasswordVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmSecondFindPasswordVC.h"
#import "LxmLoginView.h"
#import "LxmLoginVC.h"

@interface LxmSecondFindPasswordVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *topLineView;//线

@property (nonatomic, strong) LxmPutinView *passwordView;//密码

@property (nonatomic, strong) LxmPutinView *surepasswordView;//确认密码

@property (nonatomic, strong) UIButton *saveButton;//保存

@end

@implementation LxmSecondFindPasswordVC

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
        _topLineView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    }
    return _topLineView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, ScreenW, self.view.bounds.size.height - 1)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (LxmPutinView *)passwordView {
    if (!_passwordView) {
        _passwordView = [LxmPutinView new];
        _passwordView.putinTF.placeholder = @"请输入新密码";
        _passwordView.putinTF.secureTextEntry = YES;
        _passwordView.putinTF.delegate = self;
    }
    return _passwordView;
}

- (LxmPutinView *)surepasswordView {
    if (!_surepasswordView) {
        _surepasswordView = [LxmPutinView new];
        _surepasswordView.putinTF.placeholder = @"请重复新密码";
        _surepasswordView.putinTF.secureTextEntry = YES;
        _surepasswordView.putinTF.delegate = self;
    }
    return _surepasswordView;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton new];
        [_saveButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [_saveButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _saveButton.layer.cornerRadius = 3;
        _saveButton.clipsToBounds = YES;
        [_saveButton addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
    self.tableView.tableHeaderView = self.headerView;
    [self initSubviews];
    [self setConstrains];
}
- (void)initSubviews {
    [self.view addSubview:self.topLineView];
    [self.headerView addSubview:self.passwordView];
    [self.headerView addSubview:self.surepasswordView];
    [self.headerView addSubview:self.saveButton];
}

- (void)setConstrains {
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@1);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLineView.mas_bottom);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    [self.surepasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_bottom);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.surepasswordView.mas_bottom).offset(25);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@44);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.headerView endEditing:YES];
    NSString *password = self.passwordView.putinTF.text;
    NSString *surepassword = self.surepasswordView.putinTF.text;
    if (![password isValid] || ![surepassword isValid]) {
        [self.saveButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        return;
    }
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
}


/// 保存
- (void)saveClick:(UIButton *)btn {
    [self.headerView endEditing:YES];
    NSString *password = self.passwordView.putinTF.text;
    NSString *surepassword = self.surepasswordView.putinTF.text;
    if (![password isValid]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
        return;
    }
    if (password.length < 6) {
           [SVProgressHUD showErrorWithStatus:@"请输入6位及以上的密码"];
           return;
       }
    if ([password isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"不能输入带有空格的密码!"];
        return;
    }
    if (![surepassword isValid]) {
        [SVProgressHUD showErrorWithStatus:@"请重复输入密码!"];
        return;
    }
    if ([surepassword isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"不能输入带有空格的确认密码!"];
        return;
    }
    if (![password isEqualToString:surepassword]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致!"];
        return;
    }
    NSDictionary *dict = @{
                           @"telephone" : self.phone,
                           @"password" : password
                           };
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:app_forgetPassword parameters:dict returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.intValue == 1000) {
            [SVProgressHUD showSuccessWithStatus:@"密码已重置!"];
             for (UIViewController *vc in selfWeak.navigationController.viewControllers) {
                 if ([vc isKindOfClass:[LxmLoginVC class]]) {
                    [selfWeak.navigationController popToViewController:vc animated:YES];
                }
            }
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
