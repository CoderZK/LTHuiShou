//
//  LxmDaiShangMenOrderDetailVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/27.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmOrderDetailVC.h"
#import "LxmGuJiaInfoCell.h"
#import "LxmMineView.h"
#import "LxmWuLiuInfoVC.h"
#import "LxmJianCeBaoGaoView.h"
#import "MLYPhotoBrowserView.h"

#import "EMChatViewController.h"


@interface LxmOrderDetailVC ()<MLYPhotoBrowserViewDataSource>

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *cancelButton;//取消订单 //或删除订单
//@property (nonatomic, strong) UIButton *deleceButton;//删除订单订单

@property (nonatomic, strong) LxmOrderDetailHeaderView *headerView;

@property (nonatomic, strong) LxmWuLiuInfoRootModel *rootModel;/* 快递信息什么的 */

@property (nonatomic, strong) NSArray <LxmWuLiuInfoStateModel *>*dataArr;

@property (nonatomic, strong) LxmOrderDetailModel *detailModel;

/**  */
@property(nonatomic , strong)UIView *gayView;
/**  */
@property(nonatomic , strong)UIImageView *imgV;
/**  */
@property(nonatomic , strong)UILabel *ttLB;


@end

@implementation LxmOrderDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

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

- (LxmOrderDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LxmOrderDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    }
    return _headerView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"light_gray"] forState:UIControlStateNormal];
        _cancelButton.layer.cornerRadius = 3;
        _cancelButton.layer.masksToBounds = YES;
        [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:CharacterDarkColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton addTarget:self action:@selector(cancelOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UIView *)gayView {
    if (_gayView == nil) {
        _gayView = [[UIView alloc] init];
                _gayView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
//        _gayView.backgroundColor = [UIColor redColor];
    }
    return _gayView;
}


//- (UIButton *)deleceButton {
//    if (!_deleceButton) {
//        _deleceButton = [UIButton new];
//        [_deleceButton setBackgroundImage:[UIImage imageNamed:@"light_gray"] forState:UIControlStateNormal];
//        _deleceButton.layer.cornerRadius = 3;
//        _deleceButton.layer.masksToBounds = YES;
//        [_deleceButton setTitle:@"删除订单" forState:UIControlStateNormal];
//        [_deleceButton setTitleColor:CharacterDarkColor forState:UIControlStateNormal];
//        _deleceButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_deleceButton addTarget:self action:@selector(delectOrderClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _deleceButton;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"订单详情";
    self.tableView.tableHeaderView = self.headerView;
    [self initView];
    self.dataArr = [NSMutableArray array];
    [self loadDetailData];
}

- (void)initView {
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.cancelButton];
    //    [self.bottomView addSubview:self.deleceButton];
    [self.view addSubview:self.gayView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@0.5);
    }];
    
    [self.gayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.lineView.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gayView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    //删除订单和取消订单并行
    //    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.leading.trailing.equalTo(self.view);
    //        make.height.equalTo(@(TableViewBottomSpace + 60+60));
    //    }];
    //删除订单和取消订单互换
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(TableViewBottomSpace + 60));
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(10);
        //        make.centerX.equalTo(self.bottomView);
        make.leading.equalTo(self.bottomView).offset(15);
        make.trailing.equalTo(self.bottomView).offset(-15);
        make.height.equalTo(@40);
    }];
    
    
    
    self.imgV =[[UIImageView alloc] init];
    [self.gayView addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gayView).offset(15);
        make.centerY.equalTo(self.gayView);
        make.height.equalTo(@14);
        make.width.equalTo(@18);
    }];
    
    self.ttLB = [[UILabel alloc] init];
    self.ttLB.textColor = CharacterDarkColor;
    self.ttLB.font = [UIFont systemFontOfSize:14];
    [self.gayView addSubview:self.ttLB];
    [self.ttLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.top.equalTo(self.gayView).offset(10);
        make.left.equalTo(self.imgV.mas_right).offset(5);
        make.right.equalTo(self.gayView).offset(-10);
    }];

    
    //    [self.deleceButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.bottomView).offset(60);
    //        make.leading.equalTo(self.bottomView).offset(15);
    //        make.trailing.equalTo(self.bottomView).offset(-15);
    //        make.height.equalTo(@40);
    //    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {//物流
        if (self.dataArr.count == 0) {
            return 0;
        }
        return 2;
    } else if (section == 1) {//商家信息
        return 4;
    } else if (section == 2) {//检测报告
        return 1;
    } else if (section == 3) {//预约信息
        return 4;
    } else if (section == 4) {//回收前准备
        return self.detailModel.ready.count;
    } else if (section == 5) {//商品信息
        return 1;
    } else {//订单信息
        return 5;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//物流
        if (indexPath.row == 0) {
            LxmMyOrderDetailWuLiuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmMyOrderDetailWuLiuCell"];
            if (!cell) {
                cell = [[LxmMyOrderDetailWuLiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmMyOrderDetailWuLiuCell"];
            }
            if (self.dataArr.count >= 1) {
                cell.model = self.dataArr.firstObject;
            }
            return cell;
        }
        LxmAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmAddressCell"];
        if (!cell) {
            cell = [[LxmAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmAddressCell"];
        }
        if ([self.detailModel.type intValue] == 2) {
            cell.isShop = YES;
        }else{
            cell.isShop = NO;
        }
        cell.detailModel = self.detailModel;
        return cell;
        
    } else if (indexPath.section == 1) {//商家信息
        if (indexPath.row == 3) {
            LxmOrderContactShangJiaCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmOrderContactShangJiaCell"];
            if (!cell) {
                cell = [[LxmOrderContactShangJiaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmOrderContactShangJiaCell"];
            }
            [cell.contactButton addTarget:self action:@selector(contactShangjiaClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        LxmOrderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmOrderDetailCell"];
        if (!cell) {
            cell = [[LxmOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmOrderDetailCell"];
        }
        if (indexPath.row == 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"商家姓名：%@",self.detailModel.shop_username];
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = [NSString stringWithFormat:@"商家电话：%@",self.detailModel.shop_tel];
        } else {
            cell.titleLabel.text = [NSString stringWithFormat:@"商家地址：%@%@%@",self.detailModel.shop_province, self.detailModel.shop_city, self.detailModel.shop_address];
        }
        return cell;
    } else if (indexPath.section == 2) {//检测结果
        LxmOrderDetailJianCeResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmOrderDetailJianCeResultCell"];
        if (!cell) {
            cell = [[LxmOrderDetailJianCeResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmOrderDetailJianCeResultCell"];
        }
        cell.moneyLabel.text = [NSString stringWithFormat:@"¥ %@",self.detailModel.shop_about_price];
        [cell.seeBaoGaoButton addTarget:self action:@selector(seeBaoGaoClick) forControlEvents:UIControlEventTouchUpInside];
        if (self.detailModel.post_status.intValue >= 6) {
            [cell.sureButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            [cell.sureButton setTitle:@"已确认" forState:UIControlStateNormal];
        } else {
            [cell.sureButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
            [cell.sureButton setTitle:@"确认" forState:UIControlStateNormal];
            [cell.sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    } else if (indexPath.section == 3){//预约信息
        LxmOrderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmOrderDetailCell"];
        if (!cell) {
            cell = [[LxmOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmOrderDetailCell"];
        }
        if (indexPath.row == 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"联系人：%@", self.detailModel.link_name];
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = [NSString stringWithFormat:@"联系电话：%@", self.detailModel.link_tel];
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = [NSString stringWithFormat:@"上门地址：%@%@%@%@", self.detailModel.province,self.detailModel.city,self.detailModel.district,self.detailModel.address_detail];
        } else if (indexPath.row == 3) {
            cell.titleLabel.text = [NSString stringWithFormat:@"上门时间：%@", self.detailModel.meet_date];
            
        }
        return cell;
    } else if (indexPath.section == 4){//回收前准备
        LxmTiJiaoSuccessCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmTiJiaoSuccessCell"];
        if (!cell) {
            cell = [[LxmTiJiaoSuccessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmTiJiaoSuccessCell"];
        }
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.detailModel.ready[indexPath.row]];
        return cell;
    } else if (indexPath.section == 5) {//商品信息
        LxmOrderDetailGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmOrderDetailGoodsCell"];
        if (!cell) {
            cell = [[LxmOrderDetailGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmOrderDetailGoodsCell"];
        }
        cell.detailModel = self.detailModel;
        return cell;
    } else {//订单信息
        LxmOrderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmOrderDetailCell"];
        if (!cell) {
            cell = [[LxmOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmOrderDetailCell"];
        }
        if (indexPath.row == 0) {//订单编号
            cell.titleLabel.text = [NSString stringWithFormat:@"订单编号：%@", self.detailModel.order_code];
        } else if (indexPath.row == 1) {//下单时间
            cell.titleLabel.text = [NSString stringWithFormat:@"下单时间：%@", [self.detailModel.create_time getIntervalToZHXLongTime]];
        } else if (indexPath.row == 2) {//发货时间
            
            
            cell.titleLabel.text = [NSString stringWithFormat:@"发货时间：%@", [self.detailModel.deli_time getIntervalToZHXLongTime]];
            
        } else if (indexPath.row == 3) {//成交时间
            cell.titleLabel.text = [NSString stringWithFormat:@"成交时间：%@", [self.detailModel.update_time getIntervalToZHXLongTime]];
        } else {//成交金额
            NSString *str = [NSString stringWithFormat:@"成交金额：¥%@  ", self.detailModel.shop_about_price.getPriceStr];
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"查看支付凭证" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:15/255.0 green:128/255.0 blue:255/255.0 alpha:1.0]}];
            [att appendAttributedString:str1];
            cell.titleLabel.attributedText = att;
        }
        return cell;
        
    }
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
    
    if (section == 1) {
        headerView.titleLabel.text = @"商家信息";
    } else if (section == 2) {
        headerView.titleLabel.text = @"检测结果";
    } else if (section == 3) {
        headerView.titleLabel.text = @"预约信息";
    } else if (section == 4) {
        headerView.titleLabel.text = @"回收前请您提前准备";
    } else if (section == 5) {
        headerView.titleLabel.text = @"商品信息";
    } else if (section == 6){
        headerView.titleLabel.text = @"订单信息";
    }
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LxmOrderDetailFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmOrderDetailFooterView"];
    if (!footerView) {
        footerView = [[LxmOrderDetailFooterView alloc] initWithReuseIdentifier:@"LxmOrderDetailFooterView"];
    }
    if (section == 0) {
        footerView.line.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    } else {
        footerView.line.backgroundColor = UIColor.whiteColor;
    }
    footerView.contentView.backgroundColor = section == 6 ? UIColor.whiteColor : [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.detailModel.type.intValue == 1 ) {//上门
                return 0.01;
            }else {
                if  (self.detailModel.shop_username.length == 0) {//未接单
                    return 0;
                }else {
                    return 80;
                }
            }
            
        } else {
            
            if (self.detailModel.type.intValue == 1 ) {//上门
                if (self.detailModel.link_name.isValid) {
                    return 80;
                }
                return 0.01;
            }else {
                if  (self.detailModel.shop_username.length == 0) {//未接单
                    return 0;
                }else {
                    return 80;
                }
            }
            
            
        }
    } else if (indexPath.section == 1) {
        if (self.detailModel.shop_username.isValid) {
            if (indexPath.row == 3) {
                return 55;
            }
            return 35;
        }
        return 0.01;
    } else if (indexPath.section == 2) {
        if (self.detailModel.shop_about_price.isValid && self.detailModel.type.intValue == 2) {
            //只有是快递上门 切有商家报价的时候 才有检测结果区
            return 110;
        }
        return 0.01;
    } else if (indexPath.section == 3) {
        if (self.detailModel.ready.count == 0) {
            return 0.01;
        }
        return 35;
    } else if (indexPath.section == 4) {
        return 35;
    } else if (indexPath.section == 5) {
        return 100;
    } else {
        if (indexPath.row == 0) {
            if (self.detailModel.order_code.isValid) {
                return 35;
            }
            return 0.01;
        } else if (indexPath.row == 1) {
            if (self.detailModel.create_time.isValid) {
                return 35;
            }
            return 0.01;
        } else if (indexPath.row == 2) {
            if (self.detailModel.deli_time.length > 0) {
                return 35;
            }
            return 0.01;
        } else if (indexPath.row == 3) {
            if (self.detailModel.update_time.isValid) {
                return 35;
            }
            return 0.01;
        } else {
            if (self.detailModel.shop_about_price.isValid && self.detailModel.type.intValue == 1) {
                return 35;
            }
            return 0.01;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        if (self.detailModel.shop_username.isValid) {
            return 40;
        }
        return 0.01;
    } else if (section == 2) {
        if (self.detailModel.shop_about_price.isValid && self.detailModel.type.intValue == 2) {
            return 40;
        }
        return 0.01;
    } else if (section == 3) {
        if (self.detailModel.ready.count == 0) {
            return 0.01;
        }
        return 40;
    } else if (section == 6)  {
        if (self.detailModel.order_code.isValid || self.detailModel.create_time.isValid || (self.dataArr.count >= 1 && self.dataArr[0].list.count >= 1) || self.detailModel.update_time.isValid || (self.detailModel.shop_about_price.isValid && self.detailModel.type.intValue == 1)) {
            return 40;
        }
        return 0.01;
        
    } else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else if (section == 1) {
        if (self.detailModel.shop_username.isValid) {
            return 30;
        }
        return 0.01;
    } else if (section == 2) {
        if (self.detailModel.shop_about_price.isValid && self.detailModel.type.intValue == 2) {
            return 30;
        }
        return 0.01;
    } else if (section == 3) {
        if (self.detailModel.ready.count == 0) {
            return 0.01;
        }
        return 30;
    } else {
        return 30;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.dataArr.count > 0) {
                LxmWuLiuInfoVC *vc = [[LxmWuLiuInfoVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                vc.rootModel = self.rootModel;
                vc.dataArr = self.dataArr;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    } else if (indexPath.section == 6) {
        if (indexPath.row == 4) {
            //查看支付凭证
            MLYPhotoBrowserView *mlyView = [MLYPhotoBrowserView photoBrowserView];
            mlyView.dataSource = self;
            mlyView.currentIndex = 0;
            [mlyView showWithItemsSpuerView:nil];
        }
    }
}


//图片放大
- (NSInteger)numberOfItemsInPhotoBrowserView:(MLYPhotoBrowserView *)photoBrowserView{
    return 1;
}
- (MLYPhoto *)photoBrowserView:(MLYPhotoBrowserView *)photoBrowserView photoForItemAtIndex:(NSInteger)index{
    MLYPhoto *photo = [[MLYPhoto alloc] init];
    photo.imageUrl = [NSURL URLWithString:self.detailModel.pay_pic];
    return photo;
}


/// 取消订单 或 要求退回
- (void)cancelOrderClick:(UIButton *)button  {
    
    NSString * str = @"是否要取消订单";
    if ([button.titleLabel.text isEqualToString:@"删除订单"]) {
        str = @"是否要删除订单";
    }
    
    UIAlertController * alertVC =[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * actionOne = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if ([button.titleLabel.text isEqualToString:@"取消订单"]) {
            [self modifyOrderStatus:@2];
        }else if ([button.titleLabel.text isEqualToString:@"删除订单"]) {
            [self modifyOrderStatus:@3];
        }
        
    }];
    
    [alertVC addAction:actionOne];
    [alertVC addAction:actionTwo];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    
}

//删除订单
- (void)delectOrderClick {
    [self modifyOrderStatus:@3];
}

//确认
- (void)sureClick {
    [self modifyOrderStatus:@1];
}

/// 查看检测报告
- (void)seeBaoGaoClick {
    if (self.detailModel.check_pic.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"暂无检查报告"];
        return;
    }
    NSArray *aa = [self.detailModel.check_pic mj_JSONObject];
    if (![aa isKindOfClass:NSArray.class]) {
        [SVProgressHUD showErrorWithStatus:@"检查报告格式错误"];
        return;
    }
    LxmJianCeBaoGaoView *alertView = [[LxmJianCeBaoGaoView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    alertView.check_pic = aa;
    [alertView show];
}

/// 联系商家 跳转环信
- (void)contactShangjiaClick {
    // ConversationId接收消息方的环信ID:@"user2"
    // type聊天类型:EMConversationTypeChat    单聊类型
    // createIfNotExist 如果会话不存在是否创建会话：YES
    EMChatViewController *chatController = [[EMChatViewController alloc] initWithConversationId:self.detailModel.shop_im_code type:EMConversationTypeChat createIfNotExist:YES];
    chatController.toUserHeadPic = self.detailModel.shop_head_pic;
    chatController.toUserName = self.detailModel.shop_username;
    [self.navigationController pushViewController:chatController animated:YES];
    
    if ([LxmTool ShareTool].userModel.imCode.length == 0) {
        [[LxmTool ShareTool] getHuanXinCodeTwo];
    }
}

/**
 获取物流信息
 数组逆序
 //NSArray *strRevArray = [[strArr reverseObjectEnumerator] allObjects];
 */
- (void)loadWuLiuInfo {
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:way_detailNew parameters:@{@"token":SESSION_TOKEN,@"id":self.orderId} returnClass:LxmWuLiuInfoRootModel.class success:^(NSURLSessionDataTask *task, LxmWuLiuInfoRootModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.integerValue == 1000) {
            selfWeak.rootModel = responseObject;
            for (LxmWuLiuInfoStateModel *model in selfWeak.rootModel.result.list) {
                if (model.list) {
                    model.list = model.list;
                } else {
                    model.list = @[[LxmWuLiuInfoListModel new]];
                }
            }
            selfWeak.dataArr = [[selfWeak.rootModel.result.list reverseObjectEnumerator] allObjects];
            [selfWeak.tableView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

//订单详情接口
- (void)loadDetailData {
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:my_order_detail parameters:@{@"orderId" : self.orderId,@"token" : SESSION_TOKEN} returnClass:LxmOrderDetailRootModel.class success:^(NSURLSessionDataTask *task, LxmOrderDetailRootModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.intValue == 1000) {
            selfWeak.detailModel = responseObject.result.map;
            selfWeak.headerView.detailModel = selfWeak.detailModel;
            if (selfWeak.detailModel.type.intValue == 2) {
                [self loadWuLiuInfo];
            }
            
            if (selfWeak.detailModel.type.intValue == 1) {
                self.imgV.image = [UIImage imageNamed:@"kksm"];
                self.ttLB.text = @"上门回收订单";
            }else {
                self.imgV.image = [UIImage imageNamed:@"kkkd"];
                self.ttLB.text = @"快递回收订单";
            }
            
            if (selfWeak.detailModel.post_status.intValue == 1 || selfWeak.detailModel.post_status.intValue == 2 || selfWeak.detailModel.post_status.intValue == 3 || selfWeak.detailModel.post_status.intValue == 4  || selfWeak.detailModel.post_status.intValue == 5 || selfWeak.detailModel.post_status.intValue == 6 || selfWeak.detailModel.door_status.intValue == 1 || selfWeak.detailModel.door_status.intValue == 2 ) {
                self.cancelButton.hidden = NO;
                [self.cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.gayView.mas_bottom);
                    make.leading.trailing.equalTo(self.view);
                    make.bottom.equalTo(self.bottomView.mas_top);
                }];
                [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.leading.trailing.equalTo(self.view);
                    make.height.equalTo(@(TableViewBottomSpace + 60));
                }];
                [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.bottomView).offset(10);
                    make.leading.equalTo(self.bottomView).offset(15);
                    make.trailing.equalTo(self.bottomView).offset(-15);
                    make.height.equalTo(@40);
                }];
            }else if ((selfWeak.detailModel.post_status.intValue == 9 && selfWeak.detailModel.type.intValue == 2) || (selfWeak.detailModel.door_status.intValue == 6 && selfWeak.detailModel.type.intValue == 1)){
                
                self.cancelButton.hidden = NO;
                [self.cancelButton setTitle:@"删除订单" forState:UIControlStateNormal];
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.gayView.mas_bottom);
                    make.leading.trailing.equalTo(self.view);
                    make.bottom.equalTo(self.bottomView.mas_top);
                }];
                [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.leading.trailing.equalTo(self.view);
                    make.height.equalTo(@(TableViewBottomSpace + 60 ));
                }];
                
                [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.bottomView).offset(10);
                    make.leading.equalTo(self.bottomView).offset(15);
                    make.trailing.equalTo(self.bottomView).offset(-15);
                    make.height.equalTo(@40);
                }];
                
                //                [self.deleceButton mas_updateConstraints:^(MASConstraintMaker *make) {
                //                    make.top.equalTo(self.bottomView).offset(10);
                //                }];
                
            } else {
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.gayView.mas_bottom);
                    make.leading.trailing.equalTo(self.view);
                    make.bottom.equalTo(self.bottomView.mas_top);
                }];
                [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.leading.trailing.equalTo(self.view);
                    make.height.equalTo(@0);
                }];
                [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.bottomView).offset(10);
                    make.centerX.equalTo(self.bottomView);
                    make.leading.equalTo(self.bottomView).offset(15);
                    make.trailing.equalTo(self.bottomView).offset(-15);
                    make.height.equalTo(@0);
                }];
            }
            [selfWeak.tableView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


- (void)modifyOrderStatus:(NSNumber *)status {
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:app_order_status parameters:@{@"token":SESSION_TOKEN, @"orderId" : self.orderId, @"status":status} returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.intValue == 1000) {
            
            
            
            if (status.intValue == 3) {
                [SVProgressHUD showSuccessWithStatus:@"删除订单成功"];
                [LxmEventBus sendEvent:@"actionOrder" data:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else {
                [SVProgressHUD showSuccessWithStatus:status.intValue == 2 ? @"订单已取消" : @"已确认报价"];
                [LxmEventBus sendEvent:@"actionOrder" data:nil];
                [selfWeak loadDetailData];
            }
            
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
