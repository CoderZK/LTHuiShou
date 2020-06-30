//
//  LxmCardDetailVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/13.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmCardDetailVC.h"
#import "LxmKaBaoView.h"
#import "LxmChongZhiVC.h"

@interface LxmCardDetailVC ()

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) LxmKaDetailView *topView;

@property (nonatomic, strong) UIButton *leftButton;//返回按钮

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) LxmKaDetailBottomView *bottomMainView;

@property (nonatomic, strong) LxmKaDetailMingXiView *selectedView;

@end

@implementation LxmCardDetailVC

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        _bgImgView.image = [UIImage imageNamed:@"kadetail_bg"];
    }
    return _bgImgView;
}


- (LxmKaDetailView *)topView {
    if (!_topView) {
        _topView = [LxmKaDetailView new];
    }
    return _topView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton new];
        [_leftButton setImage:[UIImage imageNamed:@"nav_white_back"] forState:UIControlStateNormal];
        _leftButton.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 40);
        [_leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
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

- (LxmKaDetailBottomView *)bottomMainView {
    if (!_bottomMainView) {
        _bottomMainView = [LxmKaDetailBottomView new];
        [_bottomMainView.mingxiButton addTarget:self action:@selector(mingxiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomMainView.sureKaiTongButton addTarget:self action:@selector(querenkaiTongClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomMainView;
}

- (LxmKaDetailMingXiView *)selectedView {
    if (!_selectedView) {
        _selectedView = [LxmKaDetailMingXiView new];
    }
    return _selectedView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initSubViews];
}

- (void)initSubViews {
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.bottomMainView];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(ScreenW * 221/375));
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationSpace - 39);
        make.leading.equalTo(self.view).offset(15);
        make.width.equalTo(@49);
        make.height.equalTo(@37);
    }];
   
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImgView.mas_bottom).offset(-130);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@220);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(70 + TableViewBottomSpace));
    }];
    [self.bottomMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.bottomView);
        make.height.equalTo(@70);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LxmKaDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmKaDetailCell"];
        if (!cell) {
            cell = [[LxmKaDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmKaDetailCell"];
        }
        return cell;
    }
    LxmKaDetailMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmKaDetailMoneyCell"];
    if (!cell) {
        cell = [[LxmKaDetailMoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmKaDetailMoneyCell"];
    }
    WeakObj(self);
    cell.selectMoneyBlock = ^{
        [selfWeak.tableView reloadData];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LxmKaDetailheaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmKaDetailheaderView"];
    if (!headerView) {
        headerView = [[LxmKaDetailheaderView alloc] initWithReuseIdentifier:@"LxmKaDetailheaderView"];
    }
    headerView.textLabel0.text = section == 0 ? @"邳州电子公交卡" : @"卡片费用";
    headerView.lineView.hidden = section == 0;
    headerView.iconImgView.hidden = section == 0;
    headerView.textLabel1.hidden = section == 0;
    headerView.textLabel1.text = @"¥20.00";
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 40;
    }
    return ceil(6/3.0)*60 + 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

/// 返回
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mingxiButtonClick:(UIButton *)btn {
    if (self.selectedView.superview) {
        [self.selectedView dismiss];
    } else {
        [self.selectedView showAtView:self.view];
    }
}

/// 确认开通
- (void)querenkaiTongClick:(UIButton *)btn {
    LxmChongZhiVC *vc = [LxmChongZhiVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
