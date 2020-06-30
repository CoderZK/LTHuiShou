//
//  LxmSubMyOrderVC.h
//  huishou
//
//  Created by 李晓满 on 2020/3/27.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LxmSubMyOrderVC : BaseTableViewController

@property (nonatomic, strong) NSNumber *type;//1-全部 2-待发货 3-待处理 4-已完成 5-已取消 6-待抢单

@end

NS_ASSUME_NONNULL_END
