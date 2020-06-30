//
//  LxmTiXianDetailVC.h
//  huishou
//
//  Created by 李晓满 on 2020/4/2.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LxmTiXianDetailVC : BaseTableViewController

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *type;//1-提现 2-订单收入
// status 1-待审核 2-通过 3-拒绝
 
@end

NS_ASSUME_NONNULL_END
