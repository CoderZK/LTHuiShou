//
//  LxmSeeMoreDetailVC.h
//  qiangdan
//
//  Created by 李晓满 on 2020/4/3.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"

@interface LxmSeeMoreDetailVC : BaseTableViewController

@property (nonatomic, strong) NSArray <LxmGujiaChoicesDataModel *>*chooseArr;//可选择数组

@end

@interface LxmGuJiaTitleCell0 : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface LxmGuJiaDetailCell0 : UITableViewCell

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) LxmGuJiaChoicesModel *model;

@end
