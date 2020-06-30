//
//  LxmXiaDanStyleVC.h
//  huishou
//
//  Created by 李晓满 on 2020/3/25.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LxmXiaDanStyleVC : BaseTableViewController

@property (nonatomic, strong) LxmGuJiaModel *gujiModel;

@property (nonatomic, strong) NSString *goodId;//商品id

@property (nonatomic, assign) double gujiaPrice;

@property (nonatomic, strong) NSMutableArray <LxmGujiaChoicesDataModel *>*chooseArr;//可选择数组

@end

NS_ASSUME_NONNULL_END
