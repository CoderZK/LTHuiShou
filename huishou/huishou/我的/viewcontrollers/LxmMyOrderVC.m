//
//  LxmMyOrderVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/27.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmMyOrderVC.h"
#import "LxmSubMyOrderVC.h"
#import "TYTabPagerBar.h"
#import "TYPagerController.h"

@interface LxmMyOrderVC ()<TYTabPagerBarDelegate,TYTabPagerBarDataSource,TYPagerControllerDataSource,TYPagerControllerDelegate>

@property (nonatomic, strong) TYTabPagerBar *tabBar;

@property (nonatomic, strong) TYPagerController *pagerController;

@property (nonatomic, strong) NSArray *titleArray;//顶部标题数组

@end

@implementation LxmMyOrderVC

- (TYTabPagerBar *)tabBar {
    if (!_tabBar) {
        _tabBar = [[TYTabPagerBar alloc] init];
        _tabBar.backgroundColor = UIColor.whiteColor;
        _tabBar.delegate = self;
        _tabBar.dataSource = self;
        _tabBar.layout.adjustContentCellsCenter = YES;
        _tabBar.layout.progressColor = RedColor;
        _tabBar.layout.textColorProgressEnable = NO;
        _tabBar.layout.normalTextFont = [UIFont systemFontOfSize:17];
        _tabBar.layout.selectedTextFont = [UIFont boldSystemFontOfSize:20];
        _tabBar.layout.normalTextColor = CharacterGrayColor;
        _tabBar.layout.selectedTextColor = UIColor.blackColor;
        _tabBar.layout.progressVerEdging = 10;
        _tabBar.layout.progressHeight = 3;
        _tabBar.layout.progressWidth = 25;
        _tabBar.layout.cellWidth = floor(ScreenW/5.0);
        _tabBar.layout.cellSpacing = 0;
        [_tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    }
    return _tabBar;
}

- (TYPagerController *)pagerController {
    if (!_pagerController) {
        TYPagerController *pagerController = [[TYPagerController alloc]init];
        pagerController.layout.prefetchItemCount = 1;
        //pagerController.layout.autoMemoryCache = NO;
        // 只有当scroll滚动动画停止时才加载pagerview，用于优化滚动时性能
        pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
        pagerController.dataSource = self;
        pagerController.delegate = self;
        _pagerController = pagerController;
    }
    return _pagerController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.titleArray = @[@"全部",@"待抢单",@"待发货",@"待处理",@"已完成",@"已取消"];
    [self initSubviews];
    [_pagerController scrollToControllerAtIndex:self.selectIndex animate:YES];
    [_tabBar scrollToItemFromIndex:0 toIndex:self.selectIndex  animate:YES];
}

/**
 初始化子视图
 */
- (void)initSubviews {
    [self.view addSubview:self.tabBar];
    [self addChildViewController:self.pagerController];
    [self.view addSubview:self.pagerController.view];
    
    [self.tabBar reloadData];
    [self.pagerController reloadData];
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    [self.pagerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBar.mas_bottom);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
}

- (NSInteger)numberOfItemsInPagerTabBar {
    return self.titleArray.count;
}

- (NSInteger)numberOfControllersInPagerController {
    return self.titleArray.count;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    LxmSubMyOrderVC *vc = [[LxmSubMyOrderVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    //1-全部 2-待发货 3-待处理 4-已完成 5-已取消 6-待抢单
    if (index == 0) {
        vc.type = @1;
    } else if (index == 1){
        vc.type = @6;
    } else if (index == 2) {
        vc.type = @2;
    } else {
        vc.type = @(index);
    }
    return vc;
}

#pragma mark - TYTabPagerBarDelegate

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = self.titleArray[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerController scrollToControllerAtIndex:index animate:YES];
}


#pragma mark - TYPagerControllerDelegate

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = self.titleArray[index];
    return cell;
}

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}


@end
