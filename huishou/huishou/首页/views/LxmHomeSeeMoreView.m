//
//  LxmHomeSeeMoreView.m
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmHomeSeeMoreView.h"


@interface LxmHomeSeeMoreView ()



@end

@implementation LxmHomeSeeMoreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backButton];
        [self addSubview:self.searchView];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(@30);
            make.height.equalTo(@(30*3/4));
        }];
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.backButton.mas_trailing);
            make.trailing.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(@30);
        }];
    }
    return self;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton new];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"home_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (LxmSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[LxmSearchView alloc] init];
        [_searchView.bgButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _searchView.searchTF.userInteractionEnabled = NO;
    }
    return _searchView;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(ScreenW, 40);
}

- (void)searchButtonClick {
    if (self.searchBlock) {
        self.searchBlock();
    }
}

/// 返回
- (void)backClick {
    if (self.backClickBlock) {
        self.backClickBlock();
    }
}


@end


@interface LxmHomeTopTitleView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic , strong)UICollectionViewFlowLayout * layout;
@property (nonatomic , strong)UICollectionView * collectionView;
@property (nonatomic , assign)NSInteger selectIndex;

@end
@implementation LxmHomeTopTitleView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.layout = [[UICollectionViewFlowLayout alloc] init];
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.layout.minimumInteritemSpacing = 15;
        
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 50) collectionViewLayout:self.layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.collectionView];
        
        [self.collectionView registerClass:[LxmHomeTopTitleCell class] forCellWithReuseIdentifier:@"LxmHomeTopTitleCell"];
        
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.leading.trailing.equalTo(self);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    LxmGoodListModel * model = [self.titleArr1 lxm_object1AtIndex:indexPath.item];
//    CGFloat w  = [model.content getSizeWithMaxSize:CGSizeMake(ScreenW , 50) withFontSize:18].width;
    return CGSizeMake(floor((ScreenW - 30)/self.titleArr.count), 50);
}

- (void)setTitleArr:(NSArray<LxmHomeFirstTypeModel *> *)titleArr {
    _titleArr = titleArr;
    [self.collectionView reloadData];
}

- (void)setFirstTypeID:(NSString *)firstTypeID {
    for (int i = 0; i<_titleArr.count; i++) {
        LxmHomeFirstTypeModel *model = _titleArr[i];
        if (model.id.intValue == firstTypeID.intValue) {
            self.selectIndex = i;
            [self.collectionView reloadData];
            break;
        }
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LxmHomeTopTitleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LxmHomeTopTitleCell" forIndexPath:indexPath];
    cell.titleLab.text = self.titleArr[indexPath.item].category_name;
    cell.titleLab.font = indexPath.item == self.selectIndex ? [UIFont boldSystemFontOfSize:16] : [UIFont systemFontOfSize:14];
    cell.lineLabel.hidden = indexPath.item == self.selectIndex ? NO : YES;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.selectIndex = indexPath.item;
    [self.collectionView reloadData];
    LxmHomeFirstTypeModel *model = self.titleArr[indexPath.item];
    if (self.topViewSelectBlock) {
        self.topViewSelectBlock(model);
    }
}


@end

@implementation LxmHomeTopTitleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.textColor = CharacterDarkColor;
        self.titleLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.titleLab];
        
        self.lineLabel = [[UILabel alloc] init];
        self.lineLabel.backgroundColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];
        self.lineLabel.layer.cornerRadius = 1.5;
        self.lineLabel.layer.masksToBounds = YES;
        [self addSubview:self.lineLabel];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(self);
        }];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-7);
            make.centerX.equalTo(self);
            make.width.equalTo(@15);
            make.height.equalTo(@3);
        }];
        
    }
    return self;
}

@end


@implementation LxmHomeLeftTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.lineView];
        [self addSubview:self.titleLabel];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(@3.5);
            make.height.equalTo(@21.5);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

@end

@interface LxmGoodsCell ()

@property (nonatomic, strong) UIImageView *imgView;//物品图片

@property (nonatomic, strong) UILabel *nameLabel;//物品名称

@end
@implementation LxmGoodsCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
        [self addSubview:self.nameLabel];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.leading.top.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
            make.height.equalTo(@(frame.size.width - 30));
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(15);
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
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.text = @"iPhone 11 Pro Max";
    }
    return _nameLabel;
}

- (void)setGoodsModel:(LxmHomeGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
//    [_imgView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.main_pic] placeholderImage:[UIImage imageNamed:@"789789"] options:SDWebImageRetryFailed];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.main_pic] placeholderImage:[UIImage imageNamed:@"789789"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"%@",error);

        }
    }];
    _nameLabel.text = _goodsModel.good_name;
}

@end
