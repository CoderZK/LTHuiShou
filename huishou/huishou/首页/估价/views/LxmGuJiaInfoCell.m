//
//  LxmGuJiaInfoCell.m
//  huishou
//
//  Created by 李晓满 on 2020/3/25.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmGuJiaInfoCell.h"

@interface LxmLabelTest ()

@end
@implementation LxmLabelTest

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end


@interface LxmGuJiaInfoCell ()

@property (nonatomic, strong) UIImageView *bgImgView;//背景图

@property (nonatomic, strong) UILabel *yuanLabel;//元符号

@property (nonatomic, strong) UIButton *wenButton;//问号

@property (nonatomic, strong) UIButton *reGujiaButton;//重新估价

@end

@implementation LxmGuJiaInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
        [self setConstrains];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.bgImgView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.yuanLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.wenButton];
    [self addSubview:self.reGujiaButton];
}

- (void)setConstrains {
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.height.equalTo(@120);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(37.5);
        make.leading.equalTo(self).offset(40);
    }];
    [self.yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(20);
        make.leading.equalTo(self).offset(40);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.yuanLabel);
        make.leading.equalTo(self.yuanLabel.mas_trailing).offset(3);
        make.height.equalTo(@34);
    }];
    [self.wenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.moneyLabel.mas_trailing).offset(10);
        make.bottom.equalTo(self.yuanLabel);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
    [self.reGujiaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yuanLabel.mas_bottom).offset(15);
        make.trailing.equalTo(self).offset(-40);
        make.leading.equalTo(self).offset(40);
        make.bottom.equalTo(self.bgImgView);
    }];
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        _bgImgView.image = [UIImage imageNamed:@"gujia_bg"];
    }
    return _bgImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = UIColor.whiteColor;
        _nameLabel.text = @"iPhone X 估价";
    }
    return _nameLabel;
}

- (UILabel *)yuanLabel {
    if (!_yuanLabel) {
        _yuanLabel = [UILabel new];
        _yuanLabel.font = [UIFont boldSystemFontOfSize:23];
        _yuanLabel.textColor = UIColor.whiteColor;
        _yuanLabel.text = @"¥";
    }
    return _yuanLabel;
}

- (LxmLabelTest *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [LxmLabelTest new];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:34];
        _moneyLabel.textColor = UIColor.whiteColor;
        _moneyLabel.text = @"2220";
        _moneyLabel.textInsets = UIEdgeInsetsMake(0.f, 0.f, -8.f, 0.f);
    }
    return _moneyLabel;
}

- (UIButton *)wenButton {
    if (!_wenButton) {
        _wenButton = [UIButton new];
        [_wenButton setImage:[UIImage imageNamed:@"wen"] forState:UIControlStateNormal];
        _wenButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        _wenButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_wenButton addTarget:self action:@selector(wenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wenButton;
}

- (UIButton *)reGujiaButton {
    if (!_reGujiaButton) {
        _reGujiaButton = [UIButton new];
        [_reGujiaButton setTitle:@"重新询价" forState:UIControlStateNormal];
        _reGujiaButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        _reGujiaButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_reGujiaButton addTarget:self action:@selector(reGujiaButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_reGujiaButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _reGujiaButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _reGujiaButton;
}

- (void)wenButtonClick {
    if (self.wenBlock) {
        self.wenBlock();
    }
}

- (void)reGujiaButtonClick {
    if (self.reXunJiaBlock) {
        self.reXunJiaBlock();
    }
}

@end


//选择回收方式
//选择回收方式
@implementation LxmSelectHuiShouStyleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.textLabel];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-3);
            make.height.equalTo(@24.5);
            make.width.equalTo(@20);
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_centerY).offset(3);
        }];
    }
    return self;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont systemFontOfSize:14];
    }
    return _textLabel;
}

@end



@interface LxmSelectHuiShouStyleCell ()

@property (nonatomic, strong) LxmSelectHuiShouStyleButton *leftButton;

@property (nonatomic, strong) LxmSelectHuiShouStyleButton *rightButton;

@end
@implementation LxmSelectHuiShouStyleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self.mas_centerX).offset(-7.5);
            make.bottom.equalTo(self).offset(-15);
        }];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.leading.equalTo(self.mas_centerX).offset(7.5);
            make.bottom.trailing.equalTo(self).offset(-15);
        }];
    }
    return self;
}

- (LxmSelectHuiShouStyleButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [LxmSelectHuiShouStyleButton new];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"huishoustyle_bg"] forState:UIControlStateSelected];
        _leftButton.imgView.image = [UIImage imageNamed:@"shangmen_y"];
        _leftButton.textLabel.text = @"上门回收";
        _leftButton.textLabel.textColor = UIColor.whiteColor;
        _leftButton.layer.cornerRadius = 3;
        _leftButton.layer.masksToBounds = YES;
        [_leftButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.selected = YES;
        [_leftButton.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@20);
            make.height.equalTo(@24);
        }];
        [_leftButton layoutIfNeeded];
    }
    return _leftButton;
}

- (LxmSelectHuiShouStyleButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [LxmSelectHuiShouStyleButton new];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"huishoustyle_bg"] forState:UIControlStateSelected];
        _rightButton.layer.cornerRadius = 3;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.imgView.image = [UIImage imageNamed:@"kuaidi_n"];
        _rightButton.textLabel.text = @"快递回收";
        _rightButton.textLabel.textColor = CharacterDarkColor;
        [_rightButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@32);
            make.height.equalTo(@20);
        }];
        [_rightButton layoutIfNeeded];
    }
    return _rightButton;
}

- (void)btnClick:(UIButton *)btn {
    NSInteger index = 100;
    if (btn == _leftButton) {
        _leftButton.selected = YES;
        _leftButton.imgView.image = [UIImage imageNamed:@"shangmen_y"];
        _leftButton.textLabel.textColor = UIColor.whiteColor;
        _rightButton.selected = NO;
        _rightButton.imgView.image = [UIImage imageNamed:@"kuaidi_n"];
        _rightButton.textLabel.textColor = CharacterDarkColor;
        index = 100;
    } else {
        _leftButton.selected = NO;
        _leftButton.imgView.image = [UIImage imageNamed:@"shangmen_n"];
        _leftButton.textLabel.textColor = CharacterDarkColor;
        _rightButton.selected = YES;
        _rightButton.imgView.image = [UIImage imageNamed:@"kuaidi_y"];
        _rightButton.textLabel.textColor = UIColor.whiteColor;
        index = 101;
    }
    if (self.huishouStyleBlock) {
        self.huishouStyleBlock(index);
    }
}

@end

@implementation  LxmHuiShouHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.redLineView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
        [self.redLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.bottom.equalTo(self);
            make.width.equalTo(@4.5);
            make.height.equalTo(@15);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.redLineView.mas_trailing).offset(7);
            make.centerY.equalTo(self.redLineView);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.trailing.bottom.equalTo(self);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

- (UIView *)redLineView {
    if (!_redLineView) {
        _redLineView = [UIView new];
        _redLineView.backgroundColor = RedColor;
    }
    return _redLineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    }
    return _lineView;
}

@end


@implementation LxmHuiShouTextHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
        }];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (void)setIndex:(NSInteger)index {
    NSString *str = @"";
    if (index == 100) {
        str = @"专业质检员上门质检，并实时报价。确保您填入正确的联系方式和地址";
    } else {
        str = @"顺丰免费上门取件，收货后24小时内检测并付款";
    }
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:0];
    [paragraphStyle setLineBreakMode:(NSLineBreakByCharWrapping)];
    [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    _titleLabel.attributedText = string1;
}

@end


@implementation LxmHuiShouTextFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.userProtoButton];
        [self addSubview:self.titleLabel1];
        [self addSubview:self.yinsiButton];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leading.equalTo(self).offset(15);
        }];
        [self.userProtoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLabel.mas_trailing);
            make.centerY.equalTo(self.titleLabel);
            make.height.equalTo(@40);
        }];
        [self.titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.userProtoButton.mas_trailing);
            make.centerY.equalTo(self.userProtoButton);
        }];
        [self.yinsiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLabel1.mas_trailing);
            make.centerY.equalTo(self.titleLabel1);
            make.height.equalTo(@40);
        }];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = CharacterDarkColor;
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.text = @"提交订单等于同意";
    }
    return _titleLabel;
}

- (UIButton *)userProtoButton {
    if (!_userProtoButton) {
        _userProtoButton = [UIButton new];
        _userProtoButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_userProtoButton setTitleColor:[UIColor colorWithRed:15/255.0 green:128/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_userProtoButton setTitle:@"《用户协议》" forState:UIControlStateNormal];
        [_userProtoButton addTarget:self action:@selector(xieyiClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userProtoButton;
}

- (UILabel *)titleLabel1 {
    if (!_titleLabel1) {
        _titleLabel1 = [UILabel new];
        _titleLabel1.textColor = CharacterDarkColor;
        _titleLabel1.font = [UIFont systemFontOfSize:11];
        _titleLabel1.text = @"及";
    }
    return _titleLabel1;
}

- (UIButton *)yinsiButton {
    if (!_yinsiButton) {
        _yinsiButton = [UIButton new];
        _yinsiButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_yinsiButton setTitleColor:[UIColor colorWithRed:15/255.0 green:128/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_yinsiButton setTitle:@"《隐私政策》" forState:UIControlStateNormal];
        [_yinsiButton addTarget:self action:@selector(yisiClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yinsiButton;
}


//用户协议
- (void)xieyiClick {
    NSLog(@"1");
}

//隐私政策
- (void)yisiClick {
    NSLog(@"2");
}

@end


@implementation LxmHuiShouView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self addSubview:self.textLabel];
        [self addSubview:self.rightButton];
        [self addSubview:self.lineView];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-15);
            make.top.bottom.equalTo(self);
            make.width.equalTo(@100);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.trailing.bottom.equalTo(self);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textColor = CharacterDarkColor;
        _textLabel.font = [UIFont systemFontOfSize:15];
    }
    return _textLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton new];
        [_rightButton setTitleColor:[UIColor colorWithRed:15/255.0 green:128/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _rightButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    }
    return _lineView;
}

@end

@implementation LxmHuiShouSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self addSubview:self.bgButton];
        [self.bgButton addSubview:self.leftTF];
        [self.bgButton addSubview:self.arrowImgView];
        [self addSubview:self.lineView];
        [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.leftTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgButton).offset(15);
            make.top.bottom.equalTo(self.bgButton);
            make.trailing.equalTo(self.arrowImgView.mas_leading);
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.bgButton).offset(-15);
            make.centerY.equalTo(self.bgButton);
            make.width.equalTo(@7);
            make.height.equalTo(@13);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.trailing.bottom.equalTo(self);
            make.height.equalTo(@0.5);
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

- (UITextField *)leftTF {
    if (!_leftTF) {
        _leftTF = [UITextField new];
        _leftTF.font = [UIFont systemFontOfSize:14];
        _leftTF.textColor = CharacterDarkColor;
    }
    return _leftTF;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [UIImageView new];
        _arrowImgView.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _arrowImgView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    }
    return _lineView;
}



@end



@interface LxmHuiShouStyleInfoCell ()

@property (nonatomic, strong) UIView *shaowView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) LxmHuiShouView *shangmenView;//上门取件

@end
@implementation LxmHuiShouStyleInfoCell

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
    [self.bgView addSubview:self.shangmenView];
    [self.bgView addSubview:self.nameView];
    [self.bgView addSubview:self.phoneView];
    [self.bgView addSubview:self.areaView];
    [self.bgView addSubview:self.detailAddressView];
    [self.bgView addSubview:self.timeView];
}

/**
 
 */
- (void)setConstrains {
    [self.shaowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self).offset(20);
        make.trailing.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-10);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-5);
    }];
    [self.shangmenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.bgView);
        make.height.equalTo(@0);
    }];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shangmenView.mas_bottom);
        make.leading.equalTo(self.bgView).offset(15);
        make.trailing.equalTo(self.bgView);
        make.height.equalTo(@50);
    }];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameView.mas_bottom);
        make.leading.equalTo(self.bgView).offset(15);
        make.trailing.equalTo(self.bgView);
        make.height.equalTo(@50);
    }];
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom);
        make.leading.trailing.equalTo(self.bgView);
        make.height.equalTo(@50);
    }];
    [self.detailAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.areaView.mas_bottom);
        make.leading.equalTo(self.bgView).offset(15);
        make.trailing.equalTo(self.bgView);
        make.height.equalTo(@50);
    }];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailAddressView.mas_bottom);
        make.leading.trailing.equalTo(self.bgView);
        make.height.equalTo(@50);
    }];
}

- (void)setIndex:(NSInteger)index {
    if (index == 100) {
        [self.shangmenView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self.bgView);
            make.height.equalTo(@0);
        }];
    } else {
        [self.shangmenView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self.bgView);
            make.height.equalTo(@50);
        }];
    }
}

- (UIView *)shaowView {
    if (!_shaowView) {
        _shaowView = [UIView new];
        _shaowView.backgroundColor = [UIColor whiteColor];
        _shaowView.layer.shadowColor = CharacterDarkColor.CGColor;
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

- (LxmHuiShouView *)shangmenView {
    if (!_shangmenView) {
        _shangmenView = [LxmHuiShouView new];
        _shangmenView.textLabel.text = @"快递上门取件";
        [_shangmenView.rightButton setTitle:@"运费说明" forState:UIControlStateNormal];
        [_shangmenView.rightButton addTarget:self action:@selector(yunfeishuomingClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shangmenView;
}

- (LxmPutinView *)nameView {
    if (!_nameView) {
        _nameView = [LxmPutinView new];
        _nameView.putinTF.font = [UIFont systemFontOfSize:14];
        _nameView.putinTF.placeholder = @"请输入联系人姓名";
        [_nameView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameView).offset(15);
            make.height.equalTo(@0.5);
        }];
        [_nameView layoutIfNeeded];
    }
    return _nameView;
}

- (LxmPutinView *)phoneView {
    if (!_phoneView) {
        _phoneView = [LxmPutinView new];
        _phoneView.putinTF.font = [UIFont systemFontOfSize:14];
        _phoneView.putinTF.placeholder = @"请输入联系电话";
        _phoneView.putinTF.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_phoneView).offset(15);
            make.height.equalTo(@0.5);
        }];
        [_phoneView layoutIfNeeded];
    }
    return _phoneView;
}

- (LxmHuiShouSelectView *)areaView {
    if (!_areaView) {
        _areaView = [LxmHuiShouSelectView new];
        _areaView.leftTF.placeholder = @"请选择市区";
        _areaView.leftTF.userInteractionEnabled = NO;
    }
    return _areaView;
}

- (LxmPutinView *)detailAddressView {
    if (!_detailAddressView) {
        _detailAddressView = [LxmPutinView new];
        _detailAddressView.putinTF.font = [UIFont systemFontOfSize:14];
        _detailAddressView.putinTF.placeholder = @"请输入详细地址";
        [_detailAddressView.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_detailAddressView).offset(15);
            make.height.equalTo(@0.5);
        }];
        [_detailAddressView layoutIfNeeded];
    }
    return _detailAddressView;
}

- (LxmHuiShouSelectView *)timeView {
    if (!_timeView) {
        _timeView = [LxmHuiShouSelectView new];
        _timeView.leftTF.placeholder = @"请选择预约时间";
        _timeView.leftTF.userInteractionEnabled = NO;
        [_timeView.bgButton addTarget:self action:@selector(timeViewClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeView;
}

- (void)timeViewClick {
    
    
    
    if (self.yuyueshijianBlock) {
        self.yuyueshijianBlock(self);
    }
}

/// 运费说明
- (void)yunfeishuomingClick {
    LxmWebViewController *vc = [[LxmWebViewController alloc] init];
    vc.navigationItem.title = @"运费说明";
    vc.loadUrl = [NSURL URLWithString:@"https://huishou.zftgame.com/normal/yyunfei.html"];
    [UIViewController.topViewController.navigationController pushViewController:vc animated:YES];
}

@end

@interface LxmHuiShouBottomView ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation LxmHuiShouBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.moneyLabel];
        [self.bgView addSubview:self.submitButton];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self);
            make.height.equalTo(@60);
        }];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgView).offset(15);
            make.centerY.equalTo(self.bgView);
        }];
        [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.bgView).offset(-15);
            make.centerY.equalTo(self);
            make.width.equalTo(@137);
            make.height.equalTo(@40);
        }];
    }
    return self;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
    }
    return _bgView;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont systemFontOfSize:15];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"预估 " attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"¥2220" attributes:@{NSForegroundColorAttributeName:RedColor}];
        [att appendAttributedString:str];
        _moneyLabel.attributedText = att;
    }
    return _moneyLabel;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton new];
        [_submitButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 3;
        _submitButton.layer.masksToBounds = YES;
        [_submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _submitButton;
}

@end


//提交成功相关view

@interface LxmTiJiaoSuccessHeaderView ()

@property (nonatomic, strong) UIImageView *successImgView;//提交成功

@property (nonatomic, strong) UILabel *textLabel0;

@property (nonatomic, strong) UILabel *textLabel1;



@property (nonatomic, strong) UIView *bgView;//

@property (nonatomic, strong) UILabel *addresslabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *lineView;

@end
@implementation LxmTiJiaoSuccessHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        [self setConstrains];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.successImgView];
    [self addSubview:self.textLabel0];
    [self addSubview:self.textLabel1];
    [self addSubview:self.textLabel2];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.addresslabel];
    [self.bgView addSubview:self.timeLabel];
    [self addSubview:self.lineView];
}

- (void)setConstrains {
    [self.successImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(36);
        make.centerX.equalTo(self);
        make.width.height.equalTo(@35);
    }];
    [self.textLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successImgView.mas_bottom).offset(16);
        make.centerX.equalTo(self);
    }];
    [self.textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel0.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    [self.textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel1.mas_bottom).offset(15);
        make.centerX.equalTo(self);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel2.mas_bottom).offset(27);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.bottom.equalTo(self.lineView.mas_top).offset(-15);
    }];
    [self.addresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(20);
        make.leading.equalTo(self.bgView).offset(10);
        make.trailing.equalTo(self.bgView).offset(-10);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addresslabel.mas_bottom).offset(15);
        make.leading.equalTo(self.bgView).offset(10);
        make.trailing.equalTo(self.bgView).offset(-10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self);
        make.height.equalTo(@10);
    }];
}

- (UIImageView *)successImgView {
    if (!_successImgView) {
        _successImgView = [UIImageView new];
        _successImgView.image = [UIImage imageNamed:@"tijiao_success"];
    }
    return _successImgView;
}

- (UILabel *)textLabel0 {
    if (!_textLabel0) {
        _textLabel0 = [UILabel new];
        _textLabel0.font = [UIFont boldSystemFontOfSize:15];
        _textLabel0.textColor = CharacterDarkColor;
        _textLabel0.text = @"订单提交成功";
    }
    return _textLabel0;
}

- (UILabel *)textLabel1 {
    if (!_textLabel1) {
        _textLabel1 = [UILabel new];
        _textLabel1.font = [UIFont systemFontOfSize:12];
        _textLabel1.textColor = CharacterDarkColor;
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"若订单超过" attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"10天" attributes:@{NSForegroundColorAttributeName:RedColor}];
        NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"未产生交易，则将逾期自动取消" attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
        [att appendAttributedString:str];
        [att appendAttributedString:str1];
        _textLabel1.attributedText = att;
    }
    return _textLabel1;
}

- (UILabel *)textLabel2 {
    if (!_textLabel2) {
        _textLabel2 = [UILabel new];
        _textLabel2.font = [UIFont boldSystemFontOfSize:14];
        _textLabel2.textColor = CharacterDarkColor;
        _textLabel2.text = @"请保持电话畅通，快递小哥将上门取件";
    }
    return _textLabel2;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)addresslabel {
    if (!_addresslabel) {
        _addresslabel = [UILabel new];
        _addresslabel.textColor = CharacterDarkColor;
        _addresslabel.font = [UIFont systemFontOfSize:14];
        //        _addresslabel.text = @"上门地址：徐州市奥体中心";
        _addresslabel.numberOfLines = 0;
    }
    return _addresslabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = CharacterDarkColor;
        _timeLabel.font = [UIFont systemFontOfSize:14];
        //        _timeLabel.text = @"上门时间：03月08日（周日） 12:00-14:00";
    }
    return _timeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    }
    return _lineView;
}

- (void)setAddress:(NSString *)address {
    _address = address;
    self.addresslabel.text = [NSString stringWithFormat:@"上门地址：%@", address];
}

- (void)setTime:(NSString *)time {
    _time = time;
    self.timeLabel.text = [NSString stringWithFormat:@"上门时间：%@", time];
}

@end

@implementation LxmTiJiaoSuccessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.numLabel];
        [self addSubview:self.titleLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.top.equalTo(self).offset(20);
            make.width.height.equalTo(@15);
        }];
        //        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.leading.equalTo(self.numLabel.mas_trailing).offset(10);
        //            make.trailing.equalTo(self).offset(-15);
        //            make.centerY.equalTo(self.numLabel);
        //        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.numLabel.mas_trailing).offset(10);
            make.trailing.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(20);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.layer.cornerRadius = 7.5;
        _numLabel.layer.borderWidth = 1;
        _numLabel.layer.borderColor = CharacterDarkColor.CGColor;
        _numLabel.layer.masksToBounds = YES;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.font = [UIFont systemFontOfSize:11];
        _numLabel.text = @"1";
    }
    return _numLabel;
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = CharacterDarkColor;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"拔出SIM卡，备份个人数";
    }
    return _titleLabel;
}

@end

@interface LxmTiJiaoSuccessBottomView ()

@property (nonatomic, strong) UIView *bgView;

@end
@implementation LxmTiJiaoSuccessBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.leftButton];
        [self.bgView addSubview:self.rightButton];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self);
            make.height.equalTo(@60);
        }];
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView).offset(10);
            make.leading.equalTo(self.bgView).offset(15);
            make.trailing.equalTo(self.bgView.mas_centerX).offset(-7.5);
            make.bottom.equalTo(self.bgView).offset(-10);
        }];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView).offset(10);
            make.leading.equalTo(self.bgView.mas_centerX).offset(7.5);
            make.trailing.equalTo(self.bgView).offset(-15);
            make.bottom.equalTo(self.bgView).offset(-10);
        }];
    }
    return self;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
    }
    return _bgView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton new];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        _leftButton.layer.cornerRadius = 3;
        _leftButton.layer.masksToBounds = YES;
        [_leftButton setTitle:@"回到首页" forState:UIControlStateNormal];
        [_leftButton setTitleColor:CharacterDarkColor forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton new];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
        _rightButton.layer.cornerRadius = 3;
        _rightButton.layer.masksToBounds = YES;
        [_rightButton setTitle:@"查看订单" forState:UIControlStateNormal];
        [_rightButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _rightButton;
}


@end
