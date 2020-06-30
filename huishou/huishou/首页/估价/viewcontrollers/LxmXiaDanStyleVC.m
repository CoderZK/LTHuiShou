//
//  LxmXiaDanStyleVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/25.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmXiaDanStyleVC.h"
#import "LxmGuJiaInfoCell.h"
#import "LxmTiJiaoSuccessVC.h"
#import "LxmYuYueTimeAlert.h"

#import "LxmAddressPickerView.h"

#import "LxmGuJiaNoteAlertView.h"

@interface LxmXiaDanStyleVC ()<LxmAddressPickerViewDelegate>

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) LxmHuiShouBottomView *bottomView;

@property (nonatomic, assign) NSInteger huishouStyle;//回收方式 100 上门回收 101 快递回收

@property (nonatomic, assign) NSInteger startTime;

@property (nonatomic, assign) NSInteger endTime;

@property (nonatomic, strong) NSString *currentData;

@property (nonatomic, strong) NSString *currenTime;

@property (nonatomic, strong) LxmHuiShouStyleInfoCell *infoCell;

@property (nonatomic, strong) LxmAddressPickerView * pickerView;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *area;

@end

@implementation LxmXiaDanStyleVC

- (LxmAddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[LxmAddressPickerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (LxmHuiShouBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[LxmHuiShouBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.2].CGColor;
        _bottomView.layer.shadowRadius = 5;
        _bottomView.layer.shadowOpacity = 0.5;
        _bottomView.layer.shadowOffset = CGSizeMake(0, 0);
        [_bottomView.submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"预估 " attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
               NSAttributedString *str = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.2f",self.gujiModel.high_price.doubleValue - self.gujiaPrice] attributes:@{NSForegroundColorAttributeName:RedColor}];
        [att appendAttributedString:str];
        _bottomView.moneyLabel.attributedText = att;
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"填写下单信息";
    [self initView];
    self.huishouStyle = 100;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LxmGuJiaInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmGuJiaInfoCell"];
        if (!cell) {
            cell = [[LxmGuJiaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmGuJiaInfoCell"];
        }
        cell.nameLabel.text = [NSString stringWithFormat:@"%@估价",self.gujiModel.good_name];
        cell.moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.gujiModel.high_price.doubleValue - self.gujiaPrice];
        WeakObj(self);
        cell.wenBlock = ^{
          //问号
            LxmGuJiaNoteAlertView *aletView = [[LxmGuJiaNoteAlertView alloc] initWithFrame:UIScreen.mainScreen.bounds];
            [aletView show];
        };
        cell.reXunJiaBlock = ^{
          //重新询价
            [selfWeak.navigationController popViewControllerAnimated:YES];
        };
        return cell;
    } else if (indexPath.section == 1) {
        LxmSelectHuiShouStyleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSelectHuiShouStyleCell"];
        if (!cell) {
            cell = [[LxmSelectHuiShouStyleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmSelectHuiShouStyleCell"];
        }
        WeakObj(self);
        cell.huishouStyleBlock = ^(NSInteger index) {
          //100 上门回收 101 快递回收
            selfWeak.huishouStyle = index;
            [selfWeak.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
        };
        return cell;
    }
    LxmHuiShouStyleInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmHuiShouStyleInfoCell"];
    if (!cell) {
        cell = [[LxmHuiShouStyleInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmHuiShouStyleInfoCell"];
    }
    self.infoCell = cell;
    cell.index = self.huishouStyle;
    WeakObj(self);
    [cell.areaView.bgButton addTarget:self action:@selector(xuanzeClick) forControlEvents:UIControlEventTouchUpInside];
    cell.yuyueshijianBlock = ^(LxmHuiShouStyleInfoCell *cell) {
        
        [self.tableView endEditing:YES];
        
        LxmYuYueTimeAlert *alert = [LxmYuYueTimeAlert new];
        alert.currentDate = selfWeak.currentData;
        alert.currentTime = selfWeak.currenTime;
        [alert showWithBlock:^(NSInteger startInterval, NSInteger endInterval,NSString *dataStr) {
            NSArray *arr = [dataStr componentsSeparatedByString:@" "];
            cell.timeView.leftTF.text = dataStr;
            selfWeak.startTime = startInterval;
            selfWeak.endTime = endInterval;
            selfWeak.currentData = arr.firstObject;
            selfWeak.currenTime = arr.lastObject;
        }];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        LxmHuiShouHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmHuiShouHeaderView"];
        if (!headerView) {
            headerView = [[LxmHuiShouHeaderView alloc] initWithReuseIdentifier:@"LxmHuiShouHeaderView"];
        }
        headerView.titleLabel.text = @"选择回收方式";
        headerView.lineView.hidden = YES;
        return headerView;
    } else if (section == 2) {
        LxmHuiShouTextHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmHuiShouTextHeaderView"];
        if (!headerView) {
            headerView = [[LxmHuiShouTextHeaderView alloc] initWithReuseIdentifier:@"LxmHuiShouTextHeaderView"];
        }
        headerView.index = self.huishouStyle;
        return headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section== 2) {
        LxmHuiShouTextFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmHuiShouTextFooterView"];
        if (!footerView) {
            footerView = [[LxmHuiShouTextFooterView alloc] initWithReuseIdentifier:@"LxmHuiShouTextFooterView"];
        }
        [footerView.userProtoButton addTarget:self action:@selector(seeProtocolClick) forControlEvents:UIControlEventTouchUpInside];
        [footerView.yinsiButton addTarget:self action:@selector(yinsiProtocol) forControlEvents:UIControlEventTouchUpInside];
        return footerView;
    }
    return nil;
}

//用户协议
- (void)seeProtocolClick {
    LxmWebViewController *vc = [[LxmWebViewController alloc] init];
    vc.navigationItem.title = @"用户协议";
    vc.loadUrl = [NSURL URLWithString:@"https://huishou.zftgame.com/normal/index.html"];
    [self.navigationController pushViewController:vc animated:YES];
}

//隐私协议
- (void)yinsiProtocol {
    LxmWebViewController *vc = [[LxmWebViewController alloc] init];
    vc.navigationItem.title = @"隐私政策";
    vc.loadUrl = [NSURL URLWithString:@"https://huishou.zftgame.com/normal/yinse.html"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 140;
    } else if (indexPath.section == 1) {
        return 105;
    }
    return self.huishouStyle == 100 ? 270 : 320;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else if (section == 1) {
        return 40;
    }
    NSString *str = self.huishouStyle == 100 ? @"专业质检员上门质检，并实时报价。确保您填入正确的联系方式和地址" : @"顺丰免费上门取件，收货后24小时内检测并付款";
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:0];
    [paragraphStyle setLineBreakMode:(NSLineBreakByCharWrapping)];
    [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    CGFloat titleH = [str getAttSizeWithMaxSize:CGSizeMake(ScreenW - 30, 999) withFontSize:13 paragraphStyle:paragraphStyle].height;
    return 10 + titleH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 40;
    }
    return 0.01;
}


/// 选择地址
- (void)xuanzeClick {
    [self.tableView endEditing:YES];
    [self.pickerView show];
}

/** 取消按钮点击事件*/
- (void)cancelBtnClick {
    [self.pickerView hide];
}
/**
 *  完成按钮点击事件
 *
 *  @param province 当前选中的省份
 *  @param city     当前选中的市
 *  @param area     当前选中的区
 */
- (void)sureBtnClickReturnProvince:(NSString *)province
                              City:(NSString *)city
                              Area:(NSString *)area {
    [self.pickerView hide];
    self.province = province;
    self.city = city;
    self.area = area;
    self.infoCell.areaView.leftTF.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
}


//提交订单
- (void)submitClick:(UIButton *)btn {
   
    
    NSString *name = self.infoCell.nameView.putinTF.text;
    NSString *phone = self.infoCell.phoneView.putinTF.text;
    NSString *detail = self.infoCell.detailAddressView.putinTF.text;
    
    if (!name.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请输入联系人姓名!"];
        return;
    }
    if (!phone.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请输入联系电话!"];
        return;
    }
    if (phone.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位联系电话!"];
        return;
    }
    if (!self.province.isValid || !self.city.isValid || !self.area.isValid) {
           [SVProgressHUD showErrorWithStatus:@"请选择省市区!"];
           return;
       }
    if (!detail.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请输入详情地址!"];
        return;
    }
    if (self.startTime == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择预约上门时间!"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"type"] = self.huishouStyle == 100 ? @1 : @2;
    dict[@"aboutPrice"] = @(self.gujiModel.high_price.doubleValue - self.gujiaPrice);
    dict[@"linkName"] = name;
    dict[@"telephone"] = phone;
    dict[@"province"] = self.province;
    dict[@"city"] = self.city;
    dict[@"district"] = self.area;
    dict[@"addressDetail"] = detail;
    dict[@"start"] = @(self.startTime*1000);
    dict[@"end"] = @(self.endTime*1000);
    dict[@"goodId"] = self.goodId;
    NSArray *dictArray = [LxmGujiaChoicesDataModel mj_keyValuesArrayWithObjectArray:self.chooseArr];
    NSString *content = [dictArray mj_JSONString];
    dict[@"content"] = content;
    dict[@"token"] = SESSION_TOKEN;
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:send_orderTwo parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue] == 1000) {
            LxmTiJiaoSuccessVC *vc = [LxmTiJiaoSuccessVC new];
            vc.orderId = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"data"]];
            vc.address = [NSString stringWithFormat:@"%@%@%@%@",selfWeak.province, selfWeak.city, selfWeak.area, detail];
            vc.meet_date = selfWeak.infoCell.timeView.leftTF.text;
            vc.type = self.huishouStyle == 100 ? 1 : 2;
            [selfWeak.navigationController pushViewController:vc animated:YES];
        } else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
