//
//  LxmUserInfoVC.m
//  huishou
//
//  Created by 李晓满 on 2020/3/18.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmUserInfoVC.h"
#import "LxmSexVC.h"
#import "LxmNicknameVC.h"

#import <AssetsLibrary/ALAssetsLibrary.h>
#import "MXPhotoPickerController.h"
#import "UIViewController+MXPhotoPicker.h"

@interface LxmUserInfoVC ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *headerImgView;

@property (nonatomic, strong) UITableViewCell *headerImgCell;

@end

@implementation LxmUserInfoVC

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _lineView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        UIImageView *accImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 9)];
        accImgView.image = [UIImage imageNamed:@"arrow_right"];
        accImgView.tag = 111;
        [cell addSubview:accImgView];
        
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(cell).offset(15);
            make.bottom.trailing.equalTo(cell);
            make.height.equalTo(@0.5);
        }];
        
        UIImageView *headerImgView = [UIImageView new];
        headerImgView.layer.cornerRadius = 15;
        headerImgView.layer.masksToBounds = YES;
        headerImgView.tag = 110;
        [cell addSubview:headerImgView];
        [headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(cell).offset(-30);
            make.centerY.equalTo(cell);
            make.size.equalTo(@30);
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:111];
    cell.accessoryView = imgView;
    
    UIImageView *headerImgView = (UIImageView *)[cell viewWithTag:110];
    headerImgView.hidden = indexPath.row != 0;
    if (indexPath.row == 0) {
        self.headerImgCell = cell;
        self.headerImgView = headerImgView;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
    cell.detailTextLabel.hidden = indexPath.row == 0;
    cell.detailTextLabel.hidden = indexPath.row == 0;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"头像";
        [headerImgView sd_setImageWithURL:[NSURL URLWithString:LxmTool.ShareTool.userModel.head_pic] placeholderImage:[UIImage imageNamed:@"789789"] options:SDWebImageRetryFailed];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"昵称";
        cell.detailTextLabel.text = LxmTool.ShareTool.userModel.username;
    } else {
        cell.textLabel.text = @"性别";
        cell.detailTextLabel.text = LxmTool.ShareTool.userModel.sex;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //头像
        UIAlertController * actionController = [UIAlertController alertControllerWithTitle:nil message:@"选择图片上传方式" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * a1 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                if (image) {
                    [self upLoadFile:image];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"相片获取失败"];
                }
            }];
        }];
        
        UIAlertAction * a2 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self showMXPhotoPickerControllerAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                if (image) {
                    [self upLoadFile:image];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"相片获取失败"];
                }
            }];
        }];
        UIAlertAction * a3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [actionController addAction:a1];
        [actionController addAction:a2];
        [actionController addAction:a3];
        [self presentViewController:actionController animated:YES completion:nil];
        
    } else if (indexPath.row == 1) {
        //昵称
        LxmNicknameVC *vc = [LxmNicknameVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        //性别
        LxmSexVC *vc = [LxmSexVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/**
 上传图片
 */
- (void)upLoadFile:(UIImage *)image {
    [SVProgressHUD show];
    WeakObj(self);
    self.headerImgCell.userInteractionEnabled = NO;
    [LxmNetworking NetWorkingUpLoad:fileUpload image:image parameters:@{@"token" : SESSION_TOKEN} name:@"file" success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] integerValue] == 1000) {
            NSString *str = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"data"]];
            [selfWeak uploadHeaderImg:str img:image];
        } else {
            [UIAlertController showAlertWithmessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        selfWeak.headerImgCell.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}

- (void)uploadHeaderImg:(NSString *)str img:(UIImage *)image{
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:modify_head_pic parameters:@{@"token" : SESSION_TOKEN , @"pic" : str} returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel *responseObject) {
        selfWeak.headerImgCell.userInteractionEnabled = YES;
        if (responseObject.key.intValue == 1000) {
            [SVProgressHUD showSuccessWithStatus:@"头像已更新!"];
            [LxmTool ShareTool].userModel.head_pic = str;
            selfWeak.headerImgView.image = image;
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        selfWeak.headerImgCell.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}

@end
