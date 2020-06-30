//
//  LxmTiXianSuccessVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/27.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmTiXianSuccessVC.h"

@interface LxmTiXianSuccessVC ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIImageView *successImgView;//

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation LxmTiXianSuccessVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.view.bounds.size.height - 0.5)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UIImageView *)successImgView {
    if (!_successImgView) {
        _successImgView = [UIImageView new];
        _successImgView.image = [UIImage imageNamed:@"tixian_success"];
    }
    return _successImgView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = CharacterDarkColor;
        _textLabel.text = @"你的提现申请已提交，请耐心等待";
    }
    return _textLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    self.navigationItem.title = @"提现";
    [self initView];
}

- (void)initView {
    [self.view addSubview:self.lineView];
    [self.headerView addSubview:self.successImgView];
    [self.headerView addSubview:self.textLabel];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@0.5);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.bottom.leading.trailing.equalTo(self.view);
    }];
    [self.successImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textLabel.mas_top).offset(-43);
        make.centerX.equalTo(self.headerView);
        make.width.height.equalTo(@60);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.centerY.equalTo(self.headerView).offset(-50);
    }];
}


@end
