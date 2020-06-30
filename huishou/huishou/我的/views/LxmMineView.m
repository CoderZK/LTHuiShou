//
//  LxmMineView.m
//  huishou
//
//  Created by 李晓满 on 2020/3/13.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmMineView.h"
#import "LxmSeeMoreDetailVC.h"

@interface LxmMineView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *yinyingView;

@end

@implementation LxmMineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.yinyingView];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.yueButton];
        [self.bgView addSubview:self.aboutButton];
        [self.bgView addSubview:self.suggestionButton];
        [self.bgView addSubview:self.settingButton];
        [self.yinyingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self).offset(20);
            make.bottom.trailing.equalTo(self).offset(-20);
        }];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self).offset(15);
            make.bottom.trailing.equalTo(self).offset(-15);
        }];
        [self.yueButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self.bgView);
            make.height.equalTo(@60);
        }];
        [self.aboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yueButton.mas_bottom);
            make.leading.trailing.equalTo(self.bgView);
            make.height.equalTo(@60);
        }];
        [self.suggestionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.aboutButton.mas_bottom);
            make.leading.trailing.equalTo(self.bgView);
            make.height.equalTo(@60);
        }];
        [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.suggestionButton.mas_bottom);
            make.leading.trailing.equalTo(self.bgView);
            make.height.equalTo(@60);
        }];
    }
    return self;
}

- (UIView *)yinyingView {
    if (!_yinyingView) {
        _yinyingView = [UIView new];
        _yinyingView.backgroundColor = [UIColor whiteColor];
        _yinyingView.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.3].CGColor;
        _yinyingView.layer.shadowRadius = 10;
        _yinyingView.layer.shadowOpacity = 0.5;
        _yinyingView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _yinyingView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (LxmMineButton *)yueButton {
    if (!_yueButton) {
        _yueButton = [LxmMineButton new];
        _yueButton.iconImgView.image = [UIImage imageNamed:@"yu_e"];
        _yueButton.textLabel.text = @"余额";
        _yueButton.detailLabel.hidden = NO;
    }
    return _yueButton;
}

- (LxmMineButton *)aboutButton {
    if (!_aboutButton) {
        _aboutButton = [LxmMineButton new];
        _aboutButton.iconImgView.image = [UIImage imageNamed:@"about_us"];
        _aboutButton.textLabel.text = @"关于我们";
        _aboutButton.detailLabel.hidden = YES;
    }
    return _aboutButton;
}

- (LxmMineButton *)suggestionButton {
    if (!_suggestionButton) {
        _suggestionButton = [LxmMineButton new];
        _suggestionButton.iconImgView.image = [UIImage imageNamed:@"yijianfankui"];
        _suggestionButton.textLabel.text = @"意见反馈";
        _suggestionButton.detailLabel.hidden = YES;
    }
    return _suggestionButton;
}

- (LxmMineButton *)settingButton {
    if (!_settingButton) {
        _settingButton = [LxmMineButton new];
        _settingButton.iconImgView.image = [UIImage imageNamed:@"shezhi"];
        _settingButton.textLabel.text = @"设置";
        _settingButton.detailLabel.hidden = YES;
        _settingButton.lineView.hidden = YES;
    }
    return _settingButton;
}


@end


@interface LxmMineButton ()

@property (nonatomic, strong) UIImageView *accImgView;

@end
@implementation LxmMineButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImgView];
        [self addSubview:self.textLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.accImgView];
        [self addSubview:self.lineView];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.size.equalTo(@20);
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
            make.centerY.equalTo(self);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.accImgView.mas_leading).offset(-10);
            make.centerY.equalTo(self);
        }];
        [self.accImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
            make.width.equalTo(@5);
            make.height.equalTo(@9);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
            make.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
    }
    return _iconImgView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _textLabel.font = [UIFont systemFontOfSize:15];
    }
    return _textLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont boldSystemFontOfSize:15];
        _detailLabel.text = @"¥0.00";
    }
    return _detailLabel;
}

- (UIImageView *)accImgView {
    if (!_accImgView) {
        _accImgView = [UIImageView new];
        _accImgView.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _accImgView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

@end

@interface LxmMineOrderView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation LxmMineOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleButton];
        [self addSubview:self.collectionView];
        [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.top.trailing.equalTo(self);
            make.height.equalTo(@48);
        }];
    }
    return self;
}

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton new];
        _titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_titleButton setTitle:@"我的订单" forState:UIControlStateNormal];
        [_titleButton setTitleColor:CharacterDarkColor forState:UIControlStateNormal];
        _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _titleButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(floor((ScreenW - 60)*0.2), 80);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 48, ScreenW - 60, 80) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:LxmMineItemCell.class forCellWithReuseIdentifier:@"LxmMineItemCell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LxmMineItemCell *buttonItem = [collectionView dequeueReusableCellWithReuseIdentifier:@"LxmMineItemCell" forIndexPath:indexPath];
    if (indexPath.item == 0) {
        buttonItem.numLabel.text = [NSString stringWithFormat:@"%d",_orderNumModel.send.intValue];
        buttonItem.itemLabel.text = @"待抢单";
    } else if (indexPath.item == 1) {
        buttonItem.numLabel.text = [NSString stringWithFormat:@"%d",_orderNumModel.back.intValue];
        buttonItem.itemLabel.text = @"待发货";
    } else if (indexPath.item == 2) {
        buttonItem.numLabel.text =[NSString stringWithFormat:@"%d",_orderNumModel.deal.intValue];;
        buttonItem.itemLabel.text = @"待处理";
    } else if (indexPath.item == 3) {
        buttonItem.numLabel.text = [NSString stringWithFormat:@"%d",_orderNumModel.finish.intValue];;
        buttonItem.itemLabel.text = @"已完成";
    } else {
        buttonItem.numLabel.text = [NSString stringWithFormat:@"%d",_orderNumModel.canel.intValue];;
        buttonItem.itemLabel.text = @"已取消";
    }
    return buttonItem;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.orderStatusClickBlock) {
        self.orderStatusClickBlock(indexPath.item);
    }
}

- (void)setOrderNumModel:(LxmOrderNumModel *)orderNumModel {
    _orderNumModel = orderNumModel;
    [self.collectionView reloadData];
}

@end

@interface LxmMineItemCell ()

@end
@implementation LxmMineItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.numLabel];
        [self addSubview:self.itemLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_centerY).offset(-2);
            make.centerX.equalTo(self);
        }];
        [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY).offset(8);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _numLabel.font = [UIFont boldSystemFontOfSize:25];
    }
    return _numLabel;
}

- (UILabel *)itemLabel {
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _itemLabel.font = [UIFont systemFontOfSize:13];
    }
    return _itemLabel;
}

@end


@interface LxmYuEView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *yinyingView;

@property (nonatomic, strong) UILabel *textLabel;//账户余额(元)

@end
@implementation LxmYuEView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.yinyingView];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.textLabel];
        [self.bgView addSubview:self.moneyLabel];
        [self.bgView addSubview:self.tixianButton];
        [self.yinyingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self).offset(20);
            make.bottom.trailing.equalTo(self).offset(-20);
        }];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self).offset(15);
            make.bottom.trailing.equalTo(self).offset(-15);
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgView).offset(25);
            make.bottom.equalTo(self.bgView.mas_centerY).offset(-10);
        }];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgView).offset(25);
            make.top.equalTo(self.bgView.mas_centerY).offset(10);
        }];
        [self.tixianButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.bgView).offset(-25);
            make.centerY.equalTo(self.bgView);
            make.width.equalTo(@88);
            make.height.equalTo(@31);
        }];
    }
    return self;
}

- (UIView *)yinyingView {
    if (!_yinyingView) {
        _yinyingView = [UIView new];
        _yinyingView.backgroundColor = [UIColor whiteColor];
        _yinyingView.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.3].CGColor;
        _yinyingView.layer.shadowRadius = 10;
        _yinyingView.layer.shadowOpacity = 0.5;
        _yinyingView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _yinyingView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.text = @"账户余额(元)";
    }
    return _textLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:25];
        _moneyLabel.textColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];
    }
    return _moneyLabel;
}

- (UIButton *)tixianButton {
    if (!_tixianButton) {
        _tixianButton = [UIButton new];
        _tixianButton.layer.borderColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0].CGColor;
        _tixianButton.layer.cornerRadius = 15.5;
        _tixianButton.layer.masksToBounds = YES;
        _tixianButton.layer.borderWidth = 0.5;
        [_tixianButton setImage:[UIImage imageNamed:@"tixian"] forState:UIControlStateNormal];
        [_tixianButton setTitle:@"提现" forState:UIControlStateNormal];
        [_tixianButton setTitleColor:[UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0] forState:UIControlStateNormal];
        _tixianButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _tixianButton.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2);
        _tixianButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2);
    }
    return _tixianButton;
}

@end

@interface LxmYuEHeaderView ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *lineView1;

@property (nonatomic, strong) UILabel *textLabel1;//标题

@property (nonatomic, strong) UILabel *moreLabel;//更多

@property (nonatomic, strong) UIImageView *accImgView;//>


@end
@implementation LxmYuEHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lineView1];
        [self addSubview:self.lineView];
        [self addSubview:self.textLabel1];
        [self addSubview:self.moreLabel];
        [self addSubview:self.accImgView];
        [self addSubview:self.bgButton];
        [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
               make.leading.equalTo(self).offset(15);
               make.bottom.trailing.equalTo(self);
               make.height.equalTo(@0.5);
           }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.width.equalTo(@4.5);
            make.height.equalTo(@15);
        }];
        [self.textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.lineView.mas_trailing).offset(5);
            make.centerY.equalTo(self);
        }];
        [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.accImgView.mas_leading).offset(-3);
            make.centerY.equalTo(self);
        }];
        [self.accImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
            make.width.equalTo(@5);
            make.height.equalTo(@9);
        }];
        [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.bottom.equalTo(self);
        }];
    }
    return self;
}

- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = [UIButton new];
    }
    return _bgButton;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [UIView new];
        _lineView1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView1;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UILabel *)textLabel1 {
    if (!_textLabel1) {
        _textLabel1 = [UILabel new];
        _textLabel1.font = [UIFont boldSystemFontOfSize:16];
        _textLabel1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _textLabel1.text = @"明细";
    }
    return _textLabel1;
}

- (UILabel *)moreLabel {
    if (!_moreLabel) {
           _moreLabel = [UILabel new];
           _moreLabel.font = [UIFont systemFontOfSize:13];
           _moreLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
           _moreLabel.text = @"更多";
       }
       return _moreLabel;
}

- (UIImageView *)accImgView {
    if (!_accImgView) {
        _accImgView = [UIImageView new];
        _accImgView.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _accImgView;
}

@end

@interface LxmYuECell ()

@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UILabel *timeLabel;//时间

@property (nonatomic, strong) UILabel *moneyLabel;//钱数

@property (nonatomic, strong) UIView *lineView;

@end
@implementation LxmYuECell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
        [self setContrains];
        [self setData];
    }
    return self;
}
/**
 添加视图
 */
- (void)initSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.stateLable];
    [self addSubview:self.lineView];
}

/**
 设置约束
 */
- (void)setContrains {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.bottom.equalTo(self.mas_centerY).offset(-5);
        make.trailing.equalTo(self.moneyLabel.mas_leading);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.top.equalTo(self.mas_centerY).offset(5);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-15);
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-15);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.bottom.trailing.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    }
    return _timeLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1.0];
        _moneyLabel.font = [UIFont systemFontOfSize:15];
    }
    return _moneyLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UILabel *)stateLable {
    if (!_stateLable) {
        _stateLable = [UILabel new];
        _stateLable.textColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];
        _stateLable.font = [UIFont systemFontOfSize:14];
    }
    return _stateLable;
}

- (void)setData {
    self.titleLabel.text = @"提现";
    self.timeLabel.text = @"2018-10-23 10:22";
    self.moneyLabel.text = @"+19.98";
    self.stateLable.text = @"审核中";
}

- (void)setTixianModel:(LxmTiXianModel *)tixianModel {
    _tixianModel = tixianModel;
    self.titleLabel.text = _tixianModel.type.intValue == 1 ? @"提现" : @"收入";
    self.timeLabel.text = [_tixianModel.update_time getIntervalToZHXLongTime];
    
    if (_tixianModel.type.intValue == 1) {//1-提现 2-订单收入
        self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f", _tixianModel.money.doubleValue];
    } else {
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f", _tixianModel.money.doubleValue];
    }
    self.stateLable.text = _tixianModel.status.intValue == 1 ? @"待审核" : _tixianModel.status.intValue == 2 ? @"审核通过" : @"拒绝";
}

@end


@interface LxmOrderListCell ()

@property (nonatomic, strong) UIView *shaowView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *huishouStyleLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@end
@implementation LxmOrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
        [self setConstrains];
    }
    return self;
}

/**
 添加视图
 */
- (void)initSubviews {
    [self addSubview:self.shaowView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.topView];
    [self.topView addSubview:self.timeLabel];
    [self.topView addSubview:self.statusLabel];
    [self.bgView addSubview:self.infoView];
    [self.infoView addSubview:self.imgView];
    [self.infoView addSubview:self.nameLabel];
    [self.infoView addSubview:self.huishouStyleLabel];
    [self.infoView addSubview:self.moneyLabel];
}

/**
 
 */
- (void)setConstrains {
    [self.shaowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12.5);
        make.leading.equalTo(self).offset(20);
        make.trailing.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-12.5);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(7.5);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-7.5);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.bgView);
        make.height.equalTo(@38);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topView).offset(15);
        make.centerY.equalTo(self.topView);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.topView).offset(-15);
        make.centerY.equalTo(self.topView);
    }];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.leading.bottom.trailing.equalTo(self.bgView);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.infoView).offset(15);
        make.centerY.equalTo(self.infoView);
        make.width.height.equalTo(@80);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView).offset(10);
        make.leading.equalTo(self.imgView.mas_trailing).offset(10);
    }];
    [self.huishouStyleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.imgView.mas_trailing).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@19);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.infoView).offset(-15);
        make.centerY.equalTo(self.nameLabel);
    }];
}

- (UIView *)shaowView {
    if (!_shaowView) {
        _shaowView = [UIView new];
        _shaowView.backgroundColor = [UIColor whiteColor];
        _shaowView.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.3].CGColor;
        _shaowView.layer.shadowRadius = 5;
        _shaowView.layer.shadowOpacity = 0.5;
        _shaowView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _shaowView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor colorWithRed:251/255.0 green:251/255.0 blue:251/255.0 alpha:1.0];
    }
    return _topView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        _timeLabel.text = @"2020-03-07 15:45:09";
    }
    return _timeLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:13];
        _statusLabel.textColor = CharacterDarkColor;
        _statusLabel.text = @"待工程师上门";
    }
    return _statusLabel;
}

- (UIView *)infoView {
    if (!_infoView) {
        _infoView = [UIView new];
    }
    return _infoView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"iphone"];
    }
    return _imgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.textColor = CharacterDarkColor;
        _nameLabel.text = @"iPhone X";
    }
    return _nameLabel;
}

- (UILabel *)huishouStyleLabel {
    if (!_huishouStyleLabel) {
        _huishouStyleLabel = [UILabel new];
        _huishouStyleLabel.font = [UIFont boldSystemFontOfSize:11];
        _huishouStyleLabel.textColor = RedColor;
        _huishouStyleLabel.text = @"上门回收";
        _huishouStyleLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        _huishouStyleLabel.layer.cornerRadius = 2;
        _huishouStyleLabel.layer.masksToBounds = YES;
        _huishouStyleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _huishouStyleLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:15];
        _moneyLabel.textColor = RedColor;
        _moneyLabel.text = @"¥ 2222";
    }
    return _moneyLabel;
}

- (void)setModel:(LxmOrderModel *)model {
    _model = model;
    _timeLabel.text = [_model.create_time getIntervalToZHXLongTime];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.main_pic] placeholderImage:[UIImage imageNamed:@"789789"] options:SDWebImageRetryFailed];
    _nameLabel.text = _model.good_name;
    _huishouStyleLabel.text = _model.type.intValue == 1 ? @"上门回收" : @"快递回收";
    _moneyLabel.text = [NSString stringWithFormat:@"¥ %@",_model.about_price];
    if (_model.type.intValue == 1) {//上门订单
        switch (_model.door_status.intValue) {
            case 1:
                _statusLabel.text = @"待商家接单";
                break;
            case 2:
                _statusLabel.text = @"待商家上门";
                break;
            case 3:
                _statusLabel.text = @"待系统确认(商家已支付)";
                break;
            case 4:
                _statusLabel.text = @"待商家确认取消";
                break;
            case 5:
                _statusLabel.text = @"已完成";
                break;
            case 6:
                _statusLabel.text = @"已取消";
                break;
            case 7:
                _statusLabel.text = @"已关闭";
                break;
            default:
                break;
        }
    } else if (_model.type.intValue == 2) {//快递订单
        switch (_model.post_status.intValue) {
            case 1:
                _statusLabel.text = @"待商家接单";
                break;
            case 2:
                _statusLabel.text = @"待发货";
                break;
            case 3:
                _statusLabel.text = @"待商家收货";
                break;
            case 4:
                _statusLabel.text = @"待商家修改报价";
                break;
            case 5:
                _statusLabel.text = @"已修改报价";
                break;
            case 6:
                _statusLabel.text = @"用户已确认报价";
                break;
            case 7:
                _statusLabel.text = @"待商家确认取消";
                break;
            case 8:
                _statusLabel.text = @"已完成";
                break;
            case 9:
                _statusLabel.text = @"已取消";
                break;
            case 10:
                _statusLabel.text = @"已关闭";
                break;
            default:
                break;
        }
    }
}

@end

@interface LxmOrderDetailHeaderView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *naozhongImgView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UILabel *textLabel0;

@end
@implementation LxmOrderDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        [self setconstrains];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.naozhongImgView];
    [self.bgView addSubview:self.textLabel];
    [self.bgView addSubview:self.textLabel0];
}

- (void)setconstrains {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self).offset(15);
        make.trailing.bottom.equalTo(self).offset(-15);
    }];
    [self.naozhongImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(23.5);
        make.leading.equalTo(self.bgView).offset(15.5);
        make.size.equalTo(@20);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.naozhongImgView.mas_trailing).offset(10);
        make.centerY.equalTo(self.naozhongImgView);
    }];
    [self.textLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naozhongImgView.mas_bottom).offset(20);
        make.leading.equalTo(self.bgView).offset(15);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = RedColor;
        _bgView.layer.cornerRadius = 10;
    }
    return _bgView;
}

- (UIImageView *)naozhongImgView {
    if (!_naozhongImgView) {
        _naozhongImgView = [UIImageView new];
    }
    return _naozhongImgView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont boldSystemFontOfSize:16];
        _textLabel.textColor = UIColor.whiteColor;
        _textLabel.text = @"待工程师上门";
    }
    return _textLabel;
}

- (UILabel *)textLabel0 {
    if (!_textLabel0) {
        _textLabel0 = [UILabel new];
        _textLabel0.font = [UIFont systemFontOfSize:13];
        _textLabel0.textColor = UIColor.whiteColor;
        _textLabel0.text = @"在预约当天，质检员将会与您联系，请保持电话畅通";
    }
    return _textLabel0;
}

- (void)setDetailModel:(LxmOrderDetailModel *)detailModel {
    _detailModel = detailModel;
    _textLabel.text = _detailModel.status_value;
    _textLabel0.text = _detailModel.status_reason;
    if (_detailModel.type.intValue == 1) {//上门订单
        switch (_detailModel.door_status.intValue) {
            case 1:
                _naozhongImgView.image = [UIImage imageNamed:@"dsjjd"];
                break;
            case 2:
                _naozhongImgView.image = [UIImage imageNamed:@"yqd"];
                break;
            case 3:
                _naozhongImgView.image = [UIImage imageNamed:@"dxtqr"];
                break;
            case 4:
                _naozhongImgView.image = [UIImage imageNamed:@"dsjqrqx"];
                break;
            case 5:
                _naozhongImgView.image = [UIImage imageNamed:@"ywc"];
                break;
            case 6:
                _naozhongImgView.image = [UIImage imageNamed:@"yqx"];
                break;
            case 7:
                _naozhongImgView.image = [UIImage imageNamed:@"ygb"];
                break;
            default:
                break;
        }
    } else if (_detailModel.type.intValue == 2) {//快递订单
        switch (_detailModel.post_status.intValue) {
            case 1:
                _naozhongImgView.image = [UIImage imageNamed:@"dsjjd"];
                break;
            case 2:
                _naozhongImgView.image = [UIImage imageNamed:@"dfh"];
                break;
            case 3:
                _naozhongImgView.image = [UIImage imageNamed:@"dsjsh"];
                break;
            case 4:
                _naozhongImgView.image = [UIImage imageNamed:@"dsjxgbj"];
                break;
            case 5:
                _naozhongImgView.image = [UIImage imageNamed:@"yxgbj"];
                break;
            case 6:
                _naozhongImgView.image = [UIImage imageNamed:@"yqrbj"];
                break;
            case 7:
                _naozhongImgView.image = [UIImage imageNamed:@"dsjqrqx"];
                break;
            case 8:
                _naozhongImgView.image = [UIImage imageNamed:@"ywc"];
                break;
            case 9:
                _naozhongImgView.image = [UIImage imageNamed:@"yqx"];
                break;
            case 10:
                _naozhongImgView.image = [UIImage imageNamed:@"ygb"];
                break;
            default:
                break;
        }
    }
}

@end

@interface LxmOrderDetailCell ()

@end
@implementation LxmOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = CharacterDarkColor;
    }
    return _titleLabel;
}

@end


@interface LxmOrderDetailGoodsCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIButton *gujiStatusButton;

@property (nonatomic, strong) UILabel *textLabel0;

@property (nonatomic, strong) UIImageView *arrImgView;

@property (nonatomic, strong) UILabel *moneyLabel;

@end
@implementation LxmOrderDetailGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.imgView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.gujiStatusButton];
        [self.gujiStatusButton addSubview:self.textLabel0];
        [self.gujiStatusButton addSubview:self.arrImgView];
        [self addSubview:self.moneyLabel];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.width.height.equalTo(@80);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView).offset(10);
            make.leading.equalTo(self.imgView.mas_trailing).offset(10);
        }];
        [self.gujiStatusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.leading.equalTo(self.imgView.mas_trailing).offset(10);
            make.trailing.equalTo(self);
            make.height.equalTo(@19);
        }];
        [self.textLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.gujiStatusButton);
            make.centerY.equalTo(self.gujiStatusButton);
        }];
        [self.arrImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.textLabel0.mas_trailing).offset(5);
            make.centerY.equalTo(self.textLabel0);
            make.width.equalTo(@5);
            make.height.equalTo(@9);
        }];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-15);
            make.centerY.equalTo(self.nameLabel);
        }];
    }
    return self;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"iphone"];
    }
    return _imgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.textColor = CharacterDarkColor;
        _nameLabel.text = @"iPhone X";
    }
    return _nameLabel;
}

- (UIButton *)gujiStatusButton {
    if (!_gujiStatusButton) {
        _gujiStatusButton = [UIButton new];
        [_gujiStatusButton addTarget:self action:@selector(seeGujiClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gujiStatusButton;
}

- (UILabel *)textLabel0 {
    if (!_textLabel0) {
        _textLabel0 = [UILabel new];
        _textLabel0.font = [UIFont systemFontOfSize:13];
        _textLabel0.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        _textLabel0.text = @"估价机况";
    }
    return _textLabel0;
}

- (UIImageView *)arrImgView {
    if (!_arrImgView) {
        _arrImgView = [UIImageView new];
        _arrImgView.image = [UIImage imageNamed:@"arrow_right_gray"];
    }
    return _arrImgView;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:15];
        _moneyLabel.textColor = RedColor;
        _moneyLabel.text = @"¥ 2222";
    }
    return _moneyLabel;
}

- (void)setDetailModel:(LxmOrderDetailModel *)detailModel {
    _detailModel = detailModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_detailModel.main_pic] placeholderImage:[UIImage imageNamed:@"789789"] options:SDWebImageRetryFailed];
    _nameLabel.text = _detailModel.good_name;
    _moneyLabel.text = [NSString stringWithFormat:@"¥ %@", _detailModel.about_price];
}

- (void)seeGujiClick {
    //查看估计情况
    LxmSeeMoreDetailVC *vc = [LxmSeeMoreDetailVC new];
    vc.chooseArr = _detailModel.chooseArr;
    [UIViewController.topViewController.navigationController pushViewController:vc animated:YES];
}


@end


@interface LxmOrderDetailJianCeResultCell ()

@property (nonatomic, strong) UILabel *titlelabel;

@end
@implementation LxmOrderDetailJianCeResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
        [self setConstrains];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.titlelabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.seeBaoGaoButton];
    [self addSubview:self.sureButton];
}

- (void)setConstrains {
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlelabel.mas_bottom).offset(30);
        make.leading.equalTo(self).offset(15);
    }];
    [self.seeBaoGaoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.moneyLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.moneyLabel);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-15);
        make.centerY.equalTo(self.moneyLabel);
        make.width.equalTo(@80);
        make.height.equalTo(@34);
    }];
}

- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [UILabel new];
        _titlelabel.font = [UIFont systemFontOfSize:15];
        _titlelabel.textColor = CharacterDarkColor;
        _titlelabel.text = @"检测报告和最新报价如下，请查看，是否同意";
        _titlelabel.numberOfLines = 0;
    }
    return _titlelabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:20];
        _moneyLabel.textColor = RedColor;
    }
    return _moneyLabel;
}

- (UIButton *)seeBaoGaoButton {
    if (!_seeBaoGaoButton) {
        _seeBaoGaoButton = [UIButton new];
        [_seeBaoGaoButton setTitle:@"查看检测报告" forState:UIControlStateNormal];
        [_seeBaoGaoButton setTitleColor:[UIColor colorWithRed:15/255.0 green:128/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        _seeBaoGaoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _seeBaoGaoButton.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _seeBaoGaoButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton new];
        _sureButton.layer.cornerRadius = 3;
        _sureButton.layer.masksToBounds = YES;
        [_sureButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _sureButton;
}

@end


@interface LxmTiXianHeaderView ()

@property (nonatomic, strong) UILabel *moneyTextlabel;//

@property (nonatomic, strong) UILabel *yuanlabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *lineView0;

@end
@implementation LxmTiXianHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        [self setConstrains];
    }
    return self;
}

- (void)initSubviews {
    [self addSubview:self.allButton];
    [self.allButton addSubview:self.moneyTextlabel];
    [self addSubview:self.yuanlabel];
    [self addSubview:self.moneyTF];
    [self addSubview:self.lineView];
    [self addSubview:self.shouxufeiLabel];
    [self addSubview:self.lineView0];
}

- (void)setConstrains {
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.height.equalTo(@60);
    }];
    [self.moneyTextlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.allButton).offset(15);
        make.centerY.equalTo(self.allButton);
    }];
    [self.yuanlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moneyTF);
        make.leading.equalTo(self).offset(15);
        make.width.height.equalTo(@20);
    }];
    [self.moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allButton.mas_bottom);
        make.leading.equalTo(self.yuanlabel.mas_trailing).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.height.equalTo(@60);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyTF.mas_bottom);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    [self.shouxufeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(15);
        make.leading.equalTo(self).offset(15);
    }];
    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self);
        make.height.equalTo(@10);
    }];
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [UIButton new];
    }
    return _allButton;
}

- (UILabel *)moneyTextlabel {
    if (!_moneyTextlabel) {
        _moneyTextlabel = [UILabel new];
        NSString *str = [NSString stringWithFormat:@"可提现金额¥%.2f 全部提现", LxmTool.ShareTool.userModel.balance.doubleValue];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName: CharacterDarkColor}];
        [string addAttributes:@{NSForegroundColorAttributeName: RedColor} range:NSMakeRange(str.length - 4, 4)];
        _moneyTextlabel.attributedText = string;
    }
    return _moneyTextlabel;
}

- (UIView *)lineView0 {
    if (!_lineView0) {
        _lineView0 = [UIView new];
        _lineView0.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    }
    return _lineView0;
}

- (UILabel *)yuanlabel {
    if (!_yuanlabel) {
        _yuanlabel = [UILabel new];
        _yuanlabel.font = [UIFont boldSystemFontOfSize:30];
        _yuanlabel.textColor = UIColor.blackColor;
        _yuanlabel.text = @"¥";
    }
    return _yuanlabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (UITextField *)moneyTF {
    if (!_moneyTF) {
        _moneyTF = [UITextField new];
        _moneyTF.textColor = UIColor.blackColor;
        _moneyTF.font = [UIFont systemFontOfSize:15];
        _moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
        _moneyTF.placeholder =  [NSString stringWithFormat:@"最低提现金额:¥%@",[LxmTool ShareTool].userModel.limitMoney.getPriceStr];
    }
    return _moneyTF;
}

- (UILabel *)shouxufeiLabel {
    if (!_shouxufeiLabel) {
        _shouxufeiLabel = [UILabel new];
        _shouxufeiLabel.font = [UIFont systemFontOfSize:14];
        _shouxufeiLabel.textColor = CharacterDarkColor;
        _shouxufeiLabel.text = @"提现手续费：¥0.00";
    }
    return _shouxufeiLabel;
}

@end

@implementation LxmTiXianSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        UILabel *textLabel = [UILabel new];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textColor = CharacterDarkColor;
        textLabel.text = @"请选择提现到账方式";
        [self addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

@end


@interface LxmTiXianFooterView ()

@property (nonatomic, strong) UIButton *textButton;

@end
@implementation LxmTiXianFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bankView];
        [self addSubview:self.accountView];
        [self addSubview:self.nameView];
        [self addSubview:self.textButton];
        
        [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.top.trailing.equalTo(self);
            make.height.equalTo(@0);
        }];
        
        [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.top.equalTo(self.bankView.mas_bottom);
            make.trailing.equalTo(self);
            make.height.equalTo(@60);
        }];
        [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.top.equalTo(self.accountView.mas_bottom);
            make.trailing.equalTo(self);
            make.height.equalTo(@60);
        }];
        [self.textButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
            make.top.equalTo(self.nameView.mas_bottom);
            make.height.equalTo(@60);
        }];
    }
    return self;
}

- (UIButton *)textButton {
    if (!_textButton) {
        _textButton = [UIButton new];
        [_textButton setImage:[UIImage imageNamed:@"attention"] forState:UIControlStateNormal];
        [_textButton setTitle:@"到账时间3个工作日，节假日顺延" forState:UIControlStateNormal];
        [_textButton setTitleColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0] forState:UIControlStateNormal];
        _textButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _textButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, -8);
    }
    return _textButton;
}

-(LxmPutinView *)bankView {
    if (!_bankView) {
        _bankView = [LxmPutinView new];
        _bankView.putinTF.placeholder = @"请输入银行名称";
        [_bankView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_bankView layoutIfNeeded];
        _bankView.clipsToBounds = YES;
    }
    return _bankView;
}

- (LxmPutinView *)accountView {
    if (!_accountView) {
        _accountView = [LxmPutinView new];
        _accountView.putinTF.placeholder = @"请输入支付宝账号";
        [_accountView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_accountView layoutIfNeeded];
    }
    return _accountView;
}

- (LxmPutinView *)nameView {
    if (!_nameView) {
        _nameView = [LxmPutinView new];
        _nameView.putinTF.placeholder = @"请输入姓名";
        [_nameView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        [_nameView layoutIfNeeded];
    }
    return _nameView;
}

@end

@implementation LxmOrderContactShangJiaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.contactButton];
        [self.contactButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
            make.height.equalTo(@34);
        }];
    }
    return self;
}

- (UIButton *)contactButton {
    if (!_contactButton) {
        _contactButton = [UIButton new];
        [_contactButton setBackgroundImage:[UIImage imageNamed:@"tabbarwhite"] forState:UIControlStateNormal];
        _contactButton.layer.borderWidth = 0.5;
        _contactButton.layer.borderColor = RedColor.CGColor;
        _contactButton.layer.cornerRadius = 3;
        _contactButton.layer.masksToBounds = YES;
        [_contactButton setImage:[UIImage imageNamed:@"lianxishangjia"] forState:UIControlStateNormal];
        [_contactButton setTitle:@"联系商家" forState:UIControlStateNormal];
        [_contactButton setTitleColor:RedColor forState:UIControlStateNormal];
        _contactButton.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2);
        _contactButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2);
        _contactButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    }
    return _contactButton;
}

@end


@implementation LxmMyOrderDetailWuLiuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
        [self setConstrains];
    }
    return self;
}

/**
 添加视图
 */
- (void)initSubViews {
    [self addSubview:self.iconImgView];
    [self addSubview:self.stateLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.accImgView];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self).offset(15);
        make.width.height.equalTo(@25);
    }];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
        make.centerY.equalTo(self.iconImgView);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stateLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.stateLabel);
        make.trailing.lessThanOrEqualTo(self.accImgView.mas_leading);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.stateLabel);
    }];
    [self.accImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.width.equalTo(@5);
        make.height.equalTo(@9);
    }];
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"wuliu"];
    }
    return _iconImgView;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.font = [UIFont systemFontOfSize:13];
        _stateLabel.textColor = CharacterDarkColor;
        _stateLabel.text = @"已发货";
    }
    return _stateLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = CharacterDarkColor;
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.numberOfLines = 0;
        _detailLabel.text = @"物流信息:暂无物流信息";
    }
    return _detailLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = CharacterDarkColor;
        _timeLabel.hidden = YES;
    }
    return _timeLabel;
}

- (UIImageView *)accImgView {
    if (!_accImgView) {
        _accImgView = [UIImageView new];
        _accImgView.image = [UIImage imageNamed:@"arrow_right_gray"];
    }
    return _accImgView;
}

- (void)setModel:(LxmWuLiuInfoStateModel *)model {
    _model = model;
    self.stateLabel.text = _model.title ? _model.title : @"待发货";
    
    NSString *detail = _model.list.firstObject.context;
    if (detail.isValid) {
        self.detailLabel.text = _model.list.firstObject.context;
    } else {
        self.detailLabel.text = @"物流信息:暂无物流信息";
    }
    
    if ([_model.title isEqualToString:@"已签收"]) {
        _iconImgView.image = [UIImage imageNamed:@"ico_yishouhuo"];
    } else {
        _iconImgView.image = [UIImage imageNamed:@"wuliu"];
    }
}

@end


@interface LxmAddressCell ()

@property (nonatomic, strong) UIImageView *iconImgView;//定位图标

@property (nonatomic, strong) LxmCopyLabel *titleLabel;//姓名 + 电话

@property (nonatomic, strong) LxmCopyLabel *addressLabel;//地址

@property (nonatomic, strong) UIView *lineView;//线

@end
@implementation LxmAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
        [self setConstrains];
    }
    return self;
}

/**
 添加视图
 */
- (void)initSubviews {
    [self addSubview:self.iconImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.lineView];
}

/**
 设置约束
 */
- (void)setConstrains {
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@25);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
        make.trailing.lessThanOrEqualTo(self).offset(-15);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
        make.trailing.lessThanOrEqualTo(self).offset(-15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"local"];
    }
    return _iconImgView;
}

- (LxmCopyLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[LxmCopyLabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (LxmCopyLabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [LxmCopyLabel new];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = CharacterDarkColor;
    }
    return _addressLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (void)setDetailModel:(LxmOrderDetailModel *)detailModel {
    _detailModel = detailModel;
    
    if (self.isShop) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ",_detailModel.shop_username ? _detailModel.shop_username : @""] attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:_detailModel.shop_tel ? _detailModel.shop_tel: @"" attributes:@{ NSForegroundColorAttributeName:CharacterLightGrayColor}];
        [att appendAttributedString:str];
        _titleLabel.attributedText = att;
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@",_detailModel.shop_province,_detailModel.shop_city,_detailModel.shop_address];
    }else {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ",_detailModel.link_name ? _detailModel.link_name : @""] attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:_detailModel.link_tel ? _detailModel.link_tel: @"" attributes:@{ NSForegroundColorAttributeName:CharacterLightGrayColor}];
        [att appendAttributedString:str];
        _titleLabel.attributedText = att;
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@",_detailModel.city,_detailModel.district,_detailModel.address_detail];;
    }
    
    
    
}

@end


@implementation LxmOrderDetailFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        self.line = [[UIView alloc] init];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self);
            make.height.equalTo(@20);
        }];
    }
    return self;
}

@end


@interface LxmMingXiTitleButton ()

@property (nonatomic, strong) UIImageView *arrowImgView;

@end
@implementation LxmMingXiTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textLabel];
        [self addSubview:self.arrowImgView];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.textLabel.mas_trailing).offset(5);
            make.centerY.equalTo(self);
            make.width.equalTo(@9);
            make.height.equalTo(@5);
        }];
    }
    return self;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = CharacterDarkColor;
    }
    return _textLabel;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [UIImageView new];
        _arrowImgView.image = [UIImage imageNamed:@"small_down"];
    }
    return _arrowImgView;
}

@end


//提现详情
@interface LxmTiXianDetailMoneyCell ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation LxmTiXianDetailMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.lineView];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.bottom.equalTo(self.mas_centerY).offset(-8);
        }];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.top.equalTo(self.mas_centerY).offset(8);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.trailing.bottom.equalTo(self);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = CharacterDarkColor;
    }
    return _titleLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:20];
        _moneyLabel.textColor = CharacterDarkColor;
    }
    return _moneyLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}


@end


@implementation LxmTiXianDetailInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.bottom.equalTo(self);
            make.width.equalTo(@130);
        }];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.leftLabel.mas_trailing);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.font = [UIFont systemFontOfSize:15];
        _leftLabel.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.font = [UIFont systemFontOfSize:15];
        _rightLabel.textColor = CharacterDarkColor;
    }
    return _rightLabel;
}

@end
