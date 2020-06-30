//
//  LxmMineView.h
//  huishou
//
//  Created by 李晓满 on 2020/3/13.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LxmMineButton : UIButton

@property (nonatomic, strong) UIImageView *iconImgView;//图标

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@interface LxmMineView : UIView

@property (nonatomic, strong) LxmMineButton *yueButton;

@property (nonatomic, strong) LxmMineButton *aboutButton;

@property (nonatomic, strong) LxmMineButton *suggestionButton;

@property (nonatomic, strong) LxmMineButton *settingButton;

@end


@interface LxmMineOrderView : UIView

@property (nonatomic, strong) LxmOrderNumModel *orderNumModel;

@property (nonatomic, strong) UIButton *titleButton;

@property (nonatomic, copy) void(^orderStatusClickBlock)(NSInteger index);

@end

@interface LxmMineItemCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) UILabel *itemLabel;

@end

@interface LxmYuEView : UIView

@property (nonatomic, strong) UIButton *tixianButton;//提现

@property (nonatomic, strong) UILabel *moneyLabel;//余额

@end

@interface LxmYuEHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIButton *bgButton;

@end

@interface LxmYuECell : UITableViewCell

@property (nonatomic, strong) UILabel *stateLable;//状态

@property (nonatomic, strong) LxmTiXianModel *tixianModel;

@end


@interface LxmOrderListCell : UITableViewCell

@property (nonatomic, strong) LxmOrderModel *model;//订单列表model

@end


@interface LxmOrderDetailHeaderView : UIView

@property (nonatomic, strong) LxmOrderDetailModel *detailModel;

@end

@interface LxmOrderDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end


@interface LxmOrderDetailGoodsCell : UITableViewCell

@property (nonatomic, strong) LxmOrderDetailModel *detailModel;

@end

@interface LxmOrderDetailJianCeResultCell : UITableViewCell

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIButton *seeBaoGaoButton;

@property (nonatomic, strong) UIButton *sureButton;

@end


@interface LxmTiXianHeaderView : UIView

@property (nonatomic, strong) UIButton *allButton;//全部提现

@property (nonatomic, strong) UITextField *moneyTF;

@property (nonatomic, strong) UILabel *shouxufeiLabel;

@end

@interface LxmTiXianSectionHeaderView : UITableViewHeaderFooterView

@end

@interface LxmTiXianFooterView : UIView

@property (nonatomic, strong) LxmPutinView *bankView;//银行名称

@property (nonatomic, strong) LxmPutinView *accountView;//账户

@property (nonatomic, strong) LxmPutinView *nameView;//姓名

@end

@interface LxmOrderContactShangJiaCell : UITableViewCell

@property (nonatomic, strong) UIButton *contactButton;//联系商家

@end

@interface LxmMyOrderDetailWuLiuCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImgView;//图标

@property (nonatomic, strong) UILabel *stateLabel;//待发货 已发货 已完成

@property (nonatomic, strong) UILabel *detailLabel;//物流信息

@property (nonatomic, strong) UILabel *timeLabel;//时间

@property (nonatomic, strong) UIImageView *accImgView;//箭头

@property (nonatomic, strong) LxmWuLiuInfoStateModel *model;

@end


@interface LxmAddressCell : UITableViewCell

@property (nonatomic, strong) LxmOrderDetailModel *detailModel;
@property(nonatomic,assign)BOOL isShop;

@end


@interface LxmOrderDetailFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIView * line;

@end


@interface LxmMingXiTitleButton : UIButton

@property (nonatomic, strong) UILabel *textLabel;

@end

//提现详情
@interface LxmTiXianDetailMoneyCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@end

@interface LxmTiXianDetailInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@end
