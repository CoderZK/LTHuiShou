//
//  LxmHomeView.m
//  回收
//
//  Created by 李晓满 on 2020/3/11.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmHomeView.h"

@implementation LxmHomeView

@end

@interface LxmHomeAddressButton ()

- (CGSize)intrinsicContentSize;

@property (nonatomic, strong) UIImageView *iconImgView;

@end

@implementation LxmHomeAddressButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cityLabel];
        [self addSubview:self.iconImgView];
        [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.cityLabel.mas_trailing).offset(5);
            make.centerY.equalTo(self);
            make.width.equalTo(@8.5);
            make.height.equalTo(@4);
        }];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(80, 40);
}


- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [UILabel new];
        _cityLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _cityLabel.font = [UIFont systemFontOfSize:15];
        _cityLabel.text = @"定位..";
    }
    return _cityLabel;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"arrow_down"];
    }
    return _iconImgView;
}

@end



@interface LxmSearchView()

@property (nonatomic, strong) UIImageView *iconImgView;//搜索图标

@end
@implementation LxmSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgButton];
        [self.bgButton addSubview:self.iconImgView];
        [self.bgButton addSubview:self.searchTF];
        [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.bottom.equalTo(self);
        }];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgButton).offset(15);
            make.centerY.equalTo(self.bgButton);
            make.width.height.equalTo(@14);
        }];
        [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
            make.trailing.equalTo(self.bgButton).offset(-5);
            make.top.bottom.equalTo(self.bgButton);
        }];
        
    }
    return self;
}

- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = [[UIButton alloc] init];
        _bgButton.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        _bgButton.layer.cornerRadius = 15;
        _bgButton.layer.masksToBounds = YES;
    }
    return _bgButton;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.image = [UIImage imageNamed:@"ico_sousuo"];
    }
    return _iconImgView;
}

- (UITextField *)searchTF {
    if (!_searchTF) {
        _searchTF = [[UITextField alloc] init];
        _searchTF.placeholder = @"搜索";
        _searchTF.font = [UIFont systemFontOfSize:14];
        _searchTF.textColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0];
        _searchTF.returnKeyType = UIReturnKeySearch;
    }
    return _searchTF;
}

@end

/**
 搜索页面搜索栏
 */
@interface LxmSearchPageView ()

@property (nonatomic, strong) UIImageView *iconImgView;//搜索图标

@end

@implementation LxmSearchPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.iconImgView];
        [self.bgView addSubview:self.searchTF];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.bottom.equalTo(self);
        }];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgView).offset(15);
            make.centerY.equalTo(self.bgView);
            make.width.height.equalTo(@14);
        }];
        [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.iconImgView.mas_trailing).offset(15);
            make.trailing.equalTo(self.bgView).offset(-5);
            make.top.bottom.equalTo(self.bgView);
        }];
    }
    return self;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIButton alloc] init];
        _bgView.backgroundColor = BGGrayColor;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.image = [UIImage imageNamed:@"ico_sousuo"];
    }
    return _iconImgView;
}

- (UITextField *)searchTF {
    if (!_searchTF) {
        _searchTF = [[UITextField alloc] init];
        _searchTF.placeholder = @"请输入搜索内容";
        _searchTF.font = [UIFont systemFontOfSize:13];
        _searchTF.textColor = CharacterDarkColor;
        _searchTF.returnKeyType = UIReturnKeySearch;
    }
    return _searchTF;
}

@end



@interface LxmTitleView ()

@property (nonatomic, strong) LxmSearchView *searchView;//搜索



@end

@implementation LxmTitleView

- (LxmHomeAddressButton *)addressButton {
    if (!_addressButton) {
        _addressButton = [[LxmHomeAddressButton alloc] initWithFrame:CGRectMake(0, 0, 80,40)];
//        [_addressButton addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressButton;
}

- (LxmSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[LxmSearchView alloc] init];
        [_searchView.bgButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _searchView.searchTF.userInteractionEnabled = NO;
    }
    return _searchView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addressButton];
        [self addSubview:self.searchView];
        [self.addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.width.equalTo(@80);
            make.height.equalTo(@30);
        }];
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.addressButton.mas_trailing);
            make.trailing.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(@30);
        }];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(ScreenW, 40);
}

- (void)searchButtonClick {
    if (self.searchBlock) {
        self.searchBlock();
    }
}

@end

//按钮区域
@interface LxmHomeItemCell ()

@end
@implementation LxmHomeItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.equalTo(self);
            make.size.equalTo(@56);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(15);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.layer.cornerRadius = 28;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return _titleLabel;
}

@end

//分类

@interface LxmHomeTitleButton ()

@end
@implementation LxmHomeTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textLabel];
        [self addSubview:self.moreLabel];
        [self addSubview:self.accImgView];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
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
    }
    return self;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont boldSystemFontOfSize:16];
        _textLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _textLabel.text = @"手机";
    }
    return _textLabel;
}

- (UILabel *)moreLabel {
    if (!_moreLabel) {
           _moreLabel = [UILabel new];
           _moreLabel.font = [UIFont systemFontOfSize:13];
           _moreLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
           _moreLabel.text = @"查看更多";
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


@interface LxmHomeGoodsCell ()

@property (nonatomic, strong) UIImageView *imgView;//物品图片

@property (nonatomic, strong) UILabel *nameLabel;//物品名称

@property (nonatomic, strong) UILabel *priceLabel;//价格

@end
@implementation LxmHomeGoodsCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self);
            make.width.height.equalTo(@125);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(10);
            make.centerX.equalTo(self);
        }];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.centerX.equalTo(self);
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
        _nameLabel.text = @"13存 MacBook Pro";
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
    }
    return _priceLabel;
}

- (void)setGoodsModel:(LxmHomeGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.main_pic] placeholderImage:[UIImage imageNamed:@"iphone"] options:SDWebImageRetryFailed];
    _nameLabel.text = _goodsModel.good_name;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"最高回收价：" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]}];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:_goodsModel.high_price.isValid ? _goodsModel.high_price : @"¥0.00" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 17], NSForegroundColorAttributeName: [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0]}];
    [att appendAttributedString:str];
    _priceLabel.attributedText = att;
    
}

@end


@interface LxmHomeClassifyCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *shaowView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) LxmHomeTitleButton *titleButton;

@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation LxmHomeClassifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    [self.bgView addSubview:self.titleButton];
    [self.bgView addSubview:self.collectionView];
}

/**
 
 */
- (void)setConstrains {
    [self.shaowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self).offset(20);
        make.bottom.trailing.equalTo(self).offset(-20);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self).offset(15);
        make.trailing.bottom.equalTo(self).offset(-15);
    }];
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.bgView);
        make.height.equalTo(@50);
    }];
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

- (LxmHomeTitleButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [LxmHomeTitleButton new];
        [_titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((ScreenW - 45)*0.5,210);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, (ScreenW - 30), (210+5)*ceil(4/2.0) - 5) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:LxmHomeGoodsCell.class forCellWithReuseIdentifier:@"LxmHomeGoodsCell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goods.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LxmHomeGoodsCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LxmHomeGoodsCell" forIndexPath:indexPath];
    itemCell.goodsModel = self.goods[indexPath.item];
    return itemCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didselectItemBlock) {
        self.didselectItemBlock(self.goods[indexPath.item]);
    }
}

- (void)titleButtonClick:(UIButton *)btn {
    if (self.titleButtonClickBlock) {
        self.titleButtonClickBlock(self.categroyModel);
    }
}

- (void)setGoods:(NSArray<LxmHomeGoodsModel *> *)goods {
    _goods = goods;
    _collectionView.frame = CGRectMake(0, 50, (ScreenW - 30), (210+5)*ceil(goods.count/2.0) - 5);
    [_collectionView reloadData];
}

- (void)setCategroyModel:(LxmHomeCategroyModel *)categroyModel {
    _categroyModel = categroyModel;
    _titleButton.textLabel.text = _categroyModel.category_name;
}


@end

@interface LxmHomeQuestionHeaderView ()

@property (nonatomic, strong) UIView *lineView;//线条

@property (nonatomic, strong) UIView *bgView;//背景

@property (nonatomic, strong) UILabel *titleLabel;//标题

@end
@implementation LxmHomeQuestionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubbviews];
        [self setConstrains];
    }
    return self;
}

/**
 添加子视图
 */
- (void)initSubbviews {
    [self addSubview:self.lineView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.height.equalTo(@10);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(20);
        make.centerX.equalTo(self.bgView);
    }];
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"-常见问题自助区-";
    }
    return _titleLabel;
}

@end

@interface LxmHomeQuestionFooterView ()



@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *accImgView;

@end
@implementation LxmHomeQuestionFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bgButton];
        [self.bgButton addSubview:self.titleLabel];
        [self.bgButton addSubview:self.accImgView];
        [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.centerX.equalTo(self).offset(-5);
        }];
        [self.accImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.leading.equalTo(self.titleLabel.mas_trailing).offset(5);
            make.width.equalTo(@5);
            make.height.equalTo(@9);
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _titleLabel.text = @"查看更多";
    }
    return _titleLabel;
}

- (UIImageView *)accImgView {
    if (!_accImgView) {
        _accImgView = [UIImageView new];
        _accImgView.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _accImgView;
}

@end


@interface LxmHomeQuestionCell()

@property (nonatomic, strong) UIButton *imgButton;//图片

@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UILabel *detailLabel;//问题描述

@property (nonatomic, strong) UIView *lineView;//线

@end
@implementation LxmHomeQuestionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    [self addSubview:self.imgButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.lineView];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.imgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self).offset(15);
        make.width.equalTo(@14.5);
        make.height.equalTo(@17);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgButton);;
        make.leading.equalTo(self.imgButton.mas_trailing).offset(5);
        make.trailing.equalTo(self).offset(-15);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.imgButton);
        make.trailing.equalTo(self).offset(-15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

- (UIButton *)imgButton {
    if (!_imgButton) {
        _imgButton = [[UIButton alloc] init];
        [_imgButton setBackgroundImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
//        [_imgButton setTitle:@"Q1" forState:UIControlStateNormal];
        [_imgButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _imgButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _imgButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"客服什么时候在线？";
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = CharacterGrayColor;
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.numberOfLines = 0;
        _detailLabel.text = @"周一到周五9:00-20:00有客服在线，收到信息后我们会及时回复。如遇繁忙时段，请耐心等候。";
    }
    return _detailLabel;
}

- (void)setModel:(LxmHomeRootModel1 *)model {
    _model = model;
    _detailLabel.text = model.content;
    _titleLabel.text = model.title;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}
@end


@interface LxmChargeCenterTopView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *yinyingView;

@property (nonatomic, strong) UILabel *textLabel;//花费充值(元)

@property (nonatomic, strong) UIView *redLine;//红线

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray <NSString *> *dataArr;

@end

@implementation LxmChargeCenterTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.yinyingView];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.textLabel];
        [self.bgView addSubview:self.redLine];
        [self.bgView addSubview:self.collectionView];
        [self.yinyingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self).offset(20);
            make.bottom.trailing.equalTo(self).offset(-20);
        }];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self).offset(15);
            make.bottom.trailing.equalTo(self).offset(-15);
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.bgView).offset(15);
        }];
        [self.redLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.textLabel.mas_bottom).offset(5);
            make.width.equalTo(@20);
            make.height.equalTo(@4);
        }];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.redLine.mas_bottom).offset(25);
            make.leading.equalTo(self.bgView).offset(15);
            make.trailing.equalTo(self.bgView).offset(-15);
            make.height.equalTo(@130);
        }];
        self.dataArr = @[@"10",@"30",@"50",@"100",@"200",@"300"];
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
        _textLabel.textColor = RedColor;
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.text = @"话费充值";
    }
    return _textLabel;
}

- (UIView *)redLine {
    if (!_redLine) {
        _redLine = [UIView new];
        _redLine.backgroundColor = RedColor;
        _redLine.layer.cornerRadius = 2;
        _redLine.layer.masksToBounds = YES;
    }
    return _redLine;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake((ScreenW - 80)/3.0, 60);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 60, ceil(self.dataArr.count/3.0)*70) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerClass:LxmChargeCell.class forCellWithReuseIdentifier:@"LxmChargeCell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LxmChargeCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LxmChargeCell" forIndexPath:indexPath];
    itemCell.moneyLabel.text = [NSString stringWithFormat:@"%@元", self.dataArr[indexPath.item]];
    itemCell.detailLabel.text = [NSString stringWithFormat:@"售%.2f元", self.dataArr[indexPath.item].doubleValue];
    itemCell.layer.borderColor = indexPath.item == self.currentIndex ? [UIColor colorWithRed:252/255.0 green:76/255.0 blue:81/255.0 alpha:1.0].CGColor : [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0].CGColor;
    itemCell.moneyLabel.textColor = indexPath.item == self.currentIndex ? [UIColor colorWithRed:252/255.0 green:76/255.0 blue:81/255.0 alpha:1.0] : [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    itemCell.detailLabel.textColor = indexPath.item == self.currentIndex ? [UIColor colorWithRed:252/255.0 green:76/255.0 blue:81/255.0 alpha:1.0] : [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
    itemCell.backgroundColor = indexPath.item == self.currentIndex ? [UIColor colorWithRed:255/255.0 green:230/255.0 blue:230/255.0 alpha:1.0] : [UIColor whiteColor];
    return itemCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   self.currentIndex = indexPath.item;
   [self.collectionView reloadData];
    if (self.didMoneyClickBlock) {
        self.didMoneyClickBlock(self.dataArr[indexPath.item]);
    }
}

@end


@implementation LxmChargeCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 0.5;
        self.layer.masksToBounds = YES;
        [self addSubview:self.moneyLabel];
        [self addSubview:self.detailLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-2);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_centerY).offset(2);
        }];
    }
    return self;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _moneyLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:12];
    }
    return _detailLabel;
}

@end
