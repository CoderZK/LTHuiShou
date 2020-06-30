//
//  LxmModifyPhoneFirstVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/23.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmModifyPhoneFirstVC.h"
#import "LxmFirstFindPasswordVC.h"
#import "LxmModifyPasswordVC.h"
#import "LxmFirstFindPasswordVC.h"

@interface LxmModifyPhoneFirstVC ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UILabel *currentPhoneLabel;//当前手机号

@property (nonatomic, strong) UIButton *modifyPhoneButton;//更改手机号

@end

@implementation LxmModifyPhoneFirstVC

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

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textColor = CharacterDarkColor;
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.text = @"已绑定手机号码";
    }
    return _textLabel;
}

- (UILabel *)currentPhoneLabel {
    if (!_currentPhoneLabel) {
        _currentPhoneLabel = [UILabel new];
        _currentPhoneLabel.textColor = CharacterDarkColor;
        _currentPhoneLabel.font = [UIFont boldSystemFontOfSize:23];
        NSString *phone = LxmTool.ShareTool.userModel.telephone;
        if (phone.length == 11) {
            NSString *rePhone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
            _currentPhoneLabel.text = rePhone;
        }
    }
    return _currentPhoneLabel;
}

- (UIButton *)modifyPhoneButton {
    if (!_modifyPhoneButton) {
        _modifyPhoneButton = [UIButton new];
        [_modifyPhoneButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        _modifyPhoneButton.layer.cornerRadius = 3;
        _modifyPhoneButton.layer.masksToBounds = YES;
        [_modifyPhoneButton setTitle:@"更改手机号" forState:UIControlStateNormal];
        [_modifyPhoneButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _modifyPhoneButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_modifyPhoneButton addTarget:self action:@selector(modifyPhoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modifyPhoneButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更改手机号";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    [self initView];
}

- (void)initView {
    [self.view addSubview:self.lineView];
    [self.headerView addSubview:self.textLabel];
    [self.headerView addSubview:self.currentPhoneLabel];
    [self.headerView addSubview:self.modifyPhoneButton];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@0.5);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(36);
        make.centerX.equalTo(self.headerView);
    }];
    [self.currentPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel.mas_bottom).offset(28);
        make.centerX.equalTo(self.headerView);
    }];
    [self.modifyPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.currentPhoneLabel.mas_bottom).offset(55);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@40);
    }];
}

/// 更改手机号
- (void)modifyPhoneButtonClick:(UIButton *)btn {
    LxmFirstFindPasswordVC *vc = [[LxmFirstFindPasswordVC alloc] initWithTableViewStyle:UITableViewStyleGrouped type:LxmFirstFindPasswordVC_type_modifyPhoneFirst];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
