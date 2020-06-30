//
//  LxmGuJiaModel.h
//  huishou
//
//  Created by 李晓满 on 2020/3/31.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LxmGuJiaModel : NSObject

@property (nonatomic, strong) NSString *main_pic;/**商品图*/

@property (nonatomic, strong) NSString *second_type_id;/**三级分类*/

@property (nonatomic, strong) NSString *third_type_id;/**二级分类*/

@property (nonatomic, strong) NSString *high_price;/**最高价*/

@property (nonatomic, strong) NSString *good_name;/**商品名称*/

@property (nonatomic, strong) NSString *low_price;/**最低价*/

@property (nonatomic, strong) NSString *first_type_id;/**一级分类*/

@property (nonatomic, strong) NSString *content;/**一级分类*/

@end


@interface LxmGuJiaReasonModel : NSObject

@property (nonatomic, strong) NSString *pics;/**图片*/

@property (nonatomic, strong) NSString *text;/**理由*/

@end


@interface LxmGuJiaChoicesModel : NSObject

@property (nonatomic, strong) NSString *choice;/**选项*/

@property (nonatomic, strong) NSString *price;/**价格*/

@property (nonatomic, strong) LxmGuJiaReasonModel *reason;/**理由*/

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat cellHeight0;

@end


@interface LxmGujiaChoicesDataModel : NSObject

@property (nonatomic, assign) BOOL isSelect;//改区域是否被选择

@property (nonatomic, strong) NSString *question;/**使用情况"*/

@property (nonatomic, strong) NSString *type;/**1-单选 2-多选*/

@property (nonatomic, strong) LxmGuJiaReasonModel *reason;

@property (nonatomic, strong) NSArray <LxmGuJiaChoicesModel *> *choices;

@end
