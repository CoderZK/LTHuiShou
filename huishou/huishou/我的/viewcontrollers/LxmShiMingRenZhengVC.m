//
//  LxmShiMingRenZhengVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/18.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmShiMingRenZhengVC.h"
#import "LxmLoginView.h"
#import "LxmGuJiaInfoCell.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "MXPhotoPickerController.h"
#import "UIViewController+MXPhotoPicker.h"
#import "zkPickView.h"
#import "LxmAddressPickerView.h"
#import "SelectTimeV.h"

@interface LxmShiMingRenZhengVC ()<zkPickViewDelelgate,LxmAddressPickerViewDelegate>

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *headerView;

@property(nonatomic , strong)LxmHuiShouSelectView *carTypeV;//账号类型
@property (nonatomic, strong) LxmPutinView *cardNoView;//银行卡号
@property (nonatomic, strong) LxmPutinView *bankNameView;//开户行
@property (nonatomic, strong) LxmPutinView *carAddressV;//开卡地点
@property (nonatomic, strong) LxmPutinView *nameView;//姓名
@property (nonatomic, strong) LxmPutinView *carPhoneV;//开户手机号
@property(nonatomic , strong)UIView *backOneV;//第一条灰色的线
@property(nonatomic , strong)LxmHuiShouSelectView *voucherTypeV;//证件类型
@property(nonatomic , strong)UIView *timeV;//时间
@property(nonatomic , strong)UITextField *startTF,*stopTF;
@property(nonatomic , strong)UIButton *startBt,*stopBt;
@property(nonatomic , strong)LxmHuiShouSelectView *addressV;//地址
@property (nonatomic, strong) LxmPutinView *detailAddressV;//详细地址
@property (nonatomic, strong) UILabel *textLabel;//说明
@property (nonatomic, strong) UIImageView *cardImgView;//身份证
@property (nonatomic, strong) UIImageView *cardImgViewTwo;//身份证
@property (nonatomic, strong) UIButton *submitButton;//提交

@property (nonatomic, strong) LxmPutinView *idNoView;//身份证号
@property(nonatomic , assign)BOOL isFanMian,isChooseCarType;
@property(nonatomic , strong)NSArray *carTypeOneArr,*carTypeTwoArr,*shenFenOneArr;
@property(nonatomic , strong)NSString *carTypeStr ,* shenFenTwoStr,*province,*city,*area;
@property(nonatomic , assign)double cardStart,cardEnd;


@property (nonatomic, strong) LxmAddressPickerView * pickerView;




@property (nonatomic, strong) NSString *cardPic;
@property (nonatomic, strong) NSString *cardPicTwo;

@end

@implementation LxmShiMingRenZhengVC


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


-(LxmHuiShouSelectView *)carTypeV {
    if (!_carTypeV) {
        _carTypeV = [LxmHuiShouSelectView new];
        _carTypeV.leftTF.placeholder = @"请选择账户类型";
        _carTypeV.leftTF.userInteractionEnabled = NO;
        _carTypeV.bgButton.tag = 100;
        [_carTypeV.bgButton addTarget:self action:@selector(carTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _carTypeV;
}

- (LxmPutinView *)cardNoView {
    if (!_cardNoView) {
        _cardNoView = [LxmPutinView new];
        _cardNoView.putinTF.placeholder = @"请输入银行卡号";
        _cardNoView.putinTF.keyboardType = UIKeyboardTypeNumberPad;
        [_cardNoView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_cardNoView layoutIfNeeded];
        _cardNoView.putinTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _cardNoView;
}

- (LxmPutinView *)bankNameView {
    if (!_bankNameView) {
        _bankNameView = [LxmPutinView new];
        _bankNameView.putinTF.placeholder = @"请输入账户所属银行";
        [_bankNameView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_bankNameView layoutIfNeeded];
    }
    return _bankNameView;
}

-(LxmPutinView *)carAddressV {
    if (!_carAddressV) {
        _carAddressV = [LxmPutinView new];
        _carAddressV.putinTF.placeholder = @"请输入账户开户行";
        [_carAddressV.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_carAddressV layoutIfNeeded];
    }
    return _carAddressV;
}


- (LxmPutinView *)nameView {
    if (!_nameView) {
        _nameView = [LxmPutinView new];
        _nameView.putinTF.placeholder = @"请输入真实姓名";
        [_nameView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_nameView layoutIfNeeded];
    }
    return _nameView;
}

-(LxmPutinView *)carPhoneV {
    if (!_carPhoneV) {
        _carPhoneV = [LxmPutinView new];
        _carPhoneV.putinTF.placeholder = @"请输入手机号";
        _carPhoneV.putinTF.keyboardType = UIKeyboardTypePhonePad;
        [_carPhoneV.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [_carPhoneV layoutIfNeeded];
    }
    return _carPhoneV;
}


-(UIView *)backOneV {
    if (_backOneV == nil) {
        _backOneV = [[UIView alloc] init];
        _backOneV.backgroundColor =[UIColor groupTableViewBackgroundColor];
    }
    return _backOneV;
}


-(LxmHuiShouSelectView *)voucherTypeV {
    if (!_voucherTypeV) {
        _voucherTypeV = [LxmHuiShouSelectView new];
        _voucherTypeV.leftTF.placeholder = @"请选择证件类型";
        _voucherTypeV.leftTF.userInteractionEnabled = NO;
        _voucherTypeV.bgButton.tag = 101;
        [_voucherTypeV.bgButton addTarget:self action:@selector(carTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voucherTypeV;
}

-(UIView *)timeV {
    if (_timeV == nil) {
        _timeV = [[UIView alloc] init];
        
        self.startTF =  [[UITextField alloc] initWithFrame:CGRectMake(15, 15, (ScreenW - 90) / 2 , 30)];
        self.startTF.font = [UIFont systemFontOfSize:14];
        self.startTF.textColor = CharacterDarkColor;
        self.startTF.placeholder = @"请选择起始日期";
        self.startTF.userInteractionEnabled = NO;
        [_timeV addSubview:self.startTF];
        
        self.startBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, (ScreenW - 90) / 2 , 30)];
        self.startBt.tag = 103;
        [self.startBt addTarget:self action:@selector(carTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        //        self.startBt.backgroundColor = [UIColor redColor];
        [_timeV addSubview:self.startBt];
        
        
        UIView * lineVOne = [[UIView alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(self.startTF.frame), (60-1)/2, 20, 1)];
        lineVOne.backgroundColor =[UIColor blackColor];
        [_timeV addSubview:lineVOne];
        
        
        self.stopTF =  [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineVOne.frame) +20, 15, (ScreenW - 90) / 2 , 30)];
        self.stopTF.font = [UIFont systemFontOfSize:14];
        self.stopTF.textColor = CharacterDarkColor;
        self.stopTF.placeholder = @"请选择截止日期";
        self.stopTF.userInteractionEnabled = NO;
        [_timeV addSubview:self.stopTF];
        
        
        self.stopBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineVOne.frame) +20, 15, (ScreenW - 90) / 2 , 30)];
        [_timeV addSubview:self.stopBt];
        [self.stopBt addTarget:self action:@selector(carTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        self.stopBt.tag = 104;
        
        
        UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(15, 55.5, ScreenW - 30, 0.5)];
        lineV.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        [_timeV addSubview:lineV];
        
        
        
        
    }
    return _timeV;
}


-(LxmHuiShouSelectView *)addressV {
    if (!_addressV) {
        _addressV = [LxmHuiShouSelectView new];
        _addressV.leftTF.placeholder = @"请选择地址";
        _addressV.leftTF.userInteractionEnabled = NO;
        _addressV.bgButton.tag = 102;
        [_addressV.bgButton addTarget:self action:@selector(carTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressV;
}

-(LxmPutinView *)detailAddressV {
    if (!_detailAddressV) {
        _detailAddressV = [LxmPutinView new];
        _detailAddressV.putinTF.placeholder = @"请输入详细地址";
        [_detailAddressV.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_detailAddressV layoutIfNeeded];
    }
    return _detailAddressV;
}

- (UIView *)headerView {
    if (!_headerView) {
        CGFloat ww = (ScreenW - 45)/2;
        CGFloat hh = ww * 93/163;
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 850 + hh + 30)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}



- (LxmPutinView *)idNoView {
    if (!_idNoView) {
        _idNoView = [LxmPutinView new];
        _idNoView.putinTF.placeholder = @"请输入证件号码";
        _idNoView.putinTF.keyboardType = UIKeyboardTypeNumberPad;
        [_idNoView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_idNoView layoutIfNeeded];
    }
    return _idNoView;
}




- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.text = @"上传证件照，确保证件照上的姓名及证件号清晰可见";
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (UIImageView *)cardImgView {
    if (!_cardImgView) {
        _cardImgView = [UIImageView new];
        _cardImgView.image = [UIImage imageNamed:@"zheng81"];
        _cardImgView.contentMode = UIViewContentModeScaleAspectFill;
        _cardImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadCardClick:)];
        [_cardImgView addGestureRecognizer:tap];
        _cardImgView.tag = 123;
        _cardImgView.clipsToBounds = YES;
    }
    return _cardImgView;
}

-(UIImageView *)cardImgViewTwo {
    if (!_cardImgViewTwo) {
        _cardImgViewTwo = [UIImageView new];
        _cardImgViewTwo.image = [UIImage imageNamed:@"fan81"];
        _cardImgViewTwo.contentMode = UIViewContentModeScaleAspectFill;
        _cardImgViewTwo.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadCardClick:)];
        [_cardImgViewTwo addGestureRecognizer:tap];
        _cardImgViewTwo.tag = 124;
        _cardImgViewTwo.clipsToBounds = YES;
    }
    return _cardImgViewTwo;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton new];
        [_submitButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 3;
        _submitButton.layer.masksToBounds = YES;
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showSuccessWithStatus:@"您还未实名认证"];
    self.carTypeOneArr  = @[@"借记卡",@"贷记卡",@"准贷记卡",@"基本户",@"一般户"];
    self.carTypeTwoArr = @[@"D",@"C",@"SC",@"JB",@"YB"];
    self.shenFenOneArr = @[@"身份证",@"护照",@"港澳通行证",@"台湾往来大陆通行证",@"临时身份证"];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"实名认证";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    [self initView];
    [self setConstrains];
}

- (void)initView {
    
    
    
    [self.view addSubview:self.lineView];
    [self.headerView addSubview:self.carTypeV];
    [self.headerView addSubview:self.cardNoView];
    [self.headerView addSubview:self.bankNameView];
    [self.headerView addSubview:self.carAddressV];
    [self.headerView addSubview:self.nameView];
    [self.headerView addSubview:self.carPhoneV];
    [self.headerView addSubview:self.backOneV];
    [self.headerView addSubview:self.voucherTypeV];
    [self.headerView addSubview:self.idNoView];
    [self.headerView addSubview:self.timeV];
    [self.headerView addSubview:self.addressV];
    [self.headerView addSubview:self.detailAddressV];
    [self.headerView addSubview:self.textLabel];
    [self.headerView addSubview:self.cardImgView];
    [self.headerView addSubview:self.cardImgViewTwo];
    [self.headerView addSubview:self.submitButton];
    //    self.tableView.tableHeaderView = self.headerView;
}

- (void)setConstrains {
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@0.5);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
    [self.carTypeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView);
        make.leading.equalTo(self.headerView).offset(0);
        make.trailing.equalTo(self.headerView).offset(0);
        make.height.equalTo(@60);
    }];
    [self.cardNoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carTypeV.mas_bottom);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    [self.bankNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardNoView.mas_bottom);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    [self.carAddressV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNameView.mas_bottom);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carAddressV.mas_bottom);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    
    [self.carPhoneV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameView.mas_bottom);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    
    
    [self.backOneV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carPhoneV.mas_bottom);
        make.leading.equalTo(self.headerView).offset(0);
        make.trailing.equalTo(self.headerView).offset(0);
        make.height.equalTo(@10);
    }];
    
    [self.voucherTypeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backOneV.mas_bottom);
        make.leading.equalTo(self.headerView).offset(0);
        make.trailing.equalTo(self.headerView).offset(0);
        make.height.equalTo(@60);
    }];
    
    [self.idNoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.voucherTypeV.mas_bottom);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    
    [self.timeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idNoView.mas_bottom);
        make.leading.equalTo(self.headerView).offset(0);
        make.trailing.equalTo(self.headerView).offset(0);
        make.height.equalTo(@60);
    }];
    
    [self.addressV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeV.mas_bottom);
        make.leading.equalTo(self.headerView).offset(0);
        make.trailing.equalTo(self.headerView).offset(0);
        make.height.equalTo(@60);
    }];
    
    [self.detailAddressV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressV.mas_bottom);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@60);
    }];
    
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailAddressV.mas_bottom).offset(20);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@20);
    }];
    CGFloat ww = (ScreenW - 45)/2;
    CGFloat hh = ww * 93/163;
    
    [self.cardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel.mas_bottom).offset(20);
        make.leading.equalTo(self.headerView).offset(15);
        make.width.equalTo(@(ww));
        make.height.equalTo(@(hh));
    }];
    
    [self.cardImgViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel.mas_bottom).offset(20);
        make.leading.equalTo(self.cardImgView.mas_trailing).offset(15);
        make.width.equalTo(@(ww));
        make.height.equalTo(@(hh));
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardImgView.mas_bottom).offset(60);
        make.leading.equalTo(self.headerView).offset(15);
        make.trailing.equalTo(self.headerView).offset(-15);
        make.height.equalTo(@40);
    }];
    
    //    self.headerView.mj_h = CGRectGetMaxY(self.submitButton.frame) +  30;
    
}

- (void)carTypeClick:(UIButton *)button {
    [self.tableView endEditing:YES];
    if (button.tag == 100) {
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = titleArray;
        self.isChooseCarType = YES;
        picker.array = self.carTypeOneArr.mutableCopy;
        picker.selectLb.text = @"请选择地址";
        [picker show];
    }else if (button.tag == 101) {
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = titleArray;
        self.isChooseCarType = NO;
        picker.array = self.shenFenOneArr.mutableCopy;
        picker.selectLb.text = @"请选择地址";
        [picker show];
    }else if (button.tag == 102){
        [self.pickerView show];
        
    }else if (button.tag == 103 ) {
        //点击是开始时间
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
        selectTimeV.isCanSelectAll = YES;
        WeakObj(self);
        selectTimeV.block = ^(NSString *timeStr) {
            
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
            [dateFormatter setTimeZone:timeZone];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate * nowDate = [dateFormatter dateFromString:timeStr];
            
            NSDate * old = nil;
            if (self.stopTF.text.length > 0) {
                old = [dateFormatter dateFromString:self.stopTF.text];
                 NSComparisonResult result =  [self compareOneDay:nowDate withAnotherDay:old];
                if (result!=NSOrderedAscending) {
                    [SVProgressHUD showErrorWithStatus:@"开始日期要小于结束日期"];
                    return;;
                }
            }
            
            self.startTF.text = timeStr;
            self.cardStart = [NSNumber numberWithDouble:[nowDate timeIntervalSince1970]].doubleValue * 1000;
            
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
        
    }else if (button.tag == 104) {
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
        selectTimeV.isCanSelectAll = YES;
        WeakObj(self);
        selectTimeV.block = ^(NSString *timeStr) {
           
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
            [dateFormatter setTimeZone:timeZone];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate * nowDate = [dateFormatter dateFromString:timeStr];
            NSDate * old = nil;
            if (self.startTF.text.length > 0) {
                old = [dateFormatter dateFromString:self.startTF.text];
                NSComparisonResult result =  [self compareOneDay:old withAnotherDay:nowDate];
                if (result!=NSOrderedAscending) {
                    [SVProgressHUD showErrorWithStatus:@"结束日期要大于开始日期"];
                    return;;
                }
            }
            selfWeak.stopTF.text = timeStr;
            selfWeak.cardEnd = [NSNumber numberWithDouble:[nowDate timeIntervalSince1970]].doubleValue *1000;
            
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    }
    
    
    
}
-(NSComparisonResult)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    return result;
    
}

/// 提交
- (void)submitClick:(UIButton *)btn {
    
    if (self.carTypeV.leftTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输选择账户类型"];
        return;
    }
    if (self.cardNoView.putinTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入卡号"];
        return;
    }
    if (self.bankNameView.putinTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入账户所属银行"];
        return;
    }
    if (self.carAddressV.putinTF.text.length == 0) {
           [SVProgressHUD showErrorWithStatus:@"请输开户行"];
           return;
       }
    if (self.nameView.putinTF.text.length == 0) {
           [SVProgressHUD showErrorWithStatus:@"请输持卡人姓名"];
           return;
       }
    if (self.carPhoneV.putinTF.text.length == 0) {
           [SVProgressHUD showErrorWithStatus:@"请输银行预留电话"];
           return;
       }
  
    if (self.nameView.putinTF.text.length == 0) {
              [SVProgressHUD showErrorWithStatus:@"请输持卡人姓名"];
              return;
          }
    if (self.voucherTypeV.leftTF.text.length == 0) {
                 [SVProgressHUD showErrorWithStatus:@"请选择证件类型"];
                 return;
             }
    if (self.idNoView.putinTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入证件号"];
        return;
    }
       if (self.startTF.text.length == 0) {
              [SVProgressHUD showErrorWithStatus:@"请选择证件起始时间"];
              return;
       }
    if (self.stopTF.text.length == 0) {
           [SVProgressHUD showErrorWithStatus:@"请选择证件结束时间"];
           return;
    }
    if (self.addressV.leftTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
        return;
    }
    if (self.detailAddressV.putinTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
        return;
    }
    if (self.cardPic.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择身份证正面"];
        return;
    }
    if (self.cardPicTwo.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择身份证反面"];
        return;
    }
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    dict[@"token"] = SESSION_TOKEN;
    dict[@"realname"] = self.nameView.putinTF.text;
    dict[@"cardNo"] = self.idNoView.putinTF.text;
    dict[@"bankNo"] = self.cardNoView.putinTF.text;
    dict[@"bankName"] = self.carAddressV.putinTF.text;
    dict[@"cardPicFront"] = self.cardPic;
    dict[@"cardPicBack"] = self.cardPicTwo;
    dict[@"bankCardName"] = self.bankNameView.putinTF.text;
    dict[@"bindTel"] = self.carPhoneV.putinTF.text;
    dict[@"bankType"] = self.carTypeStr;
    dict[@"cardType"] = self.shenFenTwoStr;
    
    dict[@"cardStart"] =@(self.cardStart);
    dict[@"cardEnd"] = @(self.cardEnd);
    dict[@"province"] = self.province;
    dict[@"city"] = self.city;
    dict[@"district"] = self.area;
    dict[@"addressDetail"] = self.detailAddressV.putinTF.text;
    [SVProgressHUD show];
    WeakObj(self);
    btn.userInteractionEnabled = NO;
    [LxmNetworking networkingPOST:app_user_realname parameters:dict returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel * responseObject) {
        [SVProgressHUD dismiss];
        btn.userInteractionEnabled = YES;
        if (responseObject.key.intValue == 1000) {
            [SVProgressHUD showSuccessWithStatus:@"已提交认证!"];
            LxmTool.ShareTool.userModel.real_status = @"3";
            [selfWeak.navigationController popViewControllerAnimated:YES];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        btn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}

/// 上传身份证
- (void)uploadCardClick:(UITapGestureRecognizer *)tap {
    
    NSInteger tag  = tap.view.tag;
    if (tag == 124) {
        self.isFanMian = YES;
    }else {
        self.isFanMian = NO;
    }
    UIAlertController * actionController = [UIAlertController alertControllerWithTitle:nil message:@"选择图片上传方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * a1 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
            if (image) {
                [self upLoadFile:image];
            }else {
                [SVProgressHUD showErrorWithStatus:@"相片获取失败"];
            }
        }];
    }];
    
    UIAlertAction * a2 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showMXPhotoPickerControllerAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
            if (image) {
                [self upLoadFile:image];
            }else {
                [SVProgressHUD showErrorWithStatus:@"相片获取失败"];
            }
        }];
    }];
    UIAlertAction * a3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionController addAction:a1];
    [actionController addAction:a2];
    [actionController addAction:a3];
    [self presentViewController:actionController animated:YES completion:nil];
}



/**
 上传图片
 */
- (void)upLoadFile:(UIImage *)image {
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking NetWorkingUpLoad:fileUpload image:image parameters:@{@"token" : SESSION_TOKEN} name:@"file" success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        selfWeak.cardImgView.userInteractionEnabled = YES;
        if ([responseObject[@"key"] integerValue] == 1000) {
            if (self.isFanMian) {
                selfWeak.cardImgViewTwo.image = image;
                selfWeak.cardPicTwo = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"data"]];
            }else {
                selfWeak.cardImgView.image = image;
                selfWeak.cardPic = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"data"]];
            }
            
   
        } else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        selfWeak.cardImgView.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}


#pragma mark ------- 点击筛选 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    if (self.isChooseCarType) {
        self.carTypeV.leftTF.text = self.carTypeOneArr[leftIndex];
        self.carTypeStr = self.carTypeTwoArr[leftIndex];
    }else {
        self.voucherTypeV.leftTF.text = self.shenFenOneArr[leftIndex];
        self.shenFenTwoStr =  [NSString stringWithFormat:@"%ld",leftIndex + 101];
    }
    
}

- (void)sureBtnClickReturnProvince:(NSString *)province
                              City:(NSString *)city
                              Area:(NSString *)area {
    [self.pickerView hide];
    self.province = province;
    self.city = city;
    self.area = area;
    self.addressV.leftTF.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
}


@end
