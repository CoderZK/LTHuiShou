//
//  LxmZhangHaoVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/23.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmZhangHaoVC.h"
#import "LxmModifyPhoneFirstVC.h"
#import "LxmModifyPasswordVC.h"

@interface LxmZhangHaoVC ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation LxmZhangHaoVC

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号与安全";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initView];
}

- (void)initView {
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
        UIImageView *accImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 9)];
        accImgView.image = [UIImage imageNamed:@"arrow_right"];
        accImgView.tag = 100;
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
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:100];
    cell.accessoryView = imgView;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"手机号";
    } else {
        cell.textLabel.text = @"登录密码";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //手机号
        LxmModifyPhoneFirstVC *vc = [LxmModifyPhoneFirstVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else {//登录密码
        LxmModifyPasswordVC *vc = [LxmModifyPasswordVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
