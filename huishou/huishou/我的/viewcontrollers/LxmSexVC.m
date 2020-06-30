//
//  LxmSexVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/18.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmSexVC.h"

@interface LxmSexVC ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation LxmSexVC

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        [_rightButton setTitle:@"保存" forState:UIControlStateNormal];
        [_rightButton setTitleColor: [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightButton addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"性别";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.currentIndex = [[LxmTool ShareTool].userModel.sex isEqualToString:@"男"] ? 0 : 1;
    [self initHeaderView];
}

- (void)initHeaderView {
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@0.5);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        
        UIImageView *accImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
        accImgView.image = [UIImage imageNamed:@"select_y"];
        accImgView.tag = 222;
        [cell addSubview:accImgView];
        
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(cell).offset(15);
            make.bottom.trailing.equalTo(cell);
            make.height.equalTo(@0.5);
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:222];
    cell.accessoryView = imgView;
    imgView.hidden = self.currentIndex != indexPath.row;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = self.currentIndex == indexPath.row ? [UIColor colorWithRed:252/255.0 green:87/255.0 blue:91/255.0 alpha:1.0] : [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] ;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
    cell.textLabel.text =indexPath.row == 0 ? @"男" : @"女";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    [self.tableView reloadData];
}

/// 保存
- (void)saveClick:(UIButton *)btn {
    NSDictionary *dict = @{
        @"sex" : self.currentIndex == 0 ? @"男" : @"女",
                           @"token" : SESSION_TOKEN
                           };
    [SVProgressHUD show];
    btn.userInteractionEnabled = NO;
    WeakObj(self);
    [LxmNetworking networkingPOST:app_user_sex parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
         btn.userInteractionEnabled = YES;
        if ([responseObject[@"key"] integerValue] == 1000) {
            [SVProgressHUD showSuccessWithStatus:@"性别已修改!"];
            LxmTool.ShareTool.userModel.sex = self.currentIndex == 0 ? @"男" : @"女";
            [selfWeak.navigationController popViewControllerAnimated:YES];
        } else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        btn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}

@end
