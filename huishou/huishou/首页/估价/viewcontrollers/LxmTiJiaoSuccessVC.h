//
//  LxmTiJiaoSuccessVC.h
//  huishou
//
//  Created by 李晓满 on 2020/3/26.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LxmTiJiaoSuccessVC : BaseTableViewController

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *address;//预约上门时地址

@property (nonatomic, strong) NSString *meet_date;//预约上门时间

@property(nonatomic,assign)NSInteger type;


@end

NS_ASSUME_NONNULL_END
