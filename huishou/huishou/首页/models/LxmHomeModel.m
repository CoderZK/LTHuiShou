//
//  LxmHomeModel.m
//  huishou
//
//  Created by 李晓满 on 2020/3/23.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import "LxmHomeModel.h"

@implementation LxmHomeModel

@end

//首页一级分类

@implementation LxmHomeFirstTypeModel

@end


@implementation LxmHomeFirstTypeListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : @"LxmHomeFirstTypeModel"};
}

@end


@implementation LxmHomeFirstTypeRootModel

@end

//app-首页数据

@implementation LxmHomeBannerModel

@end

@implementation LxmHomeGoodsModel

@end

@implementation LxmHomeThirdModel

@end

@implementation LxmHomeCategroyModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goods" : @"LxmHomeGoodsModel"};
}

@end

@implementation LxmHomeGoodMapModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"category_data" : @"LxmHomeCategroyModel",
        @"banner" : @"LxmHomeBannerModel",
        @"third" : @"LxmHomeThirdModel"
    };
}

@end

@implementation LxmHomeRootModel1 
- (CGFloat)cellheight {
    if (_cellheight == 0) {
        CGFloat titleH = [NSString getString:self.title lineSpacing:1 font:[UIFont systemFontOfSize:15] width:(ScreenW - 69)];
        CGFloat contetH = [NSString getString:self.content lineSpacing:1 font:[UIFont systemFontOfSize:11] width:(ScreenW - 69)];
        _cellheight = 15 + titleH + 3 + contetH + 15;
        
    }
    return _cellheight;
}



@end

@implementation LxmHomeRootModel

@end

//所有商品
@implementation LxmGoodsListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"list" : @"LxmHomeGoodsModel"
    };
}

@end
@implementation LxmGoodsListRootModel

@end

//第三方外链-跳转直接登录
@implementation LxmHomeThirdLoginModel

@end

@implementation LxmHomeThirdLoginRootModel 

@end
