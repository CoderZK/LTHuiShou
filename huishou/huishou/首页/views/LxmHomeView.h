//
//  LxmHomeView.h
//  回收
//
//  Created by 李晓满 on 2020/3/11.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LxmHomeView : UIView

@end

@interface LxmHomeAddressButton : UIButton

@property (nonatomic, strong) UILabel *cityLabel;

@end

@interface LxmSearchView : UIView

@property (nonatomic, strong) UIButton *bgButton;//背景按钮

@property (nonatomic, strong) UITextField *searchTF;//搜索栏

@end

/**
 搜索页面搜索栏
 */
@interface LxmSearchPageView : UIView

@property (nonatomic, strong) UIView *bgView;//背景按钮

@property (nonatomic, strong) UITextField *searchTF;//搜索栏

@end


@interface LxmTitleView : UIView

- (CGSize)intrinsicContentSize;

@property (nonatomic, copy) void(^searchBlock)(void);

@property (nonatomic, strong) LxmHomeAddressButton *addressButton;

@end

//按钮区域
@interface LxmHomeItemCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgView;//图标

@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

//分类
@interface LxmHomeTitleButton : UIButton

@property (nonatomic, strong) UILabel *textLabel;//标题

@property (nonatomic, strong) UILabel *moreLabel;//更多

@property (nonatomic, strong) UIImageView *accImgView;//>

@end

@interface LxmHomeGoodsCell : UICollectionViewCell

@property (nonatomic, strong) LxmHomeGoodsModel *goodsModel;

@end


@interface LxmHomeClassifyCell : UITableViewCell

@property (nonatomic, copy) void(^titleButtonClickBlock)( LxmHomeCategroyModel *categroyModel);

@property (nonatomic, strong) NSArray <LxmHomeGoodsModel *>*goods;

@property (nonatomic, strong) LxmHomeCategroyModel *categroyModel;

@property (nonatomic, copy) void(^didselectItemBlock)(LxmHomeGoodsModel *goodsModel);

@end

@interface LxmHomeQuestionHeaderView : UITableViewHeaderFooterView

@end

@interface LxmHomeQuestionFooterView : UITableViewHeaderFooterView
@property (nonatomic, strong) UIButton *bgButton;
@end

@interface LxmHomeQuestionCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;
/** <#注释#> */
@property(nonatomic , strong)LxmHomeRootModel1 *model;

@end

@interface LxmChargeCenterTopView : UIView

@property (nonatomic, copy) void(^didMoneyClickBlock)(NSString *money);

@end

@interface LxmChargeCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@end
