//
//  LxmAqListVC.m
//  wujin
//
//  Created by 李晓满 on 2019/6/6.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmAqListVC.h"
#import "LxmHomeModel.h"
#import "LxmHomeView.h"
@interface LxmAqListVC ()

@property (nonatomic, assign) NSInteger page;


@property(nonatomic , strong)NSMutableArray<LxmHomeRootModel1 *> *qusetData;

@end

@implementation LxmAqListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"常见问题自助区";
    self.qusetData = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(1);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
    self.page = 1;
    [self loadData];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadData];
    }];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)loadData {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.qusetData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmHomeQuestionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmHomeQuestionCell"];
    if (!cell) {
        cell = [[LxmHomeQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmHomeQuestionCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row + 1;
    LxmHomeRootModel1 *model = self.qusetData[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmHomeRootModel1 *model = self.qusetData[indexPath.row];
    return model.cellheight;
}

@end
