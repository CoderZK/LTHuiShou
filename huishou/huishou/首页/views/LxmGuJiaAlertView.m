//
//  LxmGuJiaAlertView.m
//  huishou
//
//  Created by 李晓满 on 2020/4/4.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmGuJiaAlertView.h"
#import "MLYPhotoBrowserView.h"

@interface LxmGuJiaAlertView ()<MLYPhotoBrowserViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UIButton * bgBtn;

@property (nonatomic, strong) UIView *contentView;

//@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *textLabel;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation LxmGuJiaAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    }
    return self;
}

/**
 添加视图
 */
- (void)initContentSubviews {
    [self.contentView addSubview:self.scrollView];
//    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.pageControl];
    [self.contentView addSubview:self.textLabel];
    
    
    
}

-(UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
    }
    return _scrollView;
}


-(UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollView.frame) - 20, ScreenW - 30 , 20)];
        _pageControl.numberOfPages = 4;
        _pageControl.currentPage = 2;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgBtn);
        make.width.equalTo(@(ScreenW - 20));
        make.height.equalTo(@(ScreenW - 20));
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.leading.equalTo(self.contentView).offset(10);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@(ScreenW - 40));
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom);
        make.leading.equalTo(self.contentView).offset(10);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@(20));
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).offset(10);
        make.leading.equalTo(self.contentView).offset(10);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

//- (UIImageView *)imgView {
//    if (!_imgView) {
//        _imgView = [UIImageView new];
//        _imgView.contentMode = UIViewContentModeScaleAspectFit;
//        _imgView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
//        [_imgView addGestureRecognizer:tap];
//    }
//    return _imgView;
//}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = CharacterDarkColor;
    }
    return _textLabel;
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

- (void)setModel:(LxmGuJiaReasonModel *)model {
    _model = model;
    
    CGFloat hh = [model.text getSizeWithMaxSize:CGSizeMake(ScreenW - 40, ScreenH) withFontSize:15].height;
    
    _textLabel.text = _model.text;
    if (model.pics.length == 0) {
        
        CGFloat allHH = hh + 10 + 10;
        
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(allHH));
        }];
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.mas_bottom).offset(0);
        }];
  
        
        self.pageControl.hidden = YES;
        
    }else {
        
        [self setPicsWtihPics:[_model.pics componentsSeparatedByString:@","]];
        
        CGFloat allHH =10+  ScreenW - 40  + 30 + hh + 10;
        
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(allHH));
        }];
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ScreenW - 40));
        }];
        [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.mas_bottom).offset(30);
        }];
        
        self.pageControl.hidden = NO;
       
    }
    
    
    
}

- (void)setPicsWtihPics:(NSArray * )arr {
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.pageControl.numberOfPages = arr.count;
    self.pageControl.currentPage = 0;
    self.scrollView.contentSize= CGSizeMake(arr.count * (ScreenW - 40), ScreenW - 40);
    for (int i = 0 ; i < arr.count; i++) {
        
        
        
      UIImageView *  imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(ScreenW - 40), 0, ScreenW - 40, ScreenW - 40)];
        imgView.tag = i;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [imgView addGestureRecognizer:tap];
         [imgView sd_setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:[UIImage imageNamed:@"789789"] options:SDWebImageRetryFailed];
        [self.scrollView addSubview:imgView];
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / (ScreenW - 40);
    self.pageControl.currentPage = index;
}

/// 点击放大
- (void)tapClick:(UITapGestureRecognizer *)tap {
    
    UIView * vv = tap.view;
    
    //查看支付凭证
    MLYPhotoBrowserView *mlyView = [MLYPhotoBrowserView photoBrowserView];
    mlyView.dataSource = self;
    mlyView.currentIndex = vv.tag;
    [mlyView showWithItemsSpuerView:nil];
}

//图片放大
- (NSInteger)numberOfItemsInPhotoBrowserView:(MLYPhotoBrowserView *)photoBrowserView{
    return [_model.pics componentsSeparatedByString:@","].count;
}
- (MLYPhoto *)photoBrowserView:(MLYPhotoBrowserView *)photoBrowserView photoForItemAtIndex:(NSInteger)index{
    MLYPhoto *photo = [[MLYPhoto alloc] init];
    photo.imageUrl = [NSURL URLWithString:[[_model.pics componentsSeparatedByString:@","] objectAtIndex:index]];
    return photo;
}


@end
