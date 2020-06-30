//
//  LxmYuYueTimeAlert.m
//  huishou
//
//  Created by 李晓满 on 2020/3/28.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmYuYueTimeAlert.h"

@interface LxmYuYueTimeAlert ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView *_contentView;
    UILabel *_titleLabel;
    UIButton *_closeBtn;
    UIView *_lineView;
    UIView *_lineView1;
    UITableView *_dateTable;
    UITableView *_timeTable;
    NSArray<NSString *> *_times;
    NSMutableArray<NSString *> *_dates;
    NSMutableArray<NSDate *> *_dates0;
    
    
    NSDate *_currentDate0;
    
    LxmYuYueTimeAlertBlock _block;
}
@end

@implementation LxmYuYueTimeAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _times = @[@"12:00-13:00",
                   @"13:00-14:00",
                   @"14:00-15:00",
                   @"15:00-16:00",
                   @"16:00-17:00",
                   @"17:00-18:00",
                   @"18:00-19:00"];
        _dates = [NSMutableArray array];
        _dates0 = [NSMutableArray array];
        if (!self.currentTime.isValid) {
            self.currentTime = @"12:00-13:00";
        }
        
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        for (int i = 0; i < 7; i++) {
            NSDate *date = [[NSDate date] dateByAddingTimeInterval:24 * 60 * 60 * i];
            NSDateComponents *comps = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
            NSString *dateStr = [NSString stringWithFormat:@"%02ld月%02ld日",comps.month, comps.day];
            [_dates0 addObject:date];
            switch (comps.weekday) {
                case 1:
                    [_dates addObject:[NSString stringWithFormat:@"%@(星期日)", dateStr]];
                    break;
                    case 2:
                    [_dates addObject:[NSString stringWithFormat:@"%@(星期一)", dateStr]];
                    break;
                    case 3:
                    [_dates addObject:[NSString stringWithFormat:@"%@(星期二)", dateStr]];
                    break;
                    case 4:
                    [_dates addObject:[NSString stringWithFormat:@"%@(星期三)", dateStr]];
                    break;
                    case 5:
                    [_dates addObject:[NSString stringWithFormat:@"%@(星期四)", dateStr]];
                    break;
                    case 6:
                    [_dates addObject:[NSString stringWithFormat:@"%@(星期五)", dateStr]];
                    break;
                    case 7:
                    [_dates addObject:[NSString stringWithFormat:@"%@(星期六)", dateStr]];
                    break;
                default:
                    break;
            }
            
        }
        if (!self.currentDate.isValid) {
            self.currentDate = _dates[0];
        }
        _currentDate0 = _dates0[0];
        [self addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.whiteColor;
        [self addSubview:_contentView];
        
        _titleLabel = [UILabel new];
        _titleLabel.text = @"选择预约时间";
        [_contentView addSubview:_titleLabel];
        
        _closeBtn = [UIButton new];
        [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:[UIImage imageNamed:@"cancel_select"] forState:UIControlStateNormal];
        [_contentView addSubview:_closeBtn];
        
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [_contentView addSubview:_lineView];
        
        _lineView1 = [UIView new];
        _lineView1.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [_contentView addSubview:_lineView1];
        
        _dateTable = [UITableView new];
        _dateTable.delegate = self;
        _dateTable.separatorStyle = UITableViewScrollPositionNone;
        _dateTable.dataSource = self;
        _dateTable.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];;
        [_contentView addSubview:_dateTable];
        
        _timeTable = [UITableView new];
        _timeTable.separatorStyle = UITableViewScrollPositionNone;
        _timeTable.delegate = self;
        _timeTable.dataSource = self;
        _timeTable.backgroundColor = UIColor.whiteColor;
        [_contentView addSubview:_timeTable];
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.equalTo(@(8*50));
            make.top.equalTo(self.mas_bottom);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.equalTo(_contentView);
            make.height.equalTo(@50);
        }];
        
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.top.equalTo(_contentView);
            make.width.height.equalTo(@50);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(_contentView);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.height.equalTo(@0.5);
        }];
        [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView.mas_bottom);
            make.bottom.equalTo(_contentView);
            make.centerX.equalTo(_contentView.mas_centerX).offset(-50);
            make.width.equalTo(@0.5);
        }];
        [_dateTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.equalTo(_contentView);
            make.top.equalTo(_lineView.mas_bottom);
            make.trailing.equalTo(_lineView1.mas_leading);
        }];
        [_timeTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.bottom.equalTo(_contentView);
            make.top.equalTo(_lineView.mas_bottom);
            make.leading.equalTo(_lineView1.mas_trailing);
        }];
        
    }
    return self;
}

- (void)setCurrentDate:(NSString *)currentDate {
    _currentDate = currentDate;
    for (int i = 0 ; i<_dates.count; i++) {
        if ([currentDate isEqualToString:_dates[i]]) {
            _currentDate0 = _dates0[i];
        }
    }
}



- (void)showWithBlock:(LxmYuYueTimeAlertBlock)block {
    _block = block;
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview);
    }];
    [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
    
    
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.height.equalTo(@(8*50));
        make.top.equalTo(self.mas_bottom).offset(-8*50);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self layoutIfNeeded];
    }];
}

- (void)closeClick {
    
    if (!_currentDate.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请选择预约日期!"];
        return;
    }
    if (!_currentTime.isValid) {
           [SVProgressHUD showErrorWithStatus:@"请选择预约上门时间段!"];
           return;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:_currentDate0];
    NSArray *timeArr = [_currentTime componentsSeparatedByString:@"-"];
    NSString *startTime = [NSString stringWithFormat:@"%@ %@",str, timeArr.firstObject];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *startDate = [formatter1 dateFromString:startTime];
    NSInteger stratInterval = [[NSNumber numberWithDouble:[startDate timeIntervalSince1970]] integerValue];
    NSInteger endInterval = stratInterval + 60*60;
    
    NSInteger currentInterval = [[NSNumber numberWithDouble:[NSDate.date timeIntervalSince1970]] integerValue];
    if (currentInterval > endInterval) {
        [SVProgressHUD showErrorWithStatus:@"预约时间需大于当前时间!"];
        return;
    }
    if (_block) {
        _block(stratInterval, endInterval,[NSString stringWithFormat:@"%@ %@",_currentDate,_currentTime]);
    }
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.height.equalTo(@(8*50));
        make.top.equalTo(self.mas_bottom);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _dateTable) {
        return _dates.count;
    } else {
        return _times.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        if (tableView == _timeTable) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 8)];
            imgView.image = [UIImage imageNamed:@"time_select_y"];
            cell.accessoryView = imgView;
        }
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (tableView == _dateTable) {
        cell.textLabel.text = _dates[indexPath.row];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.textColor = [_currentDate isEqualToString:cell.textLabel.text] ? RedColor : UIColor.darkGrayColor;
        cell.backgroundColor = [_currentDate isEqualToString:cell.textLabel.text] ? UIColor.whiteColor : _lineView1.backgroundColor;
    } else {
        cell.textLabel.text = _times[indexPath.row];
        cell.textLabel.textColor = [_currentTime isEqualToString:cell.textLabel.text] ? RedColor : UIColor.darkGrayColor;
        cell.backgroundColor = UIColor.whiteColor;
        UIImageView *view = (UIImageView *)cell.accessoryView;
        view.hidden = ![_currentTime isEqualToString:cell.textLabel.text];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _dateTable) {
        _currentDate = _dates[indexPath.row];
        _currentDate0 = _dates0[indexPath.row];
    } else {
        _currentTime = _times[indexPath.row];
    }
    [tableView reloadData];
}

@end
