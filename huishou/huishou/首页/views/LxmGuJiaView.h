//
//  LxmGuJiaView.h
//  huishou
//
//  Created by 李晓满 on 2020/3/12.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LxmGuJiaView : UIView

@end

@interface LxmGuJiaHeaderView : UIView

@property (nonatomic, strong) LxmGuJiaModel *model;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UILabel *jinduLabel;

@end

/// 估价底部View
@interface LxmGuJiaBottomView : UIView

@property (nonatomic, copy) void(^gujiaClickBlock)(void);

@end

@interface LxmGuJiaTitleCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) void(^reasonTitleBlock)(LxmGuJiaReasonModel *model);
@property (nonatomic, strong) LxmGuJiaReasonModel *model;
@end

@interface LxmGuJiaDetailCell : UITableViewCell

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) LxmGuJiaChoicesModel *model;

@property (nonatomic, assign) BOOL isLastCell;

@property (nonatomic, copy) void(^reasonWenBlock)(LxmGuJiaChoicesModel *model);

@end
