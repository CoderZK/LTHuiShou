
//
//  LxmTiJiaoSuccessVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/26.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmTiJiaoSuccessVC.h"
#import "LxmGuJiaInfoCell.h"
#import "LxmMyOrderVC.h"

@interface LxmTiJiaoSuccessVC ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) LxmTiJiaoSuccessBottomView *bottomView;

@property (nonatomic, strong) LxmTiJiaoSuccessHeaderView *headerView;
@property(nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation LxmTiJiaoSuccessVC

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (LxmTiJiaoSuccessBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[LxmTiJiaoSuccessBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.2].CGColor;
        _bottomView.layer.shadowRadius = 5;
        _bottomView.layer.shadowOpacity = 0.5;
        _bottomView.layer.shadowOffset = CGSizeMake(0, 0);
        [_bottomView.leftButton addTarget:self action:@selector(backToRootClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.rightButton addTarget:self action:@selector(seeOrderClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

- (LxmTiJiaoSuccessHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LxmTiJiaoSuccessHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 300)];
        _headerView.backgroundColor = UIColor.whiteColor;
        
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"提交成功";
    self.tableView.tableHeaderView = self.headerView;
    
    if (self.type == 2) {
        self.headerView.textLabel2.text = @"请保持电话畅通，快递小哥将上门取件";
    }else {
        self.headerView.textLabel2.text = @"请保持电话畅通，工程师将上门服务";
    }
    
    [self initView];
    self.headerView.address = self.address;
    self.headerView.time = self.meet_date;
    NSString *addressDetail = [NSString stringWithFormat:@"上门地址：%@", self.address];
    CGFloat H = [addressDetail getSizeWithMaxSize:CGSizeMake(ScreenW - 80, 9999) withFontSize:14].height;
    self.headerView.frame = CGRectMake(0, 0, ScreenW, 280 + H);
    [self.headerView layoutIfNeeded];
    
    self.dataArray = @[].mutableCopy;
    [self getData];
 
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        [self getData];
//    }];
//
    self.tableView.estimatedRowHeight = 35;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
}

- (void)initView {
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.bottomView];
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
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @(self.type);
    dict[@"token"] = TOKEN;
    [LxmNetworking networkingPOST:ready_info parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] integerValue] == 1000) {
            self.dataArray = responseObject[@"result"][@"list"];
            [self.tableView reloadData];
               
               } else {
                   [UIAlertController showAlertWithmessage:responseObject[@"message"]];
               }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         [SVProgressHUD dismiss];
    }];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmTiJiaoSuccessCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmTiJiaoSuccessCell"];
    if (!cell) {
        cell = [[LxmTiJiaoSuccessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmTiJiaoSuccessCell"];
    }
    cell.numLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LxmHuiShouHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmHuiShouHeaderView"];
    if (!headerView) {
        headerView = [[LxmHuiShouHeaderView alloc] initWithReuseIdentifier:@"LxmHuiShouHeaderView"];
        [headerView.redLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(headerView).offset(15);
            make.centerY.equalTo(headerView);
            make.width.equalTo(@4.5);
            make.height.equalTo(@15);
        }];
    }
    headerView.titleLabel.text = @"回收前请您提前准备";
    return headerView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 35;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


/// 回到首页
- (void)backToRootClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/// 查看订单
- (void)seeOrderClick {
    
    LxmOrderDetailVC *vc = [[LxmOrderDetailVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.orderId = self.orderId;
    [self.navigationController pushViewController:vc animated:YES];
//    [LxmEventBus sendEvent:@"pushOrderDetail" data:@{@"orderId" : self.orderId}];
    
    
    
}

@end
