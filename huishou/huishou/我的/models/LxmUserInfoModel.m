//
//  LxmUserInfoModel.m
//  vision time
//
//  Created by 李晓满 on 2019/12/12.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmUserInfoModel.h"

@implementation LxmUserInfoModel

MJCodingImplementation

@end

@implementation LxmBaseModel

@end


/**
 物流详情
 */
@implementation LxmWuLiuInfoListModel

@synthesize cellH = _cellH;
@synthesize detailH = _detailH;

- (CGFloat)detailH {
    if (_detailH == 0) {
        CGFloat h = [self.context getSizeWithMaxSize:CGSizeMake(ScreenW - 75, 9999) withFontSize:14].height;
        _detailH = 15 + 20 + 10 + h + 15;
    }
    return _detailH;
}

- (CGFloat)cellH {
    if (_cellH == 0) {
        if (self.context.isValid) {
            CGFloat h = [self.context getSizeWithMaxSize:CGSizeMake(ScreenW - 51, 9999) withFontSize:12].height;
            _cellH = 10 + h + 5 + 10 + 5;
        } else {
            _cellH = 7.5;
        }
    }
    return _cellH;
}

@end


/**
 选择银行
 */
@implementation LTSCSelcetBankModel

@end

@implementation LxmWuLiuInfoStateModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : @"LxmWuLiuInfoListModel"};
}




@end

@implementation LxmWuLiuInfoMapModel

@end

@implementation LxmWuLiuInfoResultModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : @"LxmWuLiuInfoStateModel"};
}

@end

@implementation LxmWuLiuInfoRootModel

@end


@implementation LxmOrderModel

@end


@implementation LxmOrderListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : @"LxmOrderModel"};
}

@end


@implementation LxmOrderRootModel

@end


@implementation LxmOrderNumModel

@end

@implementation LxmOrderNumMapModel 

@end


@implementation LxmOrderNumRootModel 

@end


//订单详情
@implementation LxmOrderDetailModel

- (NSArray<LxmGujiaChoicesDataModel *> *)chooseArr {
    if (_chooseArr.count == 0) {
        NSArray *chooseA = [self.content mj_JSONObject];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in chooseA) {
            LxmGujiaChoicesDataModel *model = [LxmGujiaChoicesDataModel mj_objectWithKeyValues:dict];
            [tempArr addObject:model];
        }
        _chooseArr = tempArr;
    }
    return _chooseArr;
}

@end


@implementation LxmOrderDetailMapModel

@end


@implementation LxmOrderDetailRootModel 

@end

//提现明细列表
@implementation LxmTiXianModel

@end

@implementation LxmTiXianListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : @"LxmTiXianModel"};
}

@end

@implementation LxmTiXianRootModel 

@end

//提现明细详情

@implementation LxmTiXianDetailModel

@end

@implementation LxmTiXianDetailMapModel

@end

@implementation LxmTiXianDetailRootModel 

@end

//已关注店铺
@implementation LTSCFollowShopModel

@end

@implementation LTSCFollowShopListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"list" : @"LTSCFollowShopModel"
             };
}

@end

@implementation LTSCFollowShopRootModel

@end


@implementation LTSCCommenttuPianModel


@end

