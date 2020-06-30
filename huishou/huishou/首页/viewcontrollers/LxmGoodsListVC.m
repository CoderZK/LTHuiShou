//
//  LxmGoodsListVC.m
//  huishou
//
//  Created by 李晓满 on 2020/4/5.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmGoodsListVC.h"
#import "LxmHomeView.h"
#import "LxmGuJiaVC.h"
#import "LxmHomeSeeMoreView.h"

@interface LxmGoodsListVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property (nonatomic, strong) LxmSearchPageView *serachView;//搜索栏

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray <LxmHomeGoodsModel *>*dataArr;

@property (nonatomic, assign) NSInteger allPageNum;

@property (nonatomic, strong) NSString *keywords;

@property (nonatomic, strong) LxmEmptyView *emptyView;//空界面

@end

@implementation LxmGoodsListVC

- (LxmEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[LxmEmptyView alloc] init];
        _emptyView.textLabel.text = @"换个关键词吧~没有结果呢";
        _emptyView.imgView.image = [UIImage imageNamed:@"empty"];
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (LxmSearchPageView *)serachView {
    if (!_serachView) {
        _serachView = [[LxmSearchPageView alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 30)];
        _serachView.searchTF.delegate = self;
    }
    return _serachView;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _emptyView.hidden = YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    _emptyView.hidden = YES;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.serachView endEditing:YES];
    if (!textField.text.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请输入搜索内容!"];
        return NO;
    }
    _emptyView.hidden = YES;
    self.keywords = textField.text;
    self.page = 1;
    [self loadData];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.serachView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.emptyView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serachView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serachView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    WeakObj(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.page = 1;
        [selfWeak loadData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [selfWeak loadData];
    }];
    self.dataArr = [NSMutableArray array];
    self.page = 1;
    [self loadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 15;
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 0, 15);
        layout.minimumInteritemSpacing = 15;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((ScreenW - 45)*0.5, (ScreenW - 45)*0.5 + 35);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:LxmGoodsCell.class forCellWithReuseIdentifier:@"LxmGoodsCell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LxmGoodsCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LxmGoodsCell" forIndexPath:indexPath];
    itemCell.goodsModel = self.dataArr[indexPath.item];
    return itemCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LxmHomeGoodsModel *goodsModel = self.dataArr[indexPath.item];
    LxmGuJiaVC *vc = [LxmGuJiaVC new];
    vc.goodId = goodsModel.id;
    [self.navigationController pushViewController:vc animated:YES];
}


/// 获取商品列表
- (void)loadData {
    if (self.dataArr <= 0) {
        [SVProgressHUD show];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.keywords.isValid) {
        dict[@"keyword"] = self.keywords;
    }
    dict[@"pageNum"] = @(self.page);
    dict[@"pageSize"] = @10;
    WeakObj(self);
    [LxmNetworking networkingPOST:good_listNew parameters:dict returnClass:LxmGoodsListRootModel.class success:^(NSURLSessionDataTask *task, LxmGoodsListRootModel *responseObject) {
        StrongObj(self);
        [self endRefresh];
        if (responseObject.key.integerValue == 1000) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            if (self.page <= responseObject.result.allPageNumber.intValue) {
                 [self.dataArr addObjectsFromArray:responseObject.result.list];
            }
            selfWeak.emptyView.hidden = selfWeak.dataArr.count > 0;
            self.page++;
            [self.collectionView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
    }];
}

- (void)endRefresh {
    [SVProgressHUD dismiss];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

@end
