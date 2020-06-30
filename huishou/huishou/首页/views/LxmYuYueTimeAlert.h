//
//  LxmYuYueTimeAlert.h
//  huishou
//
//  Created by 李晓满 on 2020/3/28.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LxmYuYueTimeAlertBlock)(NSInteger startInterval, NSInteger endInterval,NSString *dataStr);

@interface LxmYuYueTimeAlert : UIControl

@property (nonatomic, strong) NSString *currentTime;
@property (nonatomic, strong) NSString *currentDate;

- (void)showWithBlock:(LxmYuYueTimeAlertBlock)block;

@end

