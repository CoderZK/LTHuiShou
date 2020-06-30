//
//  LxmHomeModel.h
//  huishou
//
//  Created by 李晓满 on 2020/3/23.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LxmHomeModel : NSObject

@end

//首页一级分类

@interface LxmHomeFirstTypeModel : NSObject

@property (nonatomic, strong) NSString *type_pic;//分类图片

@property (nonatomic, strong) NSString *category_name;//分类名称

@property (nonatomic, strong) NSString *id;//分类ID

@end


@interface LxmHomeFirstTypeListModel : NSObject

@property (nonatomic, strong) NSString *allPageNumber;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) NSArray  <LxmHomeFirstTypeModel *>*list;/*所有分类*/

@end


@interface LxmHomeFirstTypeRootModel : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) LxmHomeFirstTypeListModel *result;

@end

//app-首页数据

@interface LxmHomeBannerModel : NSObject

@property (nonatomic, strong) NSString *img_path;//banner图

@property (nonatomic, strong) NSString *link;//链接地址

@property (nonatomic, strong) NSString *info_type;
@property (nonatomic, strong) NSString *info_id;
@end

@interface LxmHomeGoodsModel : NSObject

@property (nonatomic, strong) NSString *main_pic;//商品图片

@property (nonatomic, strong) NSString *high_price;//最高回收价

@property (nonatomic, strong) NSString *good_name;//商品名称

@property (nonatomic, strong) NSString *id;//商品id

@end

@interface LxmHomeThirdModel : NSObject

@property (nonatomic, strong) NSString *img_path;//图片

@property (nonatomic, strong) NSString *link;//链接

@property (nonatomic, strong) NSString *title;//名称

@property (nonatomic, strong) NSString *type;//2-第三方链接 3-充值

@end


@interface LxmHomeCategroyModel : NSObject

@property (nonatomic, strong) NSString *type_pic;//一级分类图片

@property (nonatomic, strong) NSString *category_name;//一级分类名称

@property (nonatomic, strong) NSArray  <LxmHomeGoodsModel *>*goods;/*所有分类*/

@property (nonatomic, strong) NSString *id;//一级分类ID

@end

@interface LxmHomeGoodMapModel : NSObject

@property (nonatomic, strong) NSArray  <LxmHomeCategroyModel *>*category_data;/*所有分类及商品*/

@property (nonatomic, strong) NSArray  <LxmHomeThirdModel *>*third;/*其他类型*/

@property (nonatomic, strong) NSArray  <LxmHomeBannerModel *>*banner;/*banner图*/

@end



@interface LxmHomeRootModel1 : NSObject

@property (nonatomic, strong) NSString *allPageNumber;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) LxmHomeGoodMapModel *map;

@property (nonatomic, strong) NSString *data;

@property (nonatomic, strong) NSString *list;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) CGFloat cellheight;

@end

@interface LxmHomeRootModel : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) LxmHomeRootModel1 *result;

@end

//所有商品
@interface LxmGoodsListModel : NSObject

@property (nonatomic, strong) NSString *allPageNumber;//全部页数

@property (nonatomic, strong) NSString *count;//

@property (nonatomic, strong) NSArray  <LxmHomeGoodsModel *>*list;/*所有商品*/

@end
@interface LxmGoodsListRootModel : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) LxmGoodsListModel *result;

@end

//第三方外链-跳转直接登录
@interface LxmHomeThirdLoginModel : NSObject

@property (nonatomic, strong) NSString *data;

@end

@interface LxmHomeThirdLoginRootModel : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) LxmHomeThirdLoginModel *result;

@end
