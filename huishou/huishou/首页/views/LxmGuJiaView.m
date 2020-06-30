//
//  LxmGuJiaView.m
//  huishou
//
//  Created by 李晓满 on 2020/3/12.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmGuJiaView.h"

@implementation LxmGuJiaView

@end

@interface LxmGuJiaHeaderView ()

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *descLabel;

@end
@implementation LxmGuJiaHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.progressView];
        [self addSubview:self.jinduLabel];
        [self addSubview:self.infoView];
        [self.infoView addSubview:self.imgView];
        [self.infoView addSubview:self.nameLabel];
        [self.infoView addSubview:self.descLabel];
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self);
            make.height.equalTo(@15);
        }];
        [self.jinduLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.progressView).offset(-15);
            make.centerY.equalTo(self.progressView);
        }];
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.progressView.mas_bottom).offset(15);
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
            make.height.equalTo(@52.5);
        }];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.infoView).offset(8.5);
            make.centerY.equalTo(self.infoView);
            make.size.equalTo(@35);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imgView.mas_trailing).offset(10);
            make.top.equalTo(self.imgView);
            make.trailing.equalTo(self.infoView).offset(-8.5);
        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imgView.mas_trailing).offset(10);
            make.bottom.equalTo(self.imgView);
            make.trailing.equalTo(self.infoView).offset(-8.5);
        }];
    }
    return self;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [UIProgressView new];
        _progressView.progressTintColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];
        _progressView.backgroundColor = BGGrayColor;
    }
    return _progressView;
}

- (UILabel *)jinduLabel {
    if (!_jinduLabel) {
        _jinduLabel = [UILabel new];
        _jinduLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _jinduLabel.font = [UIFont systemFontOfSize:10];
    }
    return _jinduLabel;
}

- (UIView *)infoView {
    if (!_infoView) {
        _infoView = [UIView new];
        _infoView.backgroundColor = [UIColor colorWithRed:254/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        _infoView.layer.cornerRadius = 5;
        _infoView.layer.masksToBounds = YES;
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
        _nameLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.text = @"iPhone X";
    }
    return _nameLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _descLabel.font = [UIFont systemFontOfSize:10];
        _descLabel.text = @"选择结果和实际情况相符，将以最快速度收款";
    }
    return _descLabel;
}

- (void)setModel:(LxmGuJiaModel *)model {
    _model = model;
    _progressView.progress = 0;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.main_pic] placeholderImage:[UIImage imageNamed:@"wh_moren_pic"] options:SDWebImageRetryFailed];
    _nameLabel.text = _model.good_name;
}

@end


/// 估价底部按钮
@interface LxmGuJiaBottomView ()

@property (nonatomic, strong) UIButton *gujiButton;

@end
@implementation LxmGuJiaBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.gujiButton];
        [self.gujiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
            make.height.equalTo(@40);
        }];
    }
    return self;
}

- (UIButton *)gujiButton {
    if (!_gujiButton) {
        _gujiButton = [UIButton new];
        [_gujiButton setTitle:@"免费估价" forState:UIControlStateNormal];
        [_gujiButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _gujiButton.backgroundColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];
        [_gujiButton addTarget:self action:@selector(gujiaButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _gujiButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _gujiButton.layer.cornerRadius = 3;
        _gujiButton.layer.masksToBounds = YES;
    }
    return _gujiButton;
}

- (void)gujiaButtonClick {
    if (self.gujiaClickBlock) {
        self.gujiaClickBlock();
    }
}
@end


@interface LxmGuJiaTitleCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *helpButton;

@end
@implementation LxmGuJiaTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.lineView];
        [self.bgView addSubview:self.helpButton];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgView).offset(15);
            make.trailing.equalTo(self.bgView).offset(-15);
            make.centerY.equalTo(self.bgView);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.equalTo(self.bgView);
            make.height.equalTo(@1);
        }];
        
        [self.helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.top.trailing.equalTo(self.bgView);
                  make.width.height.equalTo(@50);
              }];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.path = maskPath.CGPath;
    self.bgView.layer.mask = maskLayer;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"1. 使用情况";
    }
    return _titleLabel;
}

- (UIButton *)helpButton {
    if (!_helpButton) {
        _helpButton = [UIButton new];
        _helpButton.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        [_helpButton setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
        [_helpButton addTarget:self action:@selector(helpClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _helpButton;
}

- (void)helpClick {
    if (self.reasonTitleBlock) {
        self.reasonTitleBlock(self.model);
    }
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (void)setModel:(LxmGuJiaReasonModel *)model {
    _model = model;
    _helpButton.hidden = !(_model.text.isValid || _model.pics.isValid);
}


@end

@interface LxmGuJiaDetailCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *helpButton;

@end
@implementation LxmGuJiaDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.imgView];
        [self.bgView addSubview:self.helpButton];
        [self.bgView addSubview:self.lineView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
        }];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self.bgView).offset(15);
            make.size.equalTo(@20);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imgView.mas_trailing).offset(10);
            make.trailing.equalTo(self.helpButton.mas_leading);
            make.centerY.equalTo(self.bgView);
        }];
        [self.helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.trailing.equalTo(self.bgView);
            make.width.height.equalTo(@50);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgView).offset(15);
            make.trailing.equalTo(self.bgView).offset(-15);
            make.bottom.equalTo(self.bgView);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"select_n"];
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}

- (UIButton *)helpButton {
    if (!_helpButton) {
        _helpButton = [UIButton new];
        _helpButton.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        [_helpButton setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
        [_helpButton addTarget:self action:@selector(helpClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _helpButton;
}

- (void)helpClick {
    if (self.reasonWenBlock) {
        self.reasonWenBlock(self.model);
    }
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (void)setModel:(LxmGuJiaChoicesModel *)model {
    _model = model;
    _titleLabel.text = _model.choice;
    _helpButton.hidden = !(_model.reason.text.isValid || _model.reason.pics.isValid);
    _imgView.image = [UIImage imageNamed:_model.isSelected ? @"select_y_1" : @"select_n"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isLastCell) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
    } else {
        self.bgView.layer.mask = nil;
    }
}

- (void)setIsLastCell:(BOOL)isLastCell {
    if (_isLastCell != isLastCell) {
        _isLastCell = isLastCell;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}



@end
