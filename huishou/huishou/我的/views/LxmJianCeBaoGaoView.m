//
//  LxmJianCeBaoGaoView.m
//  huishou
//
//  Created by 李晓满 on 2020/4/3.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmJianCeBaoGaoView.h"

@interface LxmJianCeBaoGaoView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)  UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LxmJianCeBaoGaoView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton * bgBtn =[[UIButton alloc] initWithFrame:self.bounds];
        [bgBtn addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        bgBtn.tag = 110;
        [self addSubview:bgBtn];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height* 0.4, frame.size.width, frame.size.height * 0.6)];
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.contentView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - 100) * 0.5, 10, 100, 20)];
        _titleLabel.text = @"检测报告";
        [_contentView addSubview:_titleLabel];
        
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 40, 0, 40, 40)];
        [_closeBtn setImage:[UIImage imageNamed:@"形状 22"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_closeBtn];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 0.5)];
        _lineView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        [_contentView addSubview:_lineView];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40.5, frame.size.width, _contentView.bounds.size.height - 40.5)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:_tableView];
    }
    return self;
}



-(void)bgBtnClick {
    [self dismiss];
}

- (void)show {
    [_tableView reloadData];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.0];
    CGRect rect = _contentView.frame;
    rect.origin.y = self.bounds.size.height;
    _contentView.frame = rect;
    
    WeakObj(self);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
        CGRect rect = selfWeak.contentView.frame;
        rect.origin.y = selfWeak.bounds.size.height - selfWeak.contentView.frame.size.height;
        selfWeak.contentView.frame = rect;
        
    } completion:nil];
}
-(void)dismiss {
    WeakObj(self);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.0];
        CGRect rect = selfWeak.contentView.frame;
        rect.origin.y = self.bounds.size.height;
        selfWeak.contentView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _check_pic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        UILabel *titleLabel = [UILabel new];
        titleLabel.tag = 111;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        [cell addSubview:titleLabel];
        
        UILabel *detailLabel = [UILabel new];
        detailLabel.tag = 123;
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        detailLabel.numberOfLines = 0;
        [cell addSubview:detailLabel];
        titleLabel.numberOfLines = 0;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(cell).offset(15);
            make.top.equalTo(cell).offset(10);
//            make.height.equalTo(@15);
            make.trailing.equalTo(cell.mas_centerX);
            make.bottom.lessThanOrEqualTo(cell).offset(-10);
        }];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(cell).offset(-15);
            make.top.equalTo(cell).offset(10);
            make.bottom.equalTo(cell).offset(-10);
            make.leading.equalTo(cell.mas_centerX);
        }];
        
    }
    
    UILabel *titleLabel = [cell viewWithTag:111];
    UILabel *detailLabel = [cell viewWithTag:123];
    NSDictionary *dict = _check_pic[indexPath.row];
    titleLabel.text = dict[@"title"];
    detailLabel.text = dict[@"value"];
    return cell;
}

@end
