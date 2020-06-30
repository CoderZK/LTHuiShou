//
//  LxmTiXianVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/27.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmTiXianVC.h"
#import "LxmKaBaoView.h"
#import "LxmMineView.h"
#import "LxmTiXianSuccessVC.h"

@interface LxmTiXianVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *submitButton;//取消订单

@property (nonatomic, strong) LxmTiXianHeaderView *headerView;

@property (nonatomic, strong) LxmTiXianFooterView *footerView;

@property (nonatomic, assign) NSInteger currentIndex;

/**  */
@property(nonatomic , strong)NSString *limMoney;


@end

@implementation LxmTiXianVC

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.2].CGColor;
        _bottomView.layer.shadowRadius = 5;
        _bottomView.layer.shadowOpacity = 0.5;
        _bottomView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _bottomView;
}

- (LxmTiXianHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LxmTiXianHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 190)];
        [_headerView.allButton addTarget:self action:@selector(allTiXianClick:) forControlEvents:UIControlEventTouchUpInside];
        _headerView.moneyTF.delegate = self;
    }
    return _headerView;
}

- (LxmTiXianFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[LxmTiXianFooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 180)];
    }
    return _footerView;
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
        [_submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}


- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    self.navigationItem.title = @"提现";
    self.limMoney =[LxmTool ShareTool].userModel.limitMoney.getPriceStr;
    [self initView];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textFieldDidChanged) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)initView {
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.submitButton];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@0.5);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(TableViewBottomSpace + 60));
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(10);
        make.centerX.equalTo(self.bottomView);
        make.leading.equalTo(self.bottomView).offset(15);
        make.trailing.equalTo(self.bottomView).offset(-15);
        make.height.equalTo(@40);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmChongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmChongZhiCell"];
    if (!cell) {
        cell = [[LxmChongZhiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmChongZhiCell"];
    }
    cell.indexProw = indexPath.row;
    cell.selectImgView.image = [UIImage imageNamed:self.currentIndex == indexPath.row ? @"xuanzhong_y" : @"xuanzhong_n"] ;
    cell.iconImgView.image = [UIImage imageNamed:indexPath.row == 0 ? @"alipay_pay" : indexPath.row == 1 ? @"wechat_pay" : @"yinhangka_pay"];
    cell.titleLabel.text = indexPath.row == 0 ? @"支付宝" : indexPath.row == 1 ? @"微信" : @"银行卡";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LxmTiXianSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmTiXianSectionHeaderView"];
    if (!headerView) {
        headerView = [[LxmTiXianSectionHeaderView alloc] initWithReuseIdentifier:@"LxmTiXianSectionHeaderView"];
    }
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    if (!footerView) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
    }
    footerView.contentView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    if (indexPath.row == 0) {
        self.footerView.mj_h = 180;
        self.footerView.accountView.putinTF.placeholder = @"请输入支付宝账号";
        [self.footerView.bankView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else if (indexPath.row == 1) {
        self.footerView.mj_h = 180;
        self.footerView.accountView.putinTF.placeholder = @"请输入微信账号";
        [self.footerView.bankView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else {
        
        self.footerView.mj_h = 240;
        self.footerView.accountView.putinTF.placeholder = @"请输入银行卡号";
        [self.footerView.bankView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@60);
        }];
    }
    [self.tableView reloadData];
}

/// 提交
- (void)submitButtonClick:(UIButton *)btn {
    [self.headerView endEditing:YES];
    
    NSString *account = self.footerView.accountView.putinTF.text;
    NSString *name = self.footerView.nameView.putinTF.text;
    
    if (!self.headerView.moneyTF.text.isValid) {
        [SVProgressHUD showErrorWithStatus: [NSString stringWithFormat:@"请输入不低于%@元的提现金额!",self.limMoney]];
        return;
    }
    double money = self.headerView.moneyTF.text.doubleValue;
    if (money < self.limMoney.floatValue) {
        [SVProgressHUD showErrorWithStatus: [NSString stringWithFormat:@"请输入不低于%@元的提现金额!",self.limMoney]];
        return;
    }
    
    if (self.currentIndex == 2) {
           if (self.footerView.bankView.putinTF.text.length == 0) {
               [SVProgressHUD showErrorWithStatus:@"请输入银行名称"];
               return;
           }
       }
    
    if (!account.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请输入提现账户!"];
        return;
    }
    
   
    
    if ([account isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"提现账户不能包含有空格!"];
        return;
    }
    if (!name.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名!"];
        return;
    }
    if ([name isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"姓名中不能包含有空格!"];
        return;
    }
    NSMutableDictionary *dict = @{
        @"token" : SESSION_TOKEN,
        @"type" : @(self.currentIndex + 1),
        @"money" : self.headerView.moneyTF.text,
        @"account" : account,
        @"realname" : name
    }.mutableCopy;
    if (self.currentIndex == 2) {
        dict[@"bankName"] = self.footerView.bankView.putinTF.text;
    }
    [SVProgressHUD show];
    btn.userInteractionEnabled = NO;
    [LxmNetworking networkingPOST:normal_cash_out parameters:dict returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel *responseObject) {
        [SVProgressHUD dismiss];
        btn.userInteractionEnabled = YES;
        if (responseObject.key.intValue == 1000) {
            LxmTiXianSuccessVC *vc = [LxmTiXianSuccessVC new];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
        btn.userInteractionEnabled = YES;
    }];
}
//全部提现
- (void)allTiXianClick:(UIButton *)btn {
    double money = LxmTool.ShareTool.userModel.balance.doubleValue;
    if (money < self.limMoney.floatValue) {
        [SVProgressHUD showErrorWithStatus: [NSString stringWithFormat:@"请输入不低于%@元的提现金额!",self.limMoney]];
        return;
    }
    self.headerView.moneyTF.text = [NSString stringWithFormat:@"%.2f", money];
    self.headerView.shouxufeiLabel.text = [NSString stringWithFormat:@"提现手续费：¥%.2f", money*[LxmTool ShareTool].userModel.cashRate.floatValue];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField endEditing:YES];
    self.headerView.shouxufeiLabel.text = [NSString stringWithFormat:@"提现手续费：¥%.2f", textField.text.doubleValue *  [LxmTool ShareTool].userModel.cashRate.floatValue];
    if (self.headerView.moneyTF.text.doubleValue < self.limMoney.floatValue) {
        [SVProgressHUD showErrorWithStatus: [NSString stringWithFormat:@"请输入不低于%@元的提现金额!",self.limMoney]];
        return;
    }
}


- (void)textFieldDidChanged {
    if (self.headerView.moneyTF.text.doubleValue > [LxmTool ShareTool].userModel.balance.doubleValue) {
        self.headerView.moneyTF.text = [LxmTool ShareTool].userModel.balance;
        self.headerView.shouxufeiLabel.text = [NSString stringWithFormat:@"提现手续费：¥%.2f", [LxmTool ShareTool].userModel.balance.doubleValue * [LxmTool ShareTool].userModel.cashRate.floatValue];
    }
}

@end
