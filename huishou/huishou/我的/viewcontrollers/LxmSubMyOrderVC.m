//
//  LxmSubMyOrderVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/27.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmSubMyOrderVC.h"
#import "LxmMineView.h"
#import "LxmOrderDetailVC.h"

@interface LxmSubMyOrderVC ()

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray <LxmOrderModel *>*dataArr;

@property (nonatomic, assign) NSInteger allPageNum;

@property (nonatomic, strong) LxmEmptyView *emptyView;//空界面

@end

@implementation LxmSubMyOrderVC

- (LxmEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[LxmEmptyView alloc] init];
        _emptyView.textLabel.text = @"暂无订单哦~";
        _emptyView.imgView.image = [UIImage imageNamed:@"empty"];
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(self.view);
    }];
    
    [LxmEventBus registerEvent:@"actionOrder" block:^(id data) {
        StrongObj(self);
        self.page = 1;
        self.allPageNum = 1;
        [self loadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmOrderListCell"];
    if (!cell) {
        cell = [[LxmOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmOrderListCell"];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 7.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmOrderDetailVC *vc = [[LxmOrderDetailVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.orderId = self.dataArr[indexPath.row].id;
    [self.navigationController pushViewController:vc animated:YES];
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
        dict[@"type"] = self.type;
        [LxmNetworking networkingPOST:my_order parameters:dict returnClass:LxmOrderRootModel.class success:^(NSURLSessionDataTask *task, LxmOrderRootModel *responseObject) {
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

@end
