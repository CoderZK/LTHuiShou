//
//  LxmHomeVC.m
//  回收
//
//  Created by 李晓满 on 2020/3/11.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmHomeVC.h"
#import "LxmHomeView.h"
#import "LxmGuJiaVC.h"
#import "SDCycleScrollView.h"
#import "LxmHomeSeeMoreVC.h"
#import "LxmChargeCenterVC.h"
#import "LxmGoodsListVC.h"
#import "LxmOrderDetailVC.h"
#import "QYZJLocationTool.h"
#import "QYZJCityChooseTVC.h"
#import "LxmAqListVC.h"
#import "LxmSearchTVC.h"
@interface LxmHomeVC ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) LxmTitleView *titleView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) SDCycleScrollView *bannerView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionView *collectionView1;

@property (nonatomic, strong) UIButton *gujiaButton;//免费估价

@property (nonatomic, strong) UIButton *gujiaButton1;//悬浮免费估价

@property (nonatomic, strong) LxmHomeFirstTypeRootModel *typeModel;//首页一级分类model

@property (nonatomic, strong) LxmHomeRootModel *homeModel;//首页其他数据
@property(nonatomic,strong)QYZJLocationTool *tool;
@property(nonatomic,strong)NSString *cityStr;
/**  */
@property(nonatomic , strong)NSMutableArray<LxmHomeRootModel1 *> *qusetData;

/**  */
@property(nonatomic , strong)UIView *goShangV;

@end

@implementation LxmHomeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW,15 + (ScreenW - 30) * 0.4  + 22 +90 + 20  + 40 + 30 + (15+20+15+(ScreenW - 60)/313*96 + 15) + 15)];
    }
    return _headView;
}

-(UIView *)goShangV {
    if (_goShangV == nil) {
        _goShangV = [[UIView alloc] initWithFrame:CGRectMake(15,  CGRectGetMaxY(self.gujiaButton.frame) + 30  , ScreenW - 30, 15+20+15+(ScreenW - 60)/313*96 + 15)];
        _goShangV.backgroundColor = [UIColor whiteColor];
        _goShangV.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.3].CGColor;
        _goShangV.layer.shadowRadius = 5;
        _goShangV.layer.shadowOpacity = 0.5;
        _goShangV.layer.shadowOffset = CGSizeMake(0, 0);
        _goShangV.layer.cornerRadius = 5;
        
        UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake(15, 15, 120, 20)];
        lb.font = [UIFont boldSystemFontOfSize:16];
        lb.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        lb.text = @"惠多购";
        [_goShangV addSubview:lb];
        
        
        UIImageView * imgV =  [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 30 -5-15, 18, 5, 9)];
        imgV.image = [UIImage imageNamed:@"arrow_right"];
        [_goShangV addSubview:imgV];
        
        UIImageView * imgVTwo =  [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, (ScreenW - 60), (ScreenW - 60)/313*96)];
        imgVTwo.image = [UIImage imageNamed:@"kk2"];
        [_goShangV addSubview:imgVTwo];
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_goShangV addGestureRecognizer:tap];
        
        
        
        
        
    }
    return _goShangV;
}






- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(15, 15, ScreenW - 30, (ScreenW - 30) * 0.4) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
        _bannerView.localizationImageNamesGroup = @[@"banner",@"banner",@"banner"];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _bannerView.currentPageDotImage = [UIImage imageNamed:@"banner_1"];
        _bannerView.pageDotImage = [UIImage imageNamed:@"banner_2"];
        _bannerView.layer.cornerRadius = 10;
        _bannerView.layer.masksToBounds = YES;
    }
    return _bannerView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = (ScreenW - 30 - 56*4)/3;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(56,86);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, (ScreenW - 30) * 0.4 + 15 + 22, ScreenW - 30, 90) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerClass:LxmHomeItemCell.class forCellWithReuseIdentifier:@"LxmHomeItemCell"];
    }
    return _collectionView;
}

- (UICollectionView *)collectionView1 {
    if (!_collectionView1) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = (ScreenW - 30 - 56*4)/3;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(56,86);
        _collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.collectionView.frame) +22, ScreenW - 30, 90) collectionViewLayout:layout];
        _collectionView1.showsHorizontalScrollIndicator = NO;
        _collectionView1.backgroundColor = UIColor.whiteColor;
        _collectionView1.dataSource = self;
        _collectionView1.delegate = self;
        _collectionView1.scrollEnabled = YES;
        [_collectionView1 registerClass:LxmHomeItemCell.class forCellWithReuseIdentifier:@"LxmHomeItemCell"];
    }
    return _collectionView1;
}

- (UIButton *)gujiaButton {
    if (!_gujiaButton) {
        _gujiaButton = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_collectionView1.frame) + 22, ScreenW - 30, 40)];
        _gujiaButton.backgroundColor = [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0];
        _gujiaButton.layer.cornerRadius = 3;
        _gujiaButton.layer.masksToBounds = YES;
        [_gujiaButton setTitle:@"免费估价" forState:UIControlStateNormal];
        [_gujiaButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _gujiaButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_gujiaButton addTarget:self action:@selector(gujiaClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gujiaButton;
}

- (UIButton *)gujiaButton1 {
    if (!_gujiaButton1) {
        _gujiaButton1 = [[UIButton alloc] init];
        [_gujiaButton1 setBackgroundImage:[UIImage imageNamed:@"mianfei_gujia"] forState:UIControlStateNormal];
        _gujiaButton1.hidden = YES;
        [_gujiaButton1 addTarget:self action:@selector(gujiaClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gujiaButton1;
}


- (LxmTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[LxmTitleView alloc] initWithFrame:CGRectMake(0, NavigationSpace - 44, ScreenW - 30, 40)];
        [_titleView.addressButton addTarget:self action:@selector(cityAction) forControlEvents:UIControlEventTouchUpInside];
        WeakObj(self);
        _titleView.searchBlock = ^{
            //            LxmGoodsListVC *vc = [LxmGoodsListVC new];
            //            vc.hidesBottomBarWhenPushed = YES;
            //            [selfWeak.navigationController pushViewController:vc animated:YES];
            LxmSearchTVC *vc = [[LxmSearchTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.cityStr = selfWeak.cityStr;
            [selfWeak.navigationController pushViewController:vc animated:YES];
        };
    }
    return _titleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qusetData = @[].mutableCopy;
    self.tableView.backgroundColor = self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.gujiaButton1];
    [self.headView addSubview:self.bannerView];
    [self.headView addSubview:self.collectionView];
    [self.headView addSubview:self.collectionView1];
    [self.headView addSubview:self.gujiaButton];
    [self.headView addSubview:self.goShangV];
    
    self.headView.mj_h = CGRectGetMaxY(self.goShangV.frame) + 15;
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationSpace - 44);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(ScreenW - 30));
        make.height.equalTo(@44);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [self.gujiaButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
        make.width.equalTo(@180);
        make.height.equalTo(@45);
    }];
    self.tableView.tableHeaderView = self.headView;
    WeakObj(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        StrongObj(self);
        [self loadFirstTypeData];
        [self loadHomeData];
    }];
    [self loadFirstTypeData];
    [self loadHomeData];
    
    
    
    self.tool = [[QYZJLocationTool alloc] init];
    [self.tool locationAction];
    
    self.tool.locationBlock = ^(NSString * _Nonnull cityStr, NSString * _Nonnull cityID,NSString *province) {
        NSLog(@"\n\n=====%@",cityStr);
        
        selfWeak.titleView.addressButton.cityLabel.text = cityStr;
        selfWeak.cityStr = cityStr;
        [selfWeak loadHomeData];
    };
    
    
    
    [LxmEventBus registerEvent:@"pushOrderDetail" block:^(id data) {
        NSString *orderId = [NSString stringWithFormat:@"%@",data[@"orderId"]];
        LxmOrderDetailVC *vc = [[LxmOrderDetailVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.orderId = orderId;
        [selfWeak.navigationController pushViewController:vc animated:YES];
    }];
    self.qusetData = @[].mutableCopy;
    [self  getQuestList];
    
}


- (void)getQuestList {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"city"] = self.cityStr;
    [LxmNetworking networkingPOST:question_list parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"key"] intValue] == 1000) {
            self.qusetData = [LxmHomeRootModel1 mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
            [self.tableView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)cityAction {
    
    QYZJCityChooseTVC * vc =[[QYZJCityChooseTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    WeakObj(self);
    vc.clickCityBlock = ^(NSString * _Nonnull cityStr, NSString * _Nonnull cityId) {
        selfWeak.cityStr = cityStr;
        selfWeak.titleView.addressButton.cityLabel.text = cityStr;
        [selfWeak loadHomeData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _collectionView) {
        return self.typeModel.result.list.count;
    } else {
        return self.homeModel.result.map.third.count;
    }
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LxmHomeItemCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LxmHomeItemCell" forIndexPath:indexPath];
    if (collectionView == _collectionView) {
        [itemCell.imgView sd_setImageWithURL:[NSURL URLWithString:self.typeModel.result.list[indexPath.item].type_pic] placeholderImage:[UIImage imageNamed:@"789789"] options:SDWebImageRetryFailed];
        itemCell.titleLabel.text = self.typeModel.result.list[indexPath.item].category_name;
    } else {
        [itemCell.imgView sd_setImageWithURL:[NSURL URLWithString:self.homeModel.result.map.third[indexPath.item].img_path] placeholderImage:[UIImage imageNamed:@"789789"] options:SDWebImageRetryFailed];
        itemCell.titleLabel.text = self.homeModel.result.map.third[indexPath.item].title;
    }
    return itemCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _collectionView) {
        if (self.typeModel.result.list.count > 0) {
            LxmHomeSeeMoreVC *vc = [LxmHomeSeeMoreVC new];
            vc.list = self.typeModel.result.list;
            vc.firstTypeID = self.typeModel.result.list[indexPath.item].id;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        LxmHomeThirdModel *model  = self.homeModel.result.map.third[indexPath.item];
        if (model.type.intValue == 2) {//第三方链接
            if (indexPath.item == 1) {//酒店
                [self getThirdLogin:@3 name:@"酒店"];
            } else if (indexPath.item == 2) {//机票
                [self getThirdLogin:@1 name:@"机票"];
            } else if (indexPath.item == 3) {//火车票
                [self getThirdLogin:@2 name:@"火车票"];
            }
        } else {//充值
            
            if (![LxmTool ShareTool].isLogin) {
                [self gotoLogin];
            }else {
                LxmChargeCenterVC *vc = [LxmChargeCenterVC new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.homeModel.result.map.category_data.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section == self.homeModel.result.map.category_data.count ) {
        return self.qusetData.count;;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.homeModel.result.map.category_data.count ) {
        LxmHomeQuestionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmHomeQuestionCell"];
        if (!cell) {
            cell = [[LxmHomeQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmHomeQuestionCell"];
        }
        cell.model = self.qusetData[indexPath.row];
        cell.clipsToBounds = YES;
        return cell;
    }
    LxmHomeClassifyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmHomeClassifyCell"];
    if (!cell) {
        cell = [[LxmHomeClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmHomeClassifyCell"];
    }
    WeakObj(self);
    LxmHomeCategroyModel *cateModel = self.homeModel.result.map.category_data[indexPath.section];
    cell.categroyModel = cateModel;
    cell.goods = cateModel.goods;
    cell.titleButtonClickBlock = ^(LxmHomeCategroyModel *categroyModel) {
        [selfWeak moreClick:categroyModel];
    };
    cell.didselectItemBlock = ^(LxmHomeGoodsModel *goodsModel) {
        [selfWeak pageToGuJia:goodsModel];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == self.homeModel.result.map.category_data.count) {
        LxmHomeQuestionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmHomeQuestionHeaderView"];
        if (!headerView) {
            headerView = [[LxmHomeQuestionHeaderView alloc] initWithReuseIdentifier:@"LxmHomeQuestionHeaderView"];
        }
        return headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == self.homeModel.result.map.category_data.count) {
        LxmHomeQuestionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LxmHomeQuestionFooterView"];
        if (!footerView) {
            footerView = [[LxmHomeQuestionFooterView alloc] initWithReuseIdentifier:@"LxmHomeQuestionFooterView"];
            
        }
        [footerView.bgButton addTarget:self action:@selector(questMore) forControlEvents:UIControlEventTouchUpInside];
        return footerView;
    }
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.homeModel.result.map.category_data.count ) {
        LxmHomeRootModel1 *model = self.qusetData[indexPath.row];
        return model.cellheight;
    }
    NSArray <LxmHomeGoodsModel *>*arr = self.homeModel.result.map.category_data[indexPath.section].goods;
    return 80 + (210 + 5) * ceil(arr.count/2.0) - 5 + 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == self.homeModel.result.map.category_data.count ) {
        return 50;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.homeModel.result.map.category_data.count) {
        return 50;
    }
    return 0.01;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%lf", scrollView.bounds.origin.y);
    if (scrollView.bounds.origin.y >= CGRectGetMaxY(_collectionView.frame) + 22 + 40) {
        self.gujiaButton1.hidden = NO;
    }else {
        self.gujiaButton1.hidden = YES;
    }
}
//问题更多
- (void)questMore {
    
    LxmAqListVC *vc = [[LxmAqListVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


/* 事件处理 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    LxmHomeBannerModel *model = self.homeModel.result.map.banner[index];
    
    if (model.info_type.intValue == 2) {
        
        
        LxmGuJiaVC *vc = [LxmGuJiaVC new];
        vc.goodId = model.info_id;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    
    LxmWebViewController *webVC = [[LxmWebViewController alloc] init];
    webVC.navigationItem.title = @"详情";
    webVC.loadUrl = [NSURL URLWithString:model.link];
    [self.navigationController pushViewController:webVC animated:YES];
}


/// 免费估价
- (void)gujiaClick {
    
    LxmHomeSeeMoreVC *vc = [LxmHomeSeeMoreVC new];
    vc.list = self.typeModel.result.list;
    if (self.typeModel.result.list.count > 0) {
        vc.firstTypeID = self.typeModel.result.list[0].id;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
//具体商品估计
- (void)pageToGuJia:(LxmHomeGoodsModel *)goodsModel {
    LxmGuJiaVC *vc = [LxmGuJiaVC new];
    vc.goodId = goodsModel.id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/// 查看更多
- (void)moreClick: (LxmHomeCategroyModel *)model {
    LxmHomeSeeMoreVC *vc = [LxmHomeSeeMoreVC new];
    vc.list = self.typeModel.result.list;
    vc.firstTypeID = model.id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/// 获取首页一级分类
- (void)loadFirstTypeData {
    if (!self.typeModel) {
        [SVProgressHUD show];
    }
    WeakObj(self);
    [LxmNetworking networkingPOST:first_type_list parameters:nil returnClass:LxmHomeFirstTypeRootModel.class success:^(NSURLSessionDataTask *task, LxmHomeFirstTypeRootModel *responseObject) {
        [selfWeak endRefrish];
        if (responseObject.key.intValue == 1000) {
            selfWeak.typeModel = responseObject;
            [selfWeak.collectionView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfWeak endRefrish];
    }];
}

//app-首页数据
- (void)loadHomeData {
    if (!self.homeModel) {
        [SVProgressHUD show];
    }
    WeakObj(self);
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"city"] = self.cityStr;
    [LxmNetworking networkingPOST:index_list parameters:dict returnClass:LxmHomeRootModel.class success:^(NSURLSessionDataTask *task, LxmHomeRootModel *responseObject) {
        [selfWeak endRefrish];
        if (responseObject.key.intValue == 1000) {
            selfWeak.homeModel = responseObject;
            NSMutableArray *temp = [NSMutableArray array];
            for (LxmHomeBannerModel *model in selfWeak.homeModel.result.map.banner) {
                [temp addObject:model.img_path];
            }
            selfWeak.bannerView.imageURLStringsGroup = temp;
            
            if (selfWeak.homeModel.result.map.third.count == 0) {
                selfWeak.collectionView1.hidden = YES;
                selfWeak.gujiaButton.mj_y = CGRectGetMaxY(selfWeak.collectionView.frame) + 22;
                selfWeak.goShangV.mj_y = CGRectGetMaxY(selfWeak.gujiaButton.frame) + 30;
                selfWeak.headView.mj_h = CGRectGetMaxY(selfWeak.goShangV.frame) + 15;
            }else {
                selfWeak.collectionView1.hidden = NO;
                selfWeak.gujiaButton.mj_y = CGRectGetMaxY(selfWeak.collectionView1.frame) + 22;
                selfWeak.goShangV.mj_y = CGRectGetMaxY(selfWeak.gujiaButton.frame) + 30;
                selfWeak.headView.mj_h = CGRectGetMaxY(selfWeak.goShangV.frame) + 15;
                [selfWeak.collectionView1 reloadData];
            }
            
            
            [selfWeak.tableView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfWeak endRefrish];
    }];
}

- (void)getThirdLogin:(NSNumber *)type name:(NSString *)name {
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:get_linkNew parameters:@{@"token" : SESSION_TOKEN, @"type" : type} returnClass:LxmHomeThirdLoginRootModel.class success:^(NSURLSessionDataTask *task, LxmHomeThirdLoginRootModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.intValue == 1000) {
            LxmWebViewController *vc = [[LxmWebViewController alloc] init];
            vc.navigationItem.title = name;
            vc.loadUrl = [NSURL URLWithString:responseObject.result.data];
            [selfWeak.navigationController pushViewController:vc animated:YES];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

//切换到商城

- (void)tap:(UITapGestureRecognizer *)tap {
    
    LTSCTabBarVC * tabvc = [[LTSCTabBarVC alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabvc;
    
}


@end
