//
//  LxmLoginView.h
//  huishou
//
//  Created by 李晓满 on 2020/3/17.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LxmLoginView : UIView

@end

/// 输入view
@interface LxmPutinView : UIView

@property (nonatomic, strong) UITextField *putinTF;//输入

@property (nonatomic, strong) UIView *lineView;//线

@end


/// 选择view
@interface LxmPutinButtonView : UIButton

@property (nonatomic, strong) UILabel *selectLabel;//选择类型

@property (nonatomic, strong) UIView *lineView;//线

@end



@interface LxmAgreeButton : UIButton

@property (nonatomic, strong) UIButton *protocolButton;

@property (nonatomic, strong) UILabel *textLabel;
@property(nonatomic , strong)UIImageView *imgV;

@end
