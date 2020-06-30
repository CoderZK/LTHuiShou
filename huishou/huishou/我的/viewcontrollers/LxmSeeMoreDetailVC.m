//
//  LxmSeeMoreDetailVC.m
//  qiangdan
//
//  Created by 李晓满 on 2020/4/3.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmSeeMoreDetailVC.h"

@interface LxmSeeMoreDetailVC ()

@end

@implementation LxmSeeMoreDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评估详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.chooseArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chooseArr[section].choices.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LxmGuJiaTitleCell0 * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmGuJiaTitleCell0"];
        if (!cell) {
            cell = [[LxmGuJiaTitleCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmGuJiaTitleCell0"];
        }
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.section + 1,self.chooseArr[indexPath.section].question];
        return cell;
    }
    LxmGuJiaDetailCell0 * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmGuJiaDetailCell0"];
    if (!cell) {
        cell = [[LxmGuJiaDetailCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmGuJiaDetailCell0"];
    }
    cell.model = self.chooseArr[indexPath.section].choices[indexPath.row - 1];
    cell.lineView.hidden = indexPath.row == self.chooseArr[indexPath.section].choices.count;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 51;
    } else {
        return self.chooseArr[indexPath.section].choices[indexPath.row - 1].cellHeight;
    }
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


@end


@interface LxmGuJiaTitleCell0 ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *lineView;

@end
@implementation LxmGuJiaTitleCell0

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.lineView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgView).offset(15);
            make.trailing.equalTo(self.bgView).offset(-15);
            make.centerY.equalTo(self.bgView);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.equalTo(self.bgView);
            make.height.equalTo(@1);
        }];
        
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//        //设置大小
//        maskLayer.frame = CGRectMake(15, 0, ScreenW - 30, 50);
//        //设置图形样子
//        maskLayer.path = maskPath.CGPath;
//        self.bg.layer.mask = maskLayer;
    }
    return self;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"1. 使用情况";
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

@end

@interface LxmGuJiaDetailCell0 ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation LxmGuJiaDetailCell0

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.lineView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.leading.equalTo(self).offset(15);
            make.trailing.equalTo(self).offset(-15);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self.bgView).offset(15);
            make.trailing.equalTo(self.bgView).offset(-15);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.bgView).offset(15);
            make.trailing.equalTo(self.bgView).offset(-15);
            make.bottom.equalTo(self.bgView);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (void)setModel:(LxmGuJiaChoicesModel *)model {
    _model = model;
    _titleLabel.text = _model.choice;
}

@end
