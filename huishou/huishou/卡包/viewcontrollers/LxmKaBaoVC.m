//
//  LxmKaBaoVC.m
//  回收
//
//  Created by 李晓满 on 2020/3/11.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmKaBaoVC.h"
#import "LxmKaBaoView.h"
#import "LxmCardDetailVC.h"
#import "LxmYiKaiKaDetailVC.h"

@interface LxmKaBaoVC ()

@end

@implementation LxmKaBaoVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"卡包";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(1);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LxmKaBaoEmptyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmKaBaoEmptyCell"];
        if (!cell) {
            cell = [[LxmKaBaoEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmKaBaoEmptyCell"];
        }
        return cell;
    } else {
        LxmKaBaoCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmKaBaoCardCell"];
        if (!cell) {
            cell = [[LxmKaBaoCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmKaBaoCardCell"];
        }
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LxmKaBaoHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmKaBaoHeaderView"];
    if (!headerView) {
        headerView = [[LxmKaBaoHeaderView alloc] initWithReuseIdentifier:@"LxmKaBaoHeaderView"];
    }
    headerView.titleLabel.text = section == 0 ? @"我的交通卡" : @"更多公交卡";
    headerView.moreLabel.hidden = section == 0;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LxmCardDetailVC *vc = [[LxmCardDetailVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        LxmYiKaiKaDetailVC *vc = [[LxmYiKaiKaDetailVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
