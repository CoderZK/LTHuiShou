//
//  LxmGuJiaNoteAlertView.m
//  huishou
//
//  Created by 李晓满 on 2020/5/9.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmGuJiaNoteAlertView.h"

@interface LxmGuJiaNoteAlertView ()

@property (nonatomic, strong) UIButton * bgBtn;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *textLabel1;

@property (nonatomic, strong) UILabel *textLabel2;

@property (nonatomic, assign) CGFloat height;

@end

@implementation LxmGuJiaNoteAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSString *str = @"该估价是基于您所选择的机器信息预估的回收价格。爱回收将在收到您的机器并进行专业质检后，提供实际的回收报价。";
        NSString *str1 = @"*如质检结果与您选择的信息有差异，实际回收报价可能产生变化。";
        NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:CharacterDarkColor, NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        
        NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:str1 attributes:@{ NSForegroundColorAttributeName: [UIColor colorWithRed:241/255.0 green:76/255.0 blue:76/255.0 alpha:1.0], NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:0];
        [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
        [string2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str1.length)];
        [paragraphStyle setLineBreakMode:(NSLineBreakByCharWrapping)];
        
        [string1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11] range:NSMakeRange(0, string1.length)];
        [string2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11] range:NSMakeRange(0, string2.length)];
 
        CGFloat height = [string1 boundingRectWithSize:CGSizeMake(ScreenW - 90, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
           
        CGFloat height2 =  [string2 boundingRectWithSize:CGSizeMake(ScreenW - 90, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
        
        
        CGFloat titleH = height+5;
        CGFloat titleH1 = height2 + 5;
        _height = titleH + titleH1 + 45;
        
        
        
        self.backgroundColor = [UIColor blackColor];
        self.bgBtn = [[UIButton alloc] initWithFrame:self.bounds];
        [self.bgBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: self.bgBtn];
        
        self.contentView = [[UIView alloc] init];
        self.contentView.layer.cornerRadius = 7;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = UIColor.whiteColor;
        [self.bgBtn addSubview:self.contentView];
        
        [self initContentSubviews];
        [self setConstrains];
        self.textLabel1.attributedText = string1;
        self.textLabel2.attributedText = string2;
        
        [self.textLabel1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(titleH));
            
        }];
        [self.textLabel2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(titleH1));
        }];
        
        
    }
    return self;
}

- (UILabel *)textLabel1 {
    if (!_textLabel1) {
        _textLabel1 = [UILabel new];
        _textLabel1.numberOfLines = 0;
    }
    return _textLabel1;
}

- (UILabel *)textLabel2 {
    if (!_textLabel2) {
        _textLabel2 = [UILabel new];
        _textLabel2.numberOfLines = 0;
    }
    return _textLabel2;
}


/**
 添加视图
 */
- (void)initContentSubviews {
    [self.contentView addSubview:self.textLabel1];
    [self.contentView addSubview:self.textLabel2];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgBtn);
        make.width.equalTo(@(ScreenW - 60));
        make.height.equalTo(@(_height));
    }];
    [self.textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.contentView).offset(15);
        make.trailing.equalTo(self.contentView).offset(-15);
    }];
    [self.textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel1.mas_bottom).offset(15);
        make.leading.equalTo(self.contentView).offset(15);
        make.trailing.equalTo(self.contentView).offset(-15);
    }];
}


-(void)show {
    self.alpha = 1;
    _contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    WeakObj(self);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        selfWeak.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        selfWeak.contentView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)dismiss {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    WeakObj(self);
    [UIView animateWithDuration:0.3 animations:^{
        selfWeak.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)btnClick:(UIButton *)btn {
    [self dismiss];
}

@end
