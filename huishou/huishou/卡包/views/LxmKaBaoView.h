//
//  LxmKaBaoView.h
//  huishou
//
//  Created by 李晓满 on 2020/3/13.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LxmKaBaoView : UIView

@end

@interface LxmKaBaoHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *moreLabel;

@end

@interface LxmKaBaoCardCell : UITableViewCell

@end

@interface LxmKaBaoEmptyCell : UITableViewCell

@end

@interface LxmKaDetailView : UIView

@end

@interface LxmKaDetailheaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *textLabel0;

@property (nonatomic, strong) UIImageView *iconImgView;

@property (nonatomic, strong) UILabel *textLabel1;

@end

@interface LxmKaDetailCell : UITableViewCell

@end

@interface LxmMoneyCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface LxmKaDetailMoneyCell : UITableViewCell

@property (nonatomic, copy) void(^selectMoneyBlock)(void);

@end

@interface LxmKaDetailBottomView : UIView

@property (nonatomic, strong) UIButton *mingxiButton;

@property (nonatomic, strong) UIImageView *iconImgView;

@property (nonatomic, strong) UIButton *sureKaiTongButton;//确认开通

@end

@interface LxmMingXiView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *moneylabel;

@end

@interface LxmKaDetailMingXiView : UIControl

- (void)showAtView:(UIView *)view;

- (void)dismiss;

@end


//已开卡详情
@interface LxmYiKaiKaGongNengButton : UIButton

@property (nonatomic, strong) UIImageView *iconImgView;

@property (nonatomic, strong) UILabel *textLabel;

@end


@interface LxmYiKaiKaGongNengCell : UITableViewCell

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *textLabel0;

@property (nonatomic, strong) LxmYiKaiKaGongNengButton *shukaButton;

@property (nonatomic, strong) LxmYiKaiKaGongNengButton *chongzhiButton;

@property (nonatomic, strong) LxmYiKaiKaGongNengButton *setMorenButton;

@end

//充值
@interface LxmChongZhiCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImgView;//图标

@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UIImageView *selectImgView;//选择

@property (nonatomic, strong) UIView *lineView;//线

@property (nonatomic, assign) NSInteger indexProw;

@end
