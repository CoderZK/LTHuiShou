//
//  LxmLoginVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmLoginVC.h"
#import "LxmLoginView.h"
#import "LxmTabBarVC.h"
#import "LxmRegistVC.h"
#import "LxmFirstFindPasswordVC.h"
#import "LxmEventBus.h"

@interface LxmLoginVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UILabel *textlabel;

@property (nonatomic, strong) LxmPutinView *phoneView;//手机号

@property (nonatomic, strong) LxmPutinView *passwordView;//密码

@property (nonatomic, strong) UIButton *lijizhuceButton;//立即注册

@property (nonatomic, strong) UIButton *forgetPasswordButton;//忘记密码

@property (nonatomic, strong) UIButton *loginButton;//登录

@end

@implementation LxmLoginVC

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.view.bounds.size.height)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        [_rightButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(12.5, 25, 12.5, 0);
    }
    return _rightButton;
}

- (UILabel *)textlabel {
    if (!_textlabel) {
        _textlabel = [UILabel new];
        _textlabel.font = [UIFont boldSystemFontOfSize:20];
        _textlabel.text = @"欢迎来到乐购宝";
        _textlabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return _textlabel;
}

- (LxmPutinView *)phoneView {
    if (!_phoneView) {
        _phoneView = [LxmPutinView new];
        _phoneView.putinTF.placeholder = @"请输入手机号";
        _phoneView.putinTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneView;
}

- (LxmPutinView *)passwordView {
    if (!_passwordView) {
        _passwordView = [LxmPutinView new];
        _passwordView.putinTF.placeholder = @"请输入密码";
        _passwordView.putinTF.secureTextEntry = YES;
        _passwordView.putinTF.delegate = self;
    }
    return _passwordView;
}

- (UIButton *)lijizhuceButton {
    if (!_lijizhuceButton) {
        _lijizhuceButton = [UIButton new];
        _lijizhuceButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_lijizhuceButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_lijizhuceButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
        _lijizhuceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_lijizhuceButton addTarget:self action:@selector(zhuceClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lijizhuceButton;
}

- (UIButton *)forgetPasswordButton {
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [UIButton new];
        _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswordButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
        _forgetPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_forgetPasswordButton addTarget:self action:@selector(findPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPasswordButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton new];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [_loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _loginButton.layer.cornerRadius = 3;
        _loginButton.clipsToBounds = YES;
        [_loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (void)dealloc {
//    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.tableView.tableHeaderView = self.headerView;
    [self initSubviews];
    [self setConstrains];
    
//    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textFieldDidChanged) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)initSubviews {
    [self.headerView addSubview:self.textlabel];
    [self.headerView addSubview:self.phoneView];
    [self.headerView addSubview:self.passwordView];
    [self.headerView addSubview:self.lijizhuceButton];
    [self.headerView addSubview:self.forgetPasswordButton];
    [self.headerView addSubview:self.loginButton];
}

- (void)setConstrains {
    [self.textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(40);
        make.leading.equalTo(self.headerView).offset(30);
    }];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textlabel.mas_bottom).offset(60);
        make.leading.equalTo(self.headerView).offset(30);
        make.trailing.equalTo(self.headerView).offset(-30);
        make.height.equalTo(@60);
    }];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.phoneView.mas_bottom);
           make.leading.equalTo(self.headerView).offset(30);
           make.trailing.equalTo(self.headerView).offset(-30);
           make.height.equalTo(@60);
    }];
    [self.lijizhuceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_bottom);
        make.leading.equalTo(self.headerView).offset(30);
        make.width.equalTo(self.forgetPasswordButton);
        make.trailing.equalTo(self.forgetPasswordButton.mas_leading);
        make.height.equalTo(@50);
    }];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_bottom);
        make.trailing.equalTo(self.headerView).offset(-30);
        make.height.equalTo(@50);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lijizhuceButton.mas_bottom).offset(20);
        make.leading.equalTo(self.headerView).offset(30);
        make.trailing.equalTo(self.headerView).offset(-30);
        make.height.equalTo(@44);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.headerView endEditing:YES];
    NSString *phone = self.phoneView.putinTF.text;
    NSString *password = self.passwordView.putinTF.text;
    if (![phone isValid] || ![password isValid] ) {
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        return;
    }
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (str.length < 6 ||  self.phoneView.putinTF.text.length == 0) {
           [self.loginButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        
       }else {
          [self.loginButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
       }
       
    
    return YES;
}

- (void)textFieldDidChanged {
    
    NSString *phone = self.phoneView.putinTF.text;
    NSString *password = self.passwordView.putinTF.text;
    if (![phone isValid] || ![password isValid] || password.length < 6) {
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        return;
    }
    if (password.length >= 6) {
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
    } else {
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    }
}


//登录
- (void)loginClick: (UIButton *)btn {
    [self.headerView endEditing:YES];
    NSString *phone = self.phoneView.putinTF.text;
    NSString *password = self.passwordView.putinTF.text;
    if (![phone isValid]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return;
    }
    if ([phone isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"不能输入带有空格的手机号!"];
        return;
    }
    if (phone.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号!"];
        return;
    }
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
    NSDictionary *dict = @{
                           @"telephone" : phone,
                           @"password" : password,
                           };
    [SVProgressHUD show];
    self.loginButton.userInteractionEnabled = NO;
    WeakObj(self);
    [LxmNetworking networkingPOST:app_login parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        selfWeak.loginButton.userInteractionEnabled = YES;
        if ([responseObject[@"key"] integerValue] == 1000) {
            [LxmTool ShareTool].isLogin = YES;
            [LxmTool ShareTool].session_token = responseObject[@"result"][@"token"];
           
            [LxmTool ShareTool].userModel = [LxmUserInfoModel mj_objectWithKeyValues:responseObject[@"result"][@"map"]];
            [[LxmTool ShareTool] getHuanXinCode];
            [[LxmTool ShareTool] uploadDeviceToken];
//        UIApplication.sharedApplication.keyWindow.rootViewController = [LxmTabBarVC new];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        selfWeak.loginButton.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}


- (void)closeAction {
//     UIApplication.sharedApplication.keyWindow.rootViewController = [LxmTabBarVC new];
    if (self.isPopToRootVC) {
         [LxmEventBus sendEvent:@"goback" data:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 立即注册
- (void)zhuceClick {
    LxmRegistVC *vc = [LxmRegistVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

/// 找回密码
- (void)findPasswordClick {
    LxmFirstFindPasswordVC *vc = [[LxmFirstFindPasswordVC alloc] initWithTableViewStyle:UITableViewStyleGrouped type:LxmFirstFindPasswordVC_type_forgerfirst];
    vc.phone = self.phoneView.putinTF.text;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
