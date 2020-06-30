//
//  LxmHomeSeeMoreView.h
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LxmHomeView.h"
@interface LxmHomeSeeMoreView : UIView
@property (nonatomic, strong) LxmSearchView *searchView;//搜索

@property (nonatomic, strong) UIButton *backButton;//返回键
- (CGSize)intrinsicContentSize;

@property (nonatomic, copy) void(^searchBlock)(void);

@property (nonatomic, copy) void(^backClickBlock)(void);

@end

@protocol LxmHomeTopTitleViewDelegate;
@interface LxmHomeTopTitleView : UIView

@property (nonatomic, strong) NSArray <LxmHomeFirstTypeModel *>*titleArr;

@property (nonatomic, strong) NSString *firstTypeID;//当前一级分类ID

@property (nonatomic, copy) void(^topViewSelectBlock)(LxmHomeFirstTypeModel *model);

@end



@interface LxmHomeTopTitleCell : UICollectionViewCell

@property (nonatomic , strong) UILabel * titleLab;
@property (nonatomic , strong) UILabel * lineLabel;

@end

@interface LxmHomeLeftTableCell : UITableViewCell

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface LxmGoodsCell : UICollectionViewCell

@property (nonatomic, strong) LxmHomeGoodsModel *goodsModel;//商品

@end
