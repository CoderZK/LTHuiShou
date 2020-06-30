//
//  LxmRegistVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmRegistVC.h"
#import "LxmLoginView.h"

@interface LxmRegistVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UILabel *textlabel;

@property (nonatomic, strong) LxmPutinView *phoneView;//手机号

@property (nonatomic, strong) LxmPutinView *codeView;//验证码

@property (nonatomic, strong) UIView *lineView;//线

@property (nonatomic, strong) UIButton *sendCodeButton;//发送验证码

@property (nonatomic, strong) LxmPutinView *passwordView;//密码

@property (nonatomic, strong) LxmPutinView *surepasswordView;//确认密码

@property (nonatomic, strong) LxmAgreeButton *agreeButton;//协议

@property (nonatomic, strong) UIButton *registButton;//注册

@property (nonatomic, strong) NSTimer *timer;//倒计时

@property (nonatomic, assign) int time;//倒计时时间

@property (nonatomic, assign) BOOL isClickSendCode;//是否点击了发送验证码

@end

@implementation LxmRegistVC

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.view.bounds.size.height)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UILabel *)textlabel {
    if (!_textlabel) {
        _textlabel = [UILabel new];
        _textlabel.font = [UIFont boldSystemFontOfSize:20];
        _textlabel.text = @"注册";
        _textlabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return _textlabel;
}

- (LxmPutinView *)phoneView {
    if (!_phoneView) {
        _phoneView = [LxmPutinView new];
        _phoneView.putinTF.placeholder = @"请输入手机号";
        _phoneView.putinTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneView.putinTF.delegate = self;
    }
    return _phoneView;
}

- (LxmPutinView *)codeView {
    if (!_codeView) {
        _codeView = [LxmPutinView new];
        _codeView.putinTF.placeholder = @"请输入验证码";
        _codeView.lineView.hidden = YES;
        _codeView.putinTF.delegate = self;
    }
    return _codeView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UIButton *)sendCodeButton {
    if (!_sendCodeButton) {
        _sendCodeButton = [UIButton new];
        [_sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendCodeButton setTitleColor:[UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0] forState:UIControlStateNormal];
        _sendCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _sendCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sendCodeButton addTarget:self action:@selector(sendCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendCodeButton;
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

- (LxmPutinView *)surepasswordView {
    if (!_surepasswordView) {
        _surepasswordView = [LxmPutinView new];
        _surepasswordView.putinTF.placeholder = @"请重复密码";
        _surepasswordView.putinTF.secureTextEntry = YES;
        _surepasswordView.putinTF.delegate = self;
    }
    return _surepasswordView;
}

- (LxmAgreeButton *)agreeButton {
    if (!_agreeButton) {
        _agreeButton = [LxmAgreeButton new];
        [_agreeButton.protocolButton addTarget:self action:@selector(seeProtocol) forControlEvents:UIControlEventTouchUpInside];
        [_agreeButton  addTarget:self action:@selector(tongyiProtocol:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意" attributes:@{NSForegroundColorAttributeName: CharacterGrayColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"《使用协议》" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:15/255.0 green:128/255.0 blue:255/255.0 alpha:1.0]}];
        [att appendAttributedString:str];
        _agreeButton.textLabel.attributedText = att;
    }
    return _agreeButton;
}

- (void)tongyiProtocol:(LxmAgreeButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        button.imgV.image = [UIImage imageNamed:@"xuanzhong_y"];
    }else {
        button.imgV.image = [UIImage imageNamed:@"xuanzhong_n"];
    }
}

- (UIButton *)registButton {
    if (!_registButton) {
        _registButton = [UIButton new];
        [_registButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [_registButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_registButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _registButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _registButton.layer.cornerRadius = 3;
        _registButton.clipsToBounds = YES;
        [_registButton addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    [self initSubviews];
    [self setConstrains];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textFieldDidChanged) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)initSubviews {
    [self.headerView addSubview:self.textlabel];
    [self.headerView addSubview:self.phoneView];
    [self.headerView addSubview:self.codeView];
    [self.headerView addSubview:self.sendCodeButton];
    [self.headerView addSubview:self.lineView];
    [self.headerView addSubview:self.passwordView];
    [self.headerView addSubview:self.surepasswordView];
    [self.headerView addSubview:self.agreeButton];
    [self.headerView addSubview:self.registButton];
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
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom);
        make.leading.equalTo(self.headerView).offset(30);
        make.trailing.equalTo(self.headerView).offset(-110);
        make.height.equalTo(@60);
    }];
    [self.sendCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom);
        make.trailing.equalTo(self.headerView).offset(-30);
        make.width.equalTo(@80);
        make.height.equalTo(@60);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.codeView);
        make.leading.equalTo(self.headerView).offset(30);
        make.trailing.equalTo(self.headerView).offset(-30);
        make.height.equalTo(@1);
    }];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.codeView.mas_bottom);
       make.leading.equalTo(self.headerView).offset(30);
       make.trailing.equalTo(self.headerView).offset(-30);
       make.height.equalTo(@60);
    }];
    [self.surepasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.passwordView.mas_bottom);
       make.leading.equalTo(self.headerView).offset(30);
       make.trailing.equalTo(self.headerView).offset(-30);
       make.height.equalTo(@60);
    }];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.surepasswordView.mas_bottom);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@50);
    }];
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.agreeButton.mas_bottom).offset(25);
        make.leading.equalTo(self.headerView).offset(30);
        make.trailing.equalTo(self.headerView).offset(-30);
        make.height.equalTo(@44);
    }];
}

/// 查看协议
- (void)seeProtocol {
    
    LxmWebViewController * vc =[[LxmWebViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.loadUrl = [NSURL URLWithString:@"https://huishou.zftgame.com/normal/index.html"];
    vc.navigationItem.title = @"注册协议";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.headerView endEditing:YES];
    NSString *phone  = self.phoneView.putinTF.text;
    NSString *code = self.codeView.putinTF.text;
    NSString *password = self.passwordView.putinTF.text;
    NSString *surepassword = self.surepasswordView.putinTF.text;
    if (![phone isValid] || ![code isValid] || ![password isValid] || ![surepassword isValid]) {
        [self.registButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        return;
    }
    [self.registButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
}

- (void)textFieldDidChanged {
    NSString *phone  = self.phoneView.putinTF.text;
    NSString *code = self.codeView.putinTF.text;
    NSString *password = self.passwordView.putinTF.text;
    NSString *surepassword = self.surepasswordView.putinTF.text;
    if (![phone isValid] || ![code isValid] || ![password isValid] || ![surepassword isValid]) {
        [self.registButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        return;
    }
    if (surepassword.length >= 6) {
       [self.registButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
    } else {
        [self.registButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    }
    
}


- (void)registClick:(UIButton *)btn {
    [self.headerView endEditing:YES];
    if (!self.isClickSendCode) {
        [SVProgressHUD showErrorWithStatus:@"请点击发送验证码!"];
        return;
    }
    if (self.agreeButton.selected == NO) {
        [SVProgressHUD showErrorWithStatus:@"请勾选使用协议"];
        return;
    }
    NSString *phone  = self.phoneView.putinTF.text;
    NSString *code = self.codeView.putinTF.text;
    NSString *password = self.passwordView.putinTF.text;
    NSString *surepassword = self.surepasswordView.putinTF.text;
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
    if (![code isValid]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码!"];
        return;
    }
    if ([code isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"不能输入带有空格的验证码!"];
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
                           @"telephone" : phone,
                           @"code" : code,
                           @"password" : password
                            };
    [SVProgressHUD show];
    WeakObj(self);
    btn.userInteractionEnabled = NO;
      [LxmNetworking networkingPOST:app_register parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject){
        [SVProgressHUD dismiss];
        btn.userInteractionEnabled = YES;
        if ([responseObject[@"key"] intValue] == 1000) {
           
            [LxmTool ShareTool].isLogin = YES;
            [LxmTool ShareTool].session_token = responseObject[@"result"][@"token"];
            
            [self  getHuanXinMessage];
            
             [[LxmTool ShareTool] uploadDeviceToken];
            
            [LxmTool ShareTool].userModel = [LxmUserInfoModel mj_objectWithKeyValues:responseObject[@"result"][@"map"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 btn.userInteractionEnabled = NO;
                [UIApplication sharedApplication].keyWindow.rootViewController = [[LxmTabBarVC alloc] init];
        });
            

        } else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        btn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
    
}

- (void)getHuanXinMessage {
    
  
    WeakObj(self);
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [LxmTool ShareTool].session_token;
          [LxmNetworking networkingPOST:get_huanxin parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject){
            [SVProgressHUD dismiss];
            if ([responseObject[@"key"] intValue] == 1000) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
           
                [LxmTool ShareTool].userModel.imCode = responseObject[@"result"][@"map"][@"imCode"];
                 [LxmTool ShareTool].userModel.imPass = responseObject[@"result"][@"map"][@"imPass"];
                           //登录环信
                [LxmTool.ShareTool loginHuanXin];
                
                
    //            [selfWeak.navigationController pushViewController:self animated:YES];
    //            [selfWeak.navigationController popViewControllerAnimated:YES];
            } else {
                
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
           
            [SVProgressHUD dismiss];
        }];
    
}

- (void)sendCodeClick:(UIButton *)sendCodeBtn {
    //type 10-注册, 20-修改密码，30-更换手机号
    NSString *phone  = self.phoneView.putinTF.text;
    if (![phone isValid]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return;
    }
    if (phone.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号!"];
        return;
    }
    NSDictionary *dict = @{
                           @"type" : @10,
                           @"telephone" : phone
                           };
    [SVProgressHUD show];
    self.isClickSendCode = YES;
    sendCodeBtn.userInteractionEnabled = NO;
    [LxmNetworking networkingPOST:sendCodeNew parameters:dict returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel *responseObject) {
        [SVProgressHUD dismiss];
        sendCodeBtn.userInteractionEnabled = YES;
        if (responseObject.key.intValue == 1000) {
            [self.timer invalidate];
            self.timer = nil;
            self.time = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(onTimer) userInfo:nil repeats:YES];
            
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        sendCodeBtn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}


/**
 定时器 验证码
 */
- (void)onTimer {
    self.sendCodeButton.enabled = NO;
    [self.sendCodeButton setTitle:[NSString stringWithFormat:@"获取(%ds)",self.time--] forState:UIControlStateNormal];
    if (self.time < 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.sendCodeButton.enabled = YES;
        [self.sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

@end
