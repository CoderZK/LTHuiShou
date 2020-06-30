//
//  LxmGuJiaVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/12.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmGuJiaVC.h"
#import "LxmGuJiaView.h"
#import "LxmXiaDanStyleVC.h"
#import "LxmGuJiaAlertView.h"

@interface LxmGuJiaVC ()

@property (nonatomic, strong) LxmGuJiaHeaderView *headerView;

@property (nonatomic, strong) LxmGuJiaBottomView *bottomView;

@property (nonatomic, strong) NSMutableArray <LxmGujiaChoicesDataModel *>*chooseArr;//可选择数组

@property (nonatomic, strong) LxmGuJiaModel *gujiaModel;

@end

@implementation LxmGuJiaVC

- (LxmGuJiaHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [LxmGuJiaHeaderView new];
    }
    return _headerView;
}

- (LxmGuJiaBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[LxmGuJiaBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.shadowColor = [CharacterDarkColor colorWithAlphaComponent:0.2].CGColor;
        _bottomView.layer.shadowRadius = 5;
        _bottomView.layer.shadowOpacity = 0.5;
        _bottomView.layer.shadowOffset = CGSizeMake(0, 0);
        WeakObj(self);
        _bottomView.gujiaClickBlock = ^{
            if (self.headerView.progressView.progress < 1.0) {
                [SVProgressHUD showErrorWithStatus:@"请完善所有选项！"];
                return ;
            }
            
            if (!ISLOGIN) {
                [self gotoLogin];
                return;
            }
            
            
            NSArray *dictArray = [LxmGujiaChoicesDataModel mj_keyValuesArrayWithObjectArray:selfWeak.chooseArr];
            NSString *content = [dictArray mj_JSONString];
            
            NSArray<LxmGujiaChoicesDataModel *> *chooseArr = [LxmGujiaChoicesDataModel mj_objectArrayWithKeyValuesArray:content];
            
            NSMutableArray <LxmGujiaChoicesDataModel *>*arr = [NSMutableArray array];
            double price = 0;
            for (LxmGujiaChoicesDataModel *dataModel in chooseArr) {
                NSMutableArray <LxmGuJiaChoicesModel *> *tempArr  = [NSMutableArray array];
                for (LxmGuJiaChoicesModel *choiceModel in dataModel.choices) {
                    if (choiceModel.isSelected) {
                        [tempArr addObject:choiceModel];
                        price += choiceModel.price.doubleValue;
                    }
                }
                dataModel.choices = tempArr;
                if (dataModel.choices.count > 0) {
                    [arr addObject:dataModel];
                }
            }
            LxmXiaDanStyleVC *vc = [[LxmXiaDanStyleVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            vc.goodId = selfWeak.goodId;
            vc.gujiModel = selfWeak.gujiaModel;
            vc.gujiaPrice = price;
            vc.chooseArr = arr;
            [selfWeak.navigationController pushViewController:vc animated:YES];
        };
    }
    return _bottomView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
  
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写估价信息";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.bottomView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(TableViewBottomSpace + 60));
    }];
    self.chooseArr = [NSMutableArray array];
    
    [self loadGuJiaDetailData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.chooseArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chooseArr[section].choices.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LxmGuJiaTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmGuJiaTitleCell"];
        if (!cell) {
            cell = [[LxmGuJiaTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmGuJiaTitleCell"];
        }
        
        if (self.chooseArr[indexPath.section].type.intValue == 2) {
            NSString * str  = [NSString stringWithFormat:@"%ld. %@  (可多选)",indexPath.section + 1,self.chooseArr[indexPath.section].question];
            cell.titleLabel.attributedText = [str getMutableAttributeStringWithFont:13 lineSpace:0 textColor:[UIColor blackColor] textColorTwo:[UIColor grayColor] nsrange:NSMakeRange(str.length - 5, 5)];
        }else {
           cell.titleLabel.text  = [NSString stringWithFormat:@"%ld. %@",indexPath.section + 1,self.chooseArr[indexPath.section].question];
        }
        WeakObj(self);
        cell.model = selfWeak.chooseArr[indexPath.section].reason;
        
        cell.reasonTitleBlock = ^(LxmGuJiaReasonModel *model) {
            LxmGuJiaChoicesModel * mm = [[LxmGuJiaChoicesModel alloc] init];
            mm.reason = model;
            [selfWeak helpClick:mm];
        };
        
        
        return cell;
    }
    LxmGuJiaDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmGuJiaDetailCell"];
    if (!cell) {
        cell = [[LxmGuJiaDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmGuJiaDetailCell"];
    }
    cell.model = self.chooseArr[indexPath.section].choices[indexPath.row - 1];
    BOOL isLast = indexPath.row == self.chooseArr[indexPath.section].choices.count;
    cell.lineView.hidden = isLast;
    cell.isLastCell = isLast;
    WeakObj(self);
    cell.reasonWenBlock = ^(LxmGuJiaChoicesModel *model) {
        [selfWeak helpClick:model];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if (indexPath.row != 0) {
        LxmGujiaChoicesDataModel *sectionDataModel = self.chooseArr[indexPath.section];
        sectionDataModel.isSelect = YES;
        LxmGuJiaChoicesModel *model = sectionDataModel.choices[indexPath.row - 1];
        if (sectionDataModel.type.intValue == 1) {
            //单选
            for (LxmGuJiaChoicesModel *tempM in sectionDataModel.choices) {
                tempM.isSelected = tempM == model;
            }
        } else {
            //多选
            model.isSelected = !model.isSelected;
        }
        
        NSInteger count = 0;
        for (LxmGujiaChoicesDataModel *sectionDataModel in self.chooseArr) {
            if (sectionDataModel.isSelect) {
                count ++;
            }
        }
        self.headerView.progressView.progress = count * 1.0 /self.chooseArr.count;
        self.headerView.jinduLabel.text = [NSString stringWithFormat:@"%ld/%ld",count, self.chooseArr.count];
        [self.tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 51;
    }
    return self.chooseArr[indexPath.section].choices[indexPath.row - 1].cellHeight0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

/// 获取商品估价信息
- (void)loadGuJiaDetailData {
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:good_detail parameters:@{@"goodId":self.goodId,@"token":SESSION_TOKEN} returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue] == 1000) {
            LxmGuJiaModel *model = [LxmGuJiaModel mj_objectWithKeyValues:responseObject[@"result"][@"data"]];
            selfWeak.gujiaModel = model;
            selfWeak.headerView.model = model;
            NSString *content = responseObject[@"result"][@"data"][@"content"];
            if (content.isValid) {
                NSArray *chooseA = [content mj_JSONObject];
                for (NSDictionary *dict in chooseA) {
                    LxmGujiaChoicesDataModel *model = [LxmGujiaChoicesDataModel mj_objectWithKeyValues:dict];
                    [selfWeak.chooseArr addObject:model];
                }
                selfWeak.headerView.progressView.progress = 0;
                selfWeak.headerView.jinduLabel.text = [NSString stringWithFormat:@"%d/%ld",0, self.chooseArr.count];
                [selfWeak.tableView reloadData];
            }
        } else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

/// 帮助
- (void)helpClick:(LxmGuJiaChoicesModel *)model {
    LxmGuJiaAlertView *alertView = [[LxmGuJiaAlertView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    alertView.model = model.reason;
    [alertView show];
}

@end
