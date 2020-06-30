//
//  LxmSettingVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/18.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmSettingVC.h"
#import "LxmUserInfoVC.h"
#import "LxmShiMingRenZhengVC.h"
#import "LxmZhangHaoVC.h"
#import "LxmLoginVC.h"
#import <SDImageCache.h>

@interface LxmSettingVC ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic , assign) CGFloat cacheSize;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *exitButton;//退出登录

@end

@implementation LxmSettingVC

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
    }
    return _bottomView;
}

- (UIButton *)exitButton {
    if (!_exitButton) {
        _exitButton = [[UIButton alloc] init];
        [_exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_exitButton setTitleColor:RedColor forState:UIControlStateNormal];
        _exitButton.layer.borderColor = RedColor.CGColor;
        _exitButton.layer.borderWidth = 0.5;
        _exitButton.layer.cornerRadius = 3;
        _exitButton.layer.masksToBounds = YES;
        [_exitButton addTarget:self action:@selector(exitClick:) forControlEvents:UIControlEventTouchUpInside];
        _exitButton.titleLabel.font = [UIFont systemFontOfSize:15];;
    }
    return _exitButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    self.cacheSize = SDImageCache.sharedImageCache.diskCache.totalSize/1024/1024;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"设置";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initView];
}

- (void)initView {
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.exitButton];
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
        make.height.equalTo(@(70 + TableViewBottomSpace));
    }];
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(10);
        make.leading.equalTo(self.bottomView).offset(20);
        make.trailing.equalTo(self.bottomView).offset(-20);
        make.height.equalTo(@50);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        UIImageView *accImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 9)];
        accImgView.image = [UIImage imageNamed:@"arrow_right"];
        accImgView.tag = 100;
        [cell addSubview:accImgView];
        
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(cell).offset(15);
            make.bottom.trailing.equalTo(cell);
            make.height.equalTo(@0.5);
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:100];
    cell.accessoryView = imgView;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.hidden = (indexPath.row == 0 || indexPath.row == 2);
    if (indexPath.row == 0) {
        cell.textLabel.text = @"个人资料";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"实名认证";
        cell.detailTextLabel.text = LxmTool.ShareTool.userModel.real_status.intValue == 1 ? @"未认证" : LxmTool.ShareTool.userModel.real_status.intValue == 2 ? @"已认证" : @"待审核";
        cell.detailTextLabel.textColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];

    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"账号与安全";
    } else {
        cell.textLabel.text = @"清理缓存";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",self.cacheSize];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //个人资料
        LxmUserInfoVC *vc = [LxmUserInfoVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        
        if (LxmTool.ShareTool.userModel.real_status.intValue == 2) {
            [SVProgressHUD showErrorWithStatus:@"您已经实名认证过"];
            return;
        }
        
        //实名认证
        if (LxmTool.ShareTool.userModel.real_status.intValue == 1) {
            LxmShiMingRenZhengVC *vc = [LxmShiMingRenZhengVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }

    } else if (indexPath.row == 2) {
        //账号与安全
        LxmZhangHaoVC *vc = [LxmZhangHaoVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        //清理缓存
        [self clearCache];
    }
}

/**
 清除缓存
 */
- (void)clearCache {
    //清除缓存
    if (self.cacheSize > 0) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:nil message:@"确定要清除缓存吗?" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [SDImageCache.sharedImageCache clearDiskOnCompletion:^{
                self.cacheSize = 0;
                [SVProgressHUD showSuccessWithStatus:@"清理成功" ];
                [self.tableView reloadData];
            }];
        }]];
        [self presentViewController:alertView animated:YES completion:nil];
    } else {
        [SVProgressHUD showErrorWithStatus:@"暂无缓存可清理!"];
    }
}

/**
 退出登录
 */
- (void)exitClick:(UIButton *)btn {
    [SVProgressHUD show];
    btn.userInteractionEnabled = NO;
    [LxmNetworking networkingPOST:app_logout parameters:@{@"token":SESSION_TOKEN} returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        btn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] integerValue] == 1000) {
            [SVProgressHUD showSuccessWithStatus:@"已退出登录!"];
            [self.navigationController popViewControllerAnimated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self gotoLogin];
            });
            
        }else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
        btn.userInteractionEnabled = YES;
    }];
}


@end
