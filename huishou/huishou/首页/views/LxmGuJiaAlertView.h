//
//  LxmGuJiaAlertView.h
//  huishou
//
//  Created by 李晓满 on 2020/4/4.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LxmGuJiaAlertView : UIView

- (void)show;

- (void)dismiss;

@property (nonatomic, strong) LxmGuJiaReasonModel *model;

@end

