//
//  LxmUserInfoModel.h
//  vision time
//
//  Created by 李晓满 on 2019/12/12.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LxmGuJiaModel.h"

@interface LxmUserInfoModel : NSObject<NSCoding>


@property (nonatomic, strong) NSString *user_type;/**1-卖家 2-买家*/
@property (nonatomic, strong) NSString *balance;/**余额*/

@property (nonatomic, strong) NSString *sex;/**性别*/

@property (nonatomic, strong) NSString *head_pic;/**头像*/

@property (nonatomic, strong) NSString *telephone;/**手机号*/
@property (nonatomic , strong) NSString *tel;//手机号
@property (nonatomic, strong) NSString *username;/**用户名*/



@property (nonatomic, strong) NSString *status;/**1*/

@property (nonatomic, strong) NSString *real_status;/**1-未实名 2-已实名 3-待审核*/

@property (nonatomic, strong) NSString *imPass;
@property (nonatomic, strong) NSString *imCode;
@property (nonatomic, strong) NSString *im_code;
@property (nonatomic, strong) NSString *im_pass;

@property (nonatomic, strong) NSString *pay_order;
@property (nonatomic, strong) NSString *send_order;
@property (nonatomic, strong) NSString *followShopNum;//已关注店铺数量
@property (nonatomic, strong) NSString *couponNum;//未使用优惠券数量
@property (nonatomic, strong) NSString *get_order;
@property (nonatomic, strong) NSString *apply_order;
@property (nonatomic, strong) NSString *comment_order;

@property (nonatomic , strong) NSString *userType;//1：企业用户，2：个人用户
//@property (nonatomic , strong) NSString *userHead;//昵称

@property (nonatomic, strong) NSString *cashRate;
@property (nonatomic, strong) NSString *limitMoney;


@end

@interface LxmBaseModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) NSString *result;/**结果*/

@end


/**
 物流详情
 */
@interface LxmWuLiuInfoListModel : NSObject

@property (nonatomic, strong) NSString *create_time;/**时间*/

@property (nonatomic, strong) NSString *context;/**描述*/

@property (nonatomic, strong) NSString *year;/** 年 */

@property (nonatomic, strong) NSString *diff;/** 时间 */

@property (nonatomic, strong) NSString *day;/** 月日 */

@property (nonatomic, strong) NSString *time;/** 时间 */

@property (nonatomic, assign) CGFloat detailH;

@property (nonatomic, assign) CGFloat cellH;

@end

@interface LxmWuLiuInfoStateModel : NSObject

@property (nonatomic, strong) NSString *title;/** 标题 */

@property (nonatomic, strong) NSArray  <LxmWuLiuInfoListModel *>*list;/* 订单列表 */

@end

@interface LxmWuLiuInfoMapModel : NSObject

@property (nonatomic, strong) NSString *orderCode;/**订单号*/

@property (nonatomic, strong) NSString *company;/**物流公司*/

@property (nonatomic, strong) NSString *status;/**1：待支付，2：待发货，3：待确认收货,4:待补货，5：已完成，6：已取消*/

@end

@interface LxmWuLiuInfoResultModel : NSObject

@property (nonatomic, strong) NSArray  <LxmWuLiuInfoStateModel *>*list;/* 物流列表 */

@property (nonatomic, strong) LxmWuLiuInfoMapModel *map;/* 订单信息 */

@end


@interface LxmWuLiuInfoRootModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) LxmWuLiuInfoResultModel *result;/**结果*/

@end


@interface LxmOrderModel : NSObject

@property (nonatomic, strong) NSString *main_pic;/**商品图片*/

@property (nonatomic, strong) NSString *create_time;/**订单创建时间*/

@property (nonatomic, strong) NSString *id;/**订单号*/

@property (nonatomic, strong) NSString *type;/**1-上门订单 2-快递订单*/

@property (nonatomic, strong) NSString *good_name;/**商品名称*/

@property (nonatomic, strong) NSString *door_status;/**上门订单状态*/

@property (nonatomic, strong) NSString *post_status;/**快递订单状态*/

@property (nonatomic, strong) NSString *about_price;/**估价*/

@end


@interface LxmOrderListModel : NSObject

@property (nonatomic, strong) NSString *allPageNumber;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) NSArray  <LxmOrderModel *>*list;/* 物流列表 */

@end


@interface LxmOrderRootModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) LxmOrderListModel *result;/**结果*/

@end


@interface LxmOrderNumModel : NSObject

@property (nonatomic, strong) NSString *send;/**待抢单*/

@property (nonatomic, strong) NSString *back;/**待发货*/

@property (nonatomic, strong) NSString *deal;/**待处理*/

@property (nonatomic, strong) NSString *finish;/**已完成*/

@property (nonatomic, strong) NSString *canel;/**已取消*/

@end

@interface LxmOrderNumMapModel : NSObject

@property (nonatomic, strong) LxmOrderNumModel *map;/**结果*/

@end


@interface LxmOrderNumRootModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) LxmOrderNumMapModel *result;/**结果*/

@end

//订单详情
@interface LxmOrderDetailModel : NSObject

@property (nonatomic, strong) NSString *main_pic;/**待处理*/

@property (nonatomic, strong) NSString *city;/**城市*/

@property (nonatomic, strong) NSString *meet_end_time;/**预约结束时间*/

@property (nonatomic, strong) NSString *good_id;/**商品id*/

@property (nonatomic, strong) NSString *type;/**1, 1-上门 2-快递*/

@property (nonatomic, strong) NSString *content;/**情况*/

@property (nonatomic, strong) NSArray <LxmGujiaChoicesDataModel *>*chooseArr;//可选择数组

@property (nonatomic, strong) NSString *shop_user_id;/**商家用户id*/

@property (nonatomic, strong) NSString *address_detail;/**详细地址*/

@property (nonatomic, strong) NSString *update_time;/**完成时间*/

@property (nonatomic, strong) NSString *province;/**省份*/

@property (nonatomic, strong) NSString *district;/**区*/

@property (nonatomic, strong) NSString *id;/**订单id*/

@property (nonatomic, strong) NSString *low_price;/**最低价*/

@property (nonatomic, strong) NSString *link_name;/**联系人姓名*/

@property (nonatomic, strong) NSString *good_name;/**商品名*/

@property (nonatomic, strong) NSString *create_time;/***/

@property (nonatomic, strong) NSString *link_tel;/**联系电话*/

@property (nonatomic, strong) NSString *pay_pic;/**支付凭证*/

@property (nonatomic, strong) NSString *high_price;/**最高价*/

@property (nonatomic, strong) NSString *order_code;/**订单号*/

@property (nonatomic, strong) NSString *shop_about_price;/**商家报价*/

//@property (nonatomic, strong) NSString *create_time;/**下单时间*/

@property (nonatomic, strong) NSString *user_id;/**用户id*/

@property (nonatomic, strong) NSString *meet_start_time;/**预约开始时间*/

@property (nonatomic, strong) NSString *meet_date;/**预约时间*/

@property (nonatomic, strong) NSString *about_price;/**系统报价*/

@property (nonatomic, strong) NSString *door_status;/**上门订单状态*/

@property (nonatomic, strong) NSString *post_status;/**快递订单状态*/

@property (nonatomic, strong) NSString *status_value;/** 顶部显示*/

@property (nonatomic, strong) NSString *status_reason;/** 顶部显示说明*/

@property (nonatomic, strong) NSArray *ready;/** 准备说明*/

@property (nonatomic, strong) NSString *check_pic;/** 检测报告*/

@property (nonatomic, strong) NSString *shop_username;/** 商家姓名*/

@property (nonatomic, strong) NSString *shop_tel;/** 商家电话 */

@property (nonatomic, strong) NSString *shop_province;/** 商家地址-省 */

@property (nonatomic, strong) NSString *shop_city;/** 商家地址-市 */

@property (nonatomic, strong) NSString *shop_district;/** 商家地址-区 */

@property (nonatomic, strong) NSString *shop_address;/** 商家详细地址 */

@property (nonatomic, strong) NSString *deli_time;

@property (nonatomic, strong) NSString *shop_im_code;//环信聊天

@property (nonatomic, strong) NSString *shop_head_pic;//环信聊天

@end


@interface LxmOrderDetailMapModel : NSObject

@property (nonatomic, strong) LxmOrderDetailModel *map;/**结果*/

@end


@interface LxmOrderDetailRootModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) LxmOrderDetailMapModel *result;/**结果*/

@end

//提现明细列表
@interface LxmTiXianModel : NSObject

@property (nonatomic, strong) NSString *update_time;/**提现时间*/

@property (nonatomic, strong) NSString *money;/**提现金额*/

@property (nonatomic, strong) NSString *id;/**提现时间*/

@property (nonatomic, strong) NSString *type;/**1-ali 2-wx 3-bank*/

@property (nonatomic, strong) NSString *status;/**1-待审核 2-通过 3-拒绝*/

@end

@interface LxmTiXianListModel : NSObject

@property (nonatomic, strong) NSString *allPageNumber;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) NSArray  <LxmTiXianModel *>*list;/* 物流列表 */

@end

@interface LxmTiXianRootModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) LxmTiXianListModel *result;/**结果*/

@end

//提现明细详情


@interface LxmTiXianDetailModel : NSObject

@property (nonatomic, strong) NSString *order_code;/**单号*/

@property (nonatomic, strong) NSString *money;/**提现金额*/
@property (nonatomic, strong) NSString *shop_about_price;

@property (nonatomic, strong) NSString *create_time;/**申请时间*/

@property (nonatomic, strong) NSString *update_time;/**到账时间*/

@property (nonatomic, strong) NSString *user_id;/***/

@property (nonatomic, strong) NSString *account_code;/**账号*/

@property (nonatomic, strong) NSString *id;/***/

@property (nonatomic, strong) NSString *type;/**1-ali 2-wx 3-bank*/

@property (nonatomic, strong) NSString *status;/**1-待审核 2-通过 3-拒绝*/
@property (nonatomic, strong) NSString *shop_head_pic;
@property (nonatomic, strong) NSString *realname;/**1-待审核 2-通过 3-拒绝*/
@property (nonatomic, strong) NSString *bank_name;
@end

@interface LxmTiXianDetailMapModel : NSObject

@property (nonatomic, strong) LxmTiXianDetailModel *map;

@end


/**
 选择银行
 */
@interface LTSCSelcetBankModel : NSObject

@property (nonatomic, strong) NSString *bank;

@property (nonatomic, assign) BOOL isSelect;

@end

//已关注店铺
@interface LTSCFollowShopModel : NSObject

@property (nonatomic , strong) NSString *shopId;//店铺id

@property (nonatomic , strong) NSString *shop_name;//店铺名

@property (nonatomic , strong) NSString *shop_pic;//店铺头像

@property (nonatomic , strong) NSString *goodNum;//上新数量

@property (nonatomic , strong) NSString *id;//关注id

@end

@interface LTSCFollowShopListModel : NSObject

@property (nonatomic, strong) NSArray <LTSCFollowShopModel *>*list;

@property (nonatomic, strong) NSString *allPageNumber;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) NSString *data;

@end

@interface LTSCFollowShopRootModel : NSObject

@property (nonatomic, strong) NSNumber *key;//

@property (nonatomic, strong) NSString *message;//

@property (nonatomic, strong) LTSCFollowShopListModel *result;//

@end

@interface LTSCCommenttuPianModel : NSObject

@property (nonatomic , strong) NSString *path;//图片路径

@property (nonatomic , strong) NSString *width;

@property (nonatomic , strong) NSString *height;

@end


@interface LxmTiXianDetailRootModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) LxmTiXianDetailMapModel *result;/**结果*/

@end
