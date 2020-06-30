//
//  LxmFirstFindPasswordVC.h
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger,LxmFirstFindPasswordVC_type) {
    LxmFirstFindPasswordVC_type_forgerfirst,//忘记密码第一步
    LxmFirstFindPasswordVC_type_modifyPhoneFirst//修改手机号第一步
};

@interface LxmFirstFindPasswordVC : BaseTableViewController

@property (nonatomic, strong) NSString *phone;

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style type:(LxmFirstFindPasswordVC_type)type;

@end

