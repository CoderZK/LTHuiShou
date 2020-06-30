//
//  LxmGuJiaModel.m
//  huishou
//
//  Created by 李晓满 on 2020/3/31.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmGuJiaModel.h"

@implementation LxmGuJiaModel

@end

@implementation LxmGuJiaReasonModel

@end


@implementation LxmGuJiaChoicesModel

@synthesize cellHeight = _cellHeight;
@synthesize cellHeight0 = _cellHeight0;

- (CGFloat)cellHeight {
    if (_cellHeight == 0) {
        _cellHeight = [self.choice getSizeWithMaxSize:CGSizeMake(ScreenW - 60, 9999) withFontSize:15].height + 31;
        _cellHeight = _cellHeight > 51 ? _cellHeight : 51;
    }
    return _cellHeight;
}

- (CGFloat)cellHeight0 {
    if (_cellHeight0 == 0) {
           _cellHeight0 = [self.choice getSizeWithMaxSize:CGSizeMake(ScreenW - 125, 9999) withFontSize:15].height + 31;
           _cellHeight0 = _cellHeight0 > 51 ? _cellHeight0 : 51;
       }
       return _cellHeight0;
}

@end


@implementation LxmGujiaChoicesDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"choices" : @"LxmGuJiaChoicesModel"};
}

@end
