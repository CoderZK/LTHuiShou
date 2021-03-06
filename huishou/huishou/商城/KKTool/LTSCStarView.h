//
//  LTSCStarView.h
//  DefineStarSelected
//
//  Created by 李晓满 on 15/11/13.
//  Copyright © 2015年 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LTSCStarViewDelegate;

@interface LTSCStarView : UIView

-(instancetype)initWithFrame:(CGRect)frame withSpace:(CGFloat)space;

@property(nonatomic,assign)NSUInteger starNum;

@property (nonatomic , assign) id <LTSCStarViewDelegate> delegate;

@end

@protocol LTSCStarViewDelegate <NSObject>

@optional

- (void)LTSCStarView:(LTSCStarView *)stratView didClickStar:(NSInteger )star;

@end
