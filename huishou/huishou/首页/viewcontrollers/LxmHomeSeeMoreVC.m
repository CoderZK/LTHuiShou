//
//  LxmHomeSeeMoreVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmHomeSeeMoreVC.h"
#import "LxmHomeSeeMoreView.h"
#import "LxmGuJiaVC.h"
#import "LxmGoodsListVC.h"

@interface LxmHomeSeeMoreVC ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) LxmHomeSeeMoreView *titleView;

@property (nonatomic, strong) LxmHomeTopTitleView *topView;//顶部

@property (nonatomic, strong) UITableView *leftTableView;//左侧视图

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) LxmHomeFirstTypeRootModel *secondTypeModel;//首页二级分类model
@property (nonatomic, strong) LxmHomeFirstTypeRootModel *typeModel;//首页一级分类model
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray <LxmHomeGoodsModel *>*dataArr;

@property (nonatomic, assign) NSInteger allPageNum;

@property (nonatomic, assign) NSString *secondTypeID;

@end

@implementation LxmHomeSeeMoreVC

- (LxmHomeSeeMoreView *)titleView {
    if (!_titleView) {
        _titleView = [[LxmHomeSeeMoreView alloc] initWithFrame:CGRectMake(0, NavigationSpace - 44, ScreenW - 15, 40)];
        WeakObj(self);
        _titleView.backClickBlock = ^{
            [selfWeak.navigationController popViewControllerAnimated:YES];
        };
        _titleView.searchBlock = ^{
          LxmGoodsListVC *vc = [LxmGoodsListVC new];
          [selfWeak.navigationController pushViewController:vc animated:YES];
        };
    }
    return _titleView;
}

- (LxmHomeTopTitleView *)topView {
    if (!_topView) {
        _topView = [[LxmHomeTopTitleView alloc] initWithFrame:CGRectMake(0, NavigationSpace, ScreenW, 50)];
        WeakObj(self);
        _topView.topViewSelectBlock = ^(LxmHomeFirstTypeModel *model) {
            selfWeak.firstTypeID = model.id;
            [selfWeak loadSecondTypeData];
        };
    }
    return _topView;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] init];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.showsVerticalScrollIndicator = NO;
    }
    return _leftTableView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((ScreenW - 110)*0.5,(ScreenW - 110)*0.5 + 35);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 5);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:LxmGoodsCell.class forCellWithReuseIdentifier:@"LxmGoodsCell"];
    }
    return _collectionView;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.collectionView];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.backgroundColor = [UIColor whiteColor];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.view).offset(NavigationSpace - 44);
       make.centerX.equalTo(self.view);
       make.width.equalTo(@(ScreenW - 30));
       make.height.equalTo(@44);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.width.equalTo(@(ScreenW));
        make.height.equalTo(@50);
    }];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.leading.equalTo(self.view);
        make.width.equalTo(@99);
        make.bottom.equalTo(self.view);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.width.equalTo(@1);
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.leftTableView.mas_trailing);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.leading.equalTo(self.lineView.mas_trailing);
        make.bottom.trailing.equalTo(self.view);
        
    }];
    
    if (self.isTab) {
        [self loadFirstTypeData];
        self.titleView.backButton.hidden = YES;
    }else {
        self.topView.titleArr = self.list;
        self.topView.firstTypeID = self.firstTypeID;
        [self loadSecondTypeData];
    }
    
   
    
    self.dataArr = [NSMutableArray array];
    self.allPageNum = 1;
    self.page = 1;
    WeakObj(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       selfWeak.page = 1;
       [selfWeak loadGoodsList:self.secondTypeID];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       [selfWeak loadGoodsList:self.secondTypeID];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.secondTypeModel.result.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmHomeLeftTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmHomeLeftTableCell"];
    if (!cell) {
        cell = [[LxmHomeLeftTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmHomeLeftTableCell"];
    }
    cell.titleLabel.text = self.secondTypeModel.result.list[indexPath.row].category_name;
    cell.titleLabel.textColor = indexPath.row == self.currentIndex ? [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0] : [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    cell.lineView.hidden = indexPath.row == self.currentIndex ? NO : YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    [self.leftTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.secondTypeID = self.secondTypeModel.result.list[indexPath.row].id;
    self.page = 1;
    [self loadGoodsList:self.secondTypeID];
    [self.leftTableView reloadData];
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

/// 获取首页一级分类
- (void)loadFirstTypeData {
    if (!self.typeModel) {
        [SVProgressHUD show];
    }
    WeakObj(self);
    [LxmNetworking networkingPOST:first_type_list parameters:nil returnClass:LxmHomeFirstTypeRootModel.class success:^(NSURLSessionDataTask *task, LxmHomeFirstTypeRootModel *responseObject) {
   
        if (responseObject.key.intValue == 1000) {
            selfWeak.typeModel = responseObject;
            [selfWeak.collectionView reloadData];
            selfWeak.list = selfWeak.typeModel.result.list;
            if (selfWeak.list.count > 0) {
                selfWeak.firstTypeID = selfWeak.list[0].id;
                self.topView.titleArr = self.list;
                self.topView.firstTypeID = self.firstTypeID;
                [selfWeak loadSecondTypeData];
            }
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


/// 根据一级分类获取二级分类
- (void)loadSecondTypeData {
    if (!self.secondTypeModel) {
        [SVProgressHUD show];
    }
    WeakObj(self);
    [LxmNetworking networkingPOST:second_type_list parameters:@{@"firstTypeId":self.firstTypeID} returnClass:LxmHomeFirstTypeRootModel.class success:^(NSURLSessionDataTask *task, LxmHomeFirstTypeRootModel *responseObject) {
        [selfWeak endLeftTableRefrish];
        if (responseObject.key.intValue == 1000) {
            selfWeak.secondTypeModel = responseObject;
            if (selfWeak.secondTypeModel.result.list.count > 0) {
                selfWeak.secondTypeID = selfWeak.secondTypeModel.result.list[0].id;
                selfWeak.page = 1;
                self.currentIndex = 0;
                [selfWeak loadGoodsList:selfWeak.secondTypeID];
            }
            [selfWeak.leftTableView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfWeak endLeftTableRefrish];
    }];
}

- (void)endLeftTableRefrish {
    [SVProgressHUD dismiss];
    [self.leftTableView.mj_header endRefreshing];
    [self.leftTableView.mj_footer endRefreshing];
}

/// 根据一级分类 二级分类获取商品列表
- (void)loadGoodsList:(NSString *)secondTypeID {
    if (!secondTypeID.isValid) {
        return;
    }
    if (self.dataArr <= 0) {
        [SVProgressHUD show];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"firstTypeId"] = self.firstTypeID;
    dict[@"secondTypeId"] = secondTypeID;
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
