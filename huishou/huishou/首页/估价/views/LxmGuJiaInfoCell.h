//
//  LxmGuJiaInfoCell.h
//  huishou
//
//  Created by 李晓满 on 2020/3/25.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LxmLabelTest : UILabel

@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制文字与控件边界的间距

@end

@interface LxmGuJiaInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;//估价商品名称

@property (nonatomic, strong) LxmLabelTest *moneyLabel;//钱

@property (nonatomic, copy) void(^wenBlock)(void);

@property (nonatomic, copy) void(^reXunJiaBlock)(void);

@end

//选择回收方式
@interface LxmSelectHuiShouStyleButton : UIButton

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *textLabel;

@end


@interface LxmSelectHuiShouStyleCell : UITableViewCell

@property (nonatomic, copy) void(^huishouStyleBlock)(NSInteger index);

@end

@interface LxmHuiShouHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIView *redLineView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@interface LxmHuiShouTextHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) NSInteger index;

@end

@interface LxmHuiShouTextFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *userProtoButton;//用户协议

@property (nonatomic, strong) UILabel *titleLabel1;

@property (nonatomic, strong) UIButton *yinsiButton;//隐私政策

@end

@interface LxmHuiShouView : UIView

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIView *lineView;//线

@end

@interface LxmHuiShouSelectView : UIView

@property (nonatomic, strong) UITextField *leftTF;

@property (nonatomic, strong) UIImageView *arrowImgView;

@property (nonatomic, strong) UIButton *bgButton;

@property (nonatomic, strong) UIView *lineView;//线

@end


@interface LxmHuiShouStyleInfoCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) void(^yuyueshijianBlock)(LxmHuiShouStyleInfoCell *cell);

@property (nonatomic, strong) LxmHuiShouSelectView *timeView;//请选择预约日期

@property (nonatomic, strong) LxmPutinView *nameView;//请输入姓名

@property (nonatomic, strong) LxmPutinView *phoneView;//请输入电话

@property (nonatomic, strong) LxmHuiShouSelectView *areaView;//请选择市区

@property (nonatomic, strong) LxmPutinView *detailAddressView;//请输入详细地址

@end


@interface LxmHuiShouBottomView : UIView

@property (nonatomic, strong) UILabel *moneyLabel;//钱数

@property (nonatomic, strong) UIButton *submitButton;//提交订单

@end

//提交成功相关view

@interface LxmTiJiaoSuccessHeaderView : UIView

@property (nonatomic, strong) NSString *address;//详情地址

@property (nonatomic, strong) NSString *time;//上门时间

@property (nonatomic, strong) UILabel *textLabel2;

@end

@interface LxmTiJiaoSuccessCell : UITableViewCell

@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface LxmTiJiaoSuccessBottomView : UIView

@property (nonatomic, strong) UIButton *leftButton;//回到首页

@property (nonatomic, strong) UIButton *rightButton;//查看订单

@end
