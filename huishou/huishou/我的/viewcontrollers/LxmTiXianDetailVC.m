//
//  LxmTiXianDetailVC.m
//  huishou
//
//  Created by 李晓满 on 2020/4/2.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmTiXianDetailVC.h"
#import "LxmMineView.h"

@interface LxmTiXianDetailVC ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) LxmTiXianDetailModel *detailModel;

@end

@implementation LxmTiXianDetailVC

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"明细详情";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initView];
    [self loadDetailData];
}

- (void)initView {
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@0.5);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.type.intValue == 1 ? 8 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LxmTiXianDetailMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmTiXianDetailMoneyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[LxmTiXianDetailMoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmTiXianDetailMoneyCell"];
        }
        if (self.type.intValue == 1) {
            cell.titleLabel.text = [NSString stringWithFormat:@"提现到%@", self.detailModel.type.intValue == 1 ? @"支付宝" : self.detailModel.type.intValue == 2 ? @"微信" : @"银行卡"];
        } else if (self.type.intValue == 2) {
            cell.titleLabel.text = @"订单收入";
        }
        
        if ([self.type isEqualToString:@"1"]) {
            if (self.detailModel.money.doubleValue == 0) {
                cell.moneyLabel.text = @"";
            }else {
               cell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",self.detailModel.money.doubleValue];
            }
        }else {
            if (self.detailModel.shop_about_price.doubleValue == 0) {
                cell.moneyLabel.text = @"";
            }else {
               cell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",self.detailModel.shop_about_price.doubleValue];
            }
        }
        return cell;
    }
    LxmTiXianDetailInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmTiXianDetailInfoCell"];
    if (!cell) {
        cell = [[LxmTiXianDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmTiXianDetailInfoCell"];
    }
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightLabel.textColor = CharacterDarkColor;
    if (self.type.intValue == 1) {
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"申请时间";
            cell.rightLabel.text = [self.detailModel.create_time getIntervalToZHXLongTime];
        }else if (indexPath.row == 1) {
            cell.leftLabel.text = @"提现状态";
            if (self.detailModel.status.intValue == 1) {
                cell.rightLabel.textColor = [UIColor redColor];;
                cell.rightLabel.text = @"审核中";
            }else if (self.detailModel.status.intValue == 2) {
                cell.rightLabel.textColor = CharacterDarkColor;
                cell.rightLabel.text = @"已到账";
            }else {
                cell.rightLabel.textColor = [UIColor redColor];
                cell.rightLabel.text = @"提现失败";
            }
        } else if (indexPath.row == 2) {
            cell.leftLabel.text = @"到账时间";
            cell.rightLabel.text = [self.detailModel.update_time getIntervalToZHXLongTime];
        } else if (indexPath.row == 3) {
            cell.leftLabel.text = @"提现到账方式";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@", self.detailModel.type.intValue == 1 ? @"支付宝" : self.detailModel.type.intValue == 2 ? @"微信" : @"银行卡"];
        } else if (indexPath.row == 4) {
           cell.leftLabel.text = @"提现账号";
           cell.rightLabel.text = self.detailModel.account_code;
        }else if (indexPath.row == 5) {
            cell.leftLabel.text = @"账户姓名";
            cell.rightLabel.text = self.detailModel.realname;
        } else if (indexPath.row == 6) {
            cell.leftLabel.text = @"所属银行";
            cell.rightLabel.text = self.detailModel.bank_name;
        }else if (indexPath.row == 7) {
           cell.leftLabel.text = @"提现单号";
           cell.rightLabel.text = self.detailModel.order_code;;
        }
    } else {
        
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"收入单号";
            cell.rightLabel.text = self.detailModel.order_code;;
        }else {
            cell.leftLabel.text = @"到账时间";
            cell.rightLabel.text = [self.detailModel.update_time getIntervalToZHXLongTime];
        }
        
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    if (self.type.intValue == 1) {
        if (indexPath.row == 2) {
            if (self.detailModel.status.intValue == 2) {
                return 35;
            }
            return 0.01;
        }else if (indexPath.row == 5) {
            if (self.detailModel.realname.isValid) {
                return 35;
            }
           return 0.01;
        }else if (indexPath.row == 6) {
            if (self.detailModel.bank_name.isValid) {
                return 35;
            }
           return 0.01;
        }   else if (indexPath.row == 7) {
            if (self.detailModel.order_code.isValid) {
                return 35;
            }
           return 0.01;
        } else  {
            return 35;
        }
    } else {
        if (self.detailModel.update_time.isValid) {
            
            return 35;
        }
        return 0;
    }
}

//明细详情
- (void)loadDetailData {
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:money_detail parameters:@{@"token" : SESSION_TOKEN, @"id" : self.id, @"type" : self.type} returnClass:LxmTiXianDetailRootModel.class success:^(NSURLSessionDataTask *task, LxmTiXianDetailRootModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.intValue == 1000) {
            selfWeak.detailModel = responseObject.result.map;
            [selfWeak.tableView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


@end
