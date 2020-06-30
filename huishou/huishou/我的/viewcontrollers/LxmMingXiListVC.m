//
//  LxmMingXiListVC.m
//  huishou
//
//  Created by 李晓满 on 2020/4/2.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmMingXiListVC.h"
#import "LxmMineView.h"
#import "LxmYearMonthPickerView.h"
#import "LxmTiXianDetailVC.h"

@interface LxmMingXiListVC ()

@property (nonatomic, strong) LxmMingXiTitleButton *selectButton;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger allPageNum;

@property (nonatomic, strong) NSMutableArray <LxmTiXianModel *>*dataArr;

@property (nonatomic, strong) UILabel *footerLabel;

@property (nonatomic, strong) LxmYearMonthPickerView *dataPicker;

@property (nonatomic, strong) NSDate *selectDate;

@property (nonatomic, strong) NSString *selectTime;

@property (nonatomic, strong) NSString *currentTime;//当前年月

@end

@implementation LxmMingXiListVC

- (UILabel *)footerLabel {
    if (!_footerLabel) {
        _footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
        _footerLabel.font = [UIFont systemFontOfSize:15];
        _footerLabel.textColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        _footerLabel.text = @"没有更多了～";
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        _footerLabel.hidden = YES;
    }
    return _footerLabel;
}


- (LxmMingXiTitleButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [LxmMingXiTitleButton new];
        [_selectButton addTarget:self action:@selector(calendarClick) forControlEvents:UIControlEventTouchUpInside];
        [_selectButton setTitleColor:CharacterDarkColor forState:UIControlStateNormal];
        _selectButton.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    }
    return _selectButton;
}

- (LxmYearMonthPickerView *)dataPicker {
    if (!_dataPicker) {
        _dataPicker = [[LxmYearMonthPickerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        WeakObj(self);
        _dataPicker.sureBlock = ^(NSString *year, NSString *month) {
            selfWeak.selectTime = [NSString stringWithFormat:@"%@-%@",year,month];
            selfWeak.currentTime = selfWeak.selectTime;
            selfWeak.selectButton.textLabel.text = [NSString stringWithFormat:@"%@年%02ld月",year,month.intValue];
            selfWeak.page = 1;
            selfWeak.allPageNum = 1;
            [selfWeak loadData];
        };
    }
    return _dataPicker;
}

- (void)calendarClick {
    [self.dataPicker show];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"明细";
    
    self.view.backgroundColor = self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = self.footerLabel;
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];//设置输出的格式
       [dateFormatter1 setDateFormat:@"yyyy-MM"];
    self.currentTime = [dateFormatter1 stringFromDate:[NSDate date]];
    
    self.dataArr = [NSMutableArray array];
    self.allPageNum = 1;
    self.page = 1;
    [self loadData];
    WeakObj(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       StrongObj(self);
       self.page = 1;
       self.allPageNum = 1;
       [self loadData];
    }];

    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       StrongObj(self);
       [self loadData];
    }];
    [self.view addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectButton.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    self.selectTime = [dateFormatter stringFromDate:[NSDate date]];
    self.selectButton.textLabel.text = self.selectTime;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmYuECell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmYuECell"];
    if (!cell) {
        cell = [[LxmYuECell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmYuECell"];
    }
    cell.tixianModel = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmTiXianDetailVC *vc = [LxmTiXianDetailVC new];
    vc.id = self.dataArr[indexPath.row].id;
    vc.type = self.dataArr[indexPath.row].type;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 请求数据
 */
- (void)loadData {
    if (self.page <= self.allPageNum) {
        if (self.dataArr.count <= 0) {
            [SVProgressHUD show];
        }
        
        NSArray *arr = [self.currentTime componentsSeparatedByString:@"-"];
        if (arr.count == 2) {
            NSString *fomaMonth = [NSString stringWithFormat:@"%02ld",[arr.lastObject integerValue]];
            self.currentTime = [NSString stringWithFormat:@"%@-%@",arr.firstObject,fomaMonth];
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM"];
        NSDate *date = [formatter dateFromString:self.currentTime];
        NSInteger currentInterval = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"token"] = SESSION_TOKEN;
        dict[@"pageNum"] =  @(self.page);
        dict[@"pageSize"] = @10;
        if (currentInterval != 0) {
            dict[@"time"] = @(currentInterval * 1000);
        }
        [LxmNetworking networkingPOST:money_list parameters:dict returnClass:LxmTiXianRootModel.class success:^(NSURLSessionDataTask *task, LxmTiXianRootModel *responseObject) {
            [self endRefrish];
            if (responseObject.key.intValue == 1000) {
                self.allPageNum = responseObject.result.allPageNumber.intValue;
                if (self.page == 1) {
                    [self.dataArr removeAllObjects];
                }
                if (self.page <= responseObject.result.allPageNumber.intValue) {
                    [self.dataArr addObjectsFromArray:responseObject.result.list];
                }
                self.footerLabel.hidden = self.dataArr == 0;
                self.page ++;
                [self.tableView reloadData];
            } else {
                [UIAlertController showAlertWithmessage:responseObject.message];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self endRefrish];
        }];
    }
    
}

@end
