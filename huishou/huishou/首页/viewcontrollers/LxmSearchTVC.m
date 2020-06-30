//
//  LxmSearchTVC.m
//  huishou
//
//  Created by kunzhang on 2020/5/25.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmSearchTVC.h"
#import "LxmHomeSeeMoreView.h"
#import "LxmHomeModel.h"
#import "LxmSearchOneCell.h"
#import "LxmSearchTwoCell.h"
#import "LxmGuJiaVC.h"
@interface LxmSearchTVC ()<UITableViewDelegate,UITableViewDataSource>
/** <#注释#> */
@property(nonatomic , strong)NSString *searchStr;
/** p */
@property(nonatomic , assign)NSInteger  page;
/** 注释 */
@property(nonatomic , strong)NSMutableArray<LxmHomeGoodsModel *> *dataArray;

/**  */
@property(nonatomic , strong)UIImageView *imageV;
/** <#注释#> */
@property(nonatomic , strong)UITableView *tableView;

@end

@implementation LxmSearchTVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenW -127)/2, (ScreenH -127)/2 - 50, 127, 127)];
    self.imageV.image = [UIImage imageNamed:@"nodata"];
    [self.view addSubview:self.imageV];
    self.imageV.hidden = YES;
    self.dataArray = @[].mutableCopy;
    [self.tableView registerNib:[UINib nibWithNibName:@"LxmSearchOneCell" bundle:nil] forCellReuseIdentifier:@"LxmSearchOneCell"];
   [self.tableView registerNib:[UINib nibWithNibName:@"LxmSearchTwoCell" bundle:nil] forCellReuseIdentifier:@"LxmSearchTwoCell"];
    
        UIView * gayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW-80, 44)];
        gayView.backgroundColor = [UIColor whiteColor];

        
        UISearchBar * searchbar =[[UISearchBar alloc] initWithFrame:CGRectMake(0, 8, ScreenW - 120, 30)];
        searchbar.placeholder = @"搜索";
        searchbar.layer.cornerRadius = 15;
        searchbar.clipsToBounds = YES;
        searchbar.barStyle=UIBarStyleDefault;
        [gayView addSubview:searchbar];
        [searchbar setBarTintColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]];
    [searchbar setTintColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
        
        searchbar.delegate = self;
        
        [searchbar.searchTextField.rac_textSignal  subscribeNext:^(NSString * _Nullable x) {
           //文字发生改变时
            self.page = 1;
            self.searchStr = x;
            [self loadData];
        }];
    

    
    self.navigationItem.titleView = gayView;
    
    
    self.page = 1;
       WeakObj(self);
       self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          selfWeak.page = 1;
           [selfWeak loadData];
       }];
       self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
          [selfWeak loadData];
       }];

}

- (void)loadData {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
       dict[@"city"] = self.cityStr;
    dict[@"keyword"] = self.searchStr;
    dict[@"pageNum"] = @(self.page);
    dict[@"pageSize"] = @20;
    [LxmNetworking networkingPOST:search_good_name parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
     
               [self endRefresh];
               if ([responseObject[@"key"] integerValue] == 1000) {
                   
                   NSArray<LxmHomeGoodsModel *> *arr = [LxmHomeGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
                   
                   if (self.page == 1) {
                       [self.dataArray removeAllObjects];
                   }
                   if (self.page <= [responseObject[@"result"][@"allPageNumber"] intValue]) {
                           [self.dataArray addObjectsFromArray:arr];
                        }
                 
                   if (self.dataArray.count == 0) {
                       self.imageV.hidden = NO;
                   }else {
                       self.imageV.hidden = YES;
                   }
                   self.page++;
                   [self.tableView reloadData];
               } else {
                   [UIAlertController showAlertWithmessage:responseObject[@"message"]];
               }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return self.dataArray.count;
    }

}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = @"123455";
//    return cell;
    if (indexPath.section == 0) {
        LxmSearchOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSearchOneCell" forIndexPath:indexPath];
        // cell.nameLB.text = @"fgkodkgfeoprkgkp";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        return cell;
    }else {
        LxmSearchTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSearchTwoCell" forIndexPath:indexPath];
        // cell.nameLB.text = @"fgkodkgfeoprkgkp";
        cell.leftLB.text = self.dataArray[indexPath.row].good_name;
        cell.rightLB.text =  [NSString stringWithFormat:@"最高%@",self.dataArray[indexPath.row].high_price];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.searchStr.length > 0){
        return 0;
    }
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LxmGuJiaVC *vc = [LxmGuJiaVC new];
    vc.goodId = self.dataArray[indexPath.row].id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)endRefresh {
    [SVProgressHUD dismiss];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
