//
//  LxmLoginView.m
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmLoginView.h"

@implementation LxmLoginView

@end

/// 输入view
@implementation LxmPutinView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.putinTF];
        [self addSubview:self.lineView];
        [self.putinTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self);
            make.bottom.equalTo(self.lineView.mas_top);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (UITextField *)putinTF {
    if (!_putinTF) {
        _putinTF = [UITextField new];
        _putinTF.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
        _putinTF.font = [UIFont systemFontOfSize:15];
    }
    return _putinTF;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    }
    return _lineView;
}

@end


/// 选择view
@interface LxmPutinButtonView ()

@property (nonatomic, strong) UIImageView *selectImgView;//选择类型

@end

@implementation LxmPutinButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.selectLabel];
        [self addSubview:self.selectImgView];
        [self addSubview:self.lineView];
        [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self);
            make.trailing.equalTo(self.selectImgView.mas_leading);
            make.bottom.equalTo(self.lineView.mas_top);
        }];
        [self.selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset;
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

@end




@implementation LxmAgreeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgV];
        [self addSubview:self.textLabel];
        [self addSubview:self.protocolButton];
        
        [self.imgV  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.height.width.equalTo(@18);
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imgV.mas_trailing).offset(10);
            make.centerY.equalTo(self);
        }];
        [self.protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.trailing.equalTo(self);
            make.leading.equalTo(self).offset(140);
        }];
    }
    return self;
}


- (UIButton *)protocolButton {
    if (!_protocolButton) {
        _protocolButton = [UIButton new];
    }
    return _protocolButton;
}

-(UIImageView *)imgV {
    if (_imgV == nil) {
        _imgV = [[UIImageView alloc] init];
        _imgV.image = [UIImage imageNamed:@"xuanzhong_n"];
    }
    
    return _imgV;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:13];
    }
    return _textLabel;
}
@end
