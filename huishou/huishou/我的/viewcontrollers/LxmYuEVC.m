//
//  LxmYuEVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/18.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmYuEVC.h"
#import "LxmMineView.h"
#import "LxmTiXianVC.h"
#import "LxmMingXiListVC.h"
#import "LxmTiXianDetailVC.h"
#import "LxmShiMingRenZhengVC.h"
@interface LxmYuEVC ()

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) LxmYuEView *topView;

@property (nonatomic, strong) UIButton *leftButton;//返回按钮

@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UIView *bottomView;//底部按钮视图

@property (nonatomic, strong) UIButton *tixianButton;//提现

@property (nonatomic, strong) LxmEmptyView *emptyView;//空界面

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger allPageNum;

@property (nonatomic, strong) NSMutableArray <LxmTiXianModel *>*dataArr;

@end

@implementation LxmYuEVC

- (LxmEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[LxmEmptyView alloc] init];
        _emptyView.textLabel.text = @"暂无明细";
        _emptyView.imgView.image = [UIImage imageNamed:@"empty"];
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        _bgImgView.image = [UIImage imageNamed:@"yu_e_bg"];
    }
    return _bgImgView;
}

- (LxmYuEView *)topView {
    if (!_topView) {
        _topView = [LxmYuEView new];
        [_topView.tixianButton addTarget:self action:@selector(tixianClick:) forControlEvents:UIControlEventTouchUpInside];
        _topView.moneyLabel.text = [NSString stringWithFormat:@"%.2f", LxmTool.ShareTool.userModel.balance.doubleValue];
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.text = @"余额";
    }
    return _titleLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.2].CGColor;
        _bottomView.layer.shadowRadius = 5;
        _bottomView.layer.shadowOpacity = 0.5;
        _bottomView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _bottomView;
}

- (UIButton *)tixianButton {
    if (!_tixianButton) {
        _tixianButton = [UIButton new];
        [_tixianButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        _tixianButton.layer.cornerRadius = 3;
        _tixianButton.layer.masksToBounds = YES;
        [_tixianButton setTitle:@"提现" forState:UIControlStateNormal];
        [_tixianButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _tixianButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_tixianButton addTarget:self action:@selector(tixianClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tixianButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initSubViews];
    
    self.dataArr = [NSMutableArray array];
    self.allPageNum = 1;
    self.page = 1;
    [self loadData];
    WeakObj(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        StrongObj(self);
        self.page = 1;
        self.allPageNum = 1;
        [self loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        StrongObj(self);
        [self loadData];
    }];
}

- (void)initSubViews {
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.tixianButton];
    [self.view addSubview:self.emptyView];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(ScreenW * 215/375));
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationSpace - 39);
        make.leading.equalTo(self.view).offset(15);
        make.width.equalTo(@49);
        make.height.equalTo(@37);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.leftButton);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImgView.mas_bottom).offset(-130);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@160);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.view);
        make.height.equalTo(@(TableViewBottomSpace + 60));
    }];
    [self.tixianButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(10);
        make.centerX.equalTo(self.bottomView);
        make.leading.equalTo(self.bottomView).offset(15);
        make.trailing.equalTo(self.bottomView).offset(-15);
        make.height.equalTo(@40);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImgView.mas_bottom).offset(60);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmYuECell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmYuECell"];
    if (!cell) {
        cell = [[LxmYuECell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmYuECell"];
    }
    cell.tixianModel = self.dataArr[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LxmYuEHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmYuEHeaderView"];
    if (!headerView) {
        headerView = [[LxmYuEHeaderView alloc] initWithReuseIdentifier:@"LxmYuEHeaderView"];
    }
    [headerView.bgButton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmTiXianDetailVC *vc = [LxmTiXianDetailVC new];
    vc.id = self.dataArr[indexPath.row].id;
    vc.type = self.dataArr[indexPath.row].type;
    [self.navigationController pushViewController:vc animated:YES];
}


/// 返回
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

/// 提现
- (void)tixianClick:(UIButton *)btn {
    if (LxmTool.ShareTool.userModel.real_status.intValue == 2) {
        //已实名的用户才可以提现
        LxmTiXianVC *vc = [LxmTiXianVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (LxmTool.ShareTool.userModel.real_status.intValue == 1){
//        [SVProgressHUD showErrorWithStatus:@"必须先通过实名认证,才可以进行提现操作!"];
        
        LxmShiMingRenZhengVC *vc = [LxmShiMingRenZhengVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (LxmTool.ShareTool.userModel.real_status.intValue == 3){
    
        [SVProgressHUD showErrorWithStatus:@"您的实名认证正在审核中,暂不能提现"];
    }
}

/**
 请求数据
 */
- (void)loadData {
    if (self.page <= self.allPageNum) {
        if (self.dataArr.count <= 0) {
            [SVProgressHUD show];
        }
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"token"] = SESSION_TOKEN;
        dict[@"pageNum"] =  @(self.page);
        dict[@"pageSize"] = @10;
        [LxmNetworking networkingPOST:money_list parameters:dict returnClass:LxmTiXianRootModel.class success:^(NSURLSessionDataTask *task, LxmTiXianRootModel *responseObject) {
            [self endRefrish];
            if (responseObject.key.intValue == 1000) {
                self.allPageNum = responseObject.result.allPageNumber.intValue;
                if (self.page == 1) {
                    [self.dataArr removeAllObjects];
                }
                if (self.page <= responseObject.result.allPageNumber.intValue) {
                    [self.dataArr addObjectsFromArray:responseObject.result.list];
                }
                self.page ++;
                self.emptyView.hidden = self.dataArr.count > 0;
                [self.tableView reloadData];
            } else {
                [UIAlertController showAlertWithmessage:responseObject.message];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self endRefrish];
        }];
    }
}

- (void)moreClick {
    LxmMingXiListVC *vc = [LxmMingXiListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
