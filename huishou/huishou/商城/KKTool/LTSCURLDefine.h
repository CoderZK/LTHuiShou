//
//  LTSCURLDefine.h
//  shenbian
//
//  Created by 李晓满 on 2018/11/12.
//  Copyright © 2018年 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>


#define LTSCBase_URL @"https://huishou.zftgame.com/shopMetal"

//https://www.zmzt99.com/shopMetal
/**
 单张图片上传 或视频上传
 */
#define  Base_upload_img_URL  LTSCBase_URL"/app/seven_app_file_up"
/**
 多张图片上传
 */
#define  Base_upload_multi_img_URL  LTSCBase_URL"/app/multi_seven_app_file_up"


@interface LTSCURLDefine : NSObject

/**
 获取验证码
 1注册
 2忘记密码
 3绑定手机
 4换绑验证旧手机
 5换绑验新手机
 6修改密码"
 */
#define  app_identify LTSCBase_URL"/app/app_identify"
/**
 注册
 */
#define  n_user_submit LTSCBase_URL"/app/n_user_submit"
/**
 企业注册
 */
#define  c_user_submit LTSCBase_URL"/app/c_user_submit"
/**
 登录
 */
#define  login  LTSCBase_URL"/app/login"
/**
 找回密码
 */
#define  back_pass LTSCBase_URL"/app/back_pass"
/**
 首页
 */
#define s_index LTSCBase_URL"/app/s_index"
/**
 退出登录
 */
//#define  app_logout LTSCBase_URL"/app/user/app_logout"
/**
 修改密码
 */
#define  change_pass LTSCBase_URL"/app/user/change_pass"
/**
 修改收货地址
 */
#define add_up_address LTSCBase_URL"/app/user/add_up_address"

/**
 收货地址列表
 */
#define  address_list LTSCBase_URL"/app/user/address_list"
/**
 删除收货地址
 */
#define del_address LTSCBase_URL"/app/user/del_address"

/**
 第三方外链
 */
#define get_link LTSCBase_URL"/app/user/get_link"
/**
 优惠券列表
 */
#define app_index_couponList LTSCBase_URL"/app/app_index_couponList"
/**
 优惠券列表
 */
#define couponList LTSCBase_URL"/app/user/couponList"

/**
 店铺详情
 */
#define shopGoodMsg LTSCBase_URL"/app/shopGoodMsg"
/**
 猜你喜欢
 */
#define guessLike LTSCBase_URL"/app/guessLike"
/**
 逛逛更多
 */
#define goMoreGoods LTSCBase_URL"/app/goMoreGoods"
/**
 关注，取消关注店铺
 */
#define followShop LTSCBase_URL"/app/user/followShop"
/**
 店铺分类
 */
#define shopGoodTypeList LTSCBase_URL"/app/shopGoodTypeList"
/**
 首页搜索
 */
#define app_search LTSCBase_URL"/app/app_search"
/**
 商品列表
 */
#define good_list LTSCBase_URL"/app/good_list"
/**
 快速搜索商品-商品名称检索
 */
#define search_good LTSCBase_URL"/app/search_good"
/**
 商品详情
 */
#define good_detailNew LTSCBase_URL"/app/good_detail"
/**
 购物车列表
 */
#define cartList LTSCBase_URL"/app/user/cartList"
/**
 商品一级分类列表
 */
#define good_first_type_list LTSCBase_URL"/app/good_first_type_list"
/**
 商品二级分类列表
 */
#define good_second_type_list LTSCBase_URL"/app/good_second_type_list"
/**
 加入购物车/修改购物车
 */
#define add_cart LTSCBase_URL"/app/user/add_cart"

/**
 修改购物车
 */
#define up_cart LTSCBase_URL"/app/user/up_cart"
/**
 删除购物车
 */
#define del_cart LTSCBase_URL"/app/user/del_cart"
/**
 购物车结算下单
 */
#define settle_cart_order LTSCBase_URL"/app/user/settle_cart_order"
/**
 领取优惠券
 */
#define addCoupon LTSCBase_URL"/app/user/addCoupon"
/**
 立即购买下单
 */
#define settle_order LTSCBase_URL"/app/user/settle_order"
/**
 订单列表
 */
#define orderList LTSCBase_URL"/app/user/orderList"
/**
 已关注店铺
 */
#define followShopList LTSCBase_URL"/app/user/followShopList"
/**
 评价商品
 */
#define commentGood LTSCBase_URL"/app/user/commentGood"
/**
 申请退款
 */
#define apply_back LTSCBase_URL"/app/user/apply_back"
/**
 取消订单
 */
#define cancel_order LTSCBase_URL"/app/user/cancel_order"
/**
 删除订单
 */
#define del_order LTSCBase_URL"/app/user/del_order"
/**
 订单详情
 */
#define order_detail LTSCBase_URL"/app/user/order_detail"

/**
物流信息
 */
#define way_detail LTSCBase_URL"/app/user/way_detail"



/**
 我的信息
 */
#define my_info LTSCBase_URL"/app/user/my_info"
/**
 假的支付订单 ，直接付成功了
 */
#define pay_order1 LTSCBase_URL"/app/user/pay_order"

/**
 获取收货地址详情
 */
#define address_detailNew LTSCBase_URL"/app/user/address_detail"

/**
 修改信息
 */
#define up_base_info LTSCBase_URL"/app/user/up_base_info"
/**
 修改手机号第一步
 */
#define change_tel_one LTSCBase_URL"/app/user/change_tel_one"
/**
 修改手机号第二步
 */
#define change_tel_two LTSCBase_URL"/app/user/change_tel_two"

/**
 确认收货
 */
#define get_good LTSCBase_URL"/app/user/get_good"

/**
 严选爆款商品更多列表 1-严选，2-爆款
 */
#define reco_good_list LTSCBase_URL"/app/reco_good_list"
/**
 aq更多列表
 */
#define qa_list LTSCBase_URL"/app/qa_list"
/**
 退款理由
 */
#define reason_list LTSCBase_URL"/app/user/reason_list"
/**
 店铺好评
 */
#define shopStar LTSCBase_URL"/app/shopStar"
/**
 评价列表
 */
#define evalList LTSCBase_URL"/app/evalList"
/**
 评价列表
 */
//#define umeng_id_up LTSCBase_URL"/app/user/umeng_id_up"


/**
 支付
 */
#define  recharge  LTSCBase_URL"/app/user/rechargePay"

/**
 充值支付
 */
#define  rechargePayType  LTSCBase_URL"/app/user/rechargePayType"

/**
 充值支付
 */
#define  wei_pay_code  LTSCBase_URL"/app/user/wei_pay_code"

/**
 充值支付
 */
#define  ali_pay  LTSCBase_URL"/app/user/ali_pay"

/**
  获取环信的信息
*/
//#define  get_huanxin  LTSCBase_URL"/app/user/get_huanxin"
/**
  获取和我聊天人的消息的头像昵称等
*/
//#define  get_user_im  LTSCBase_URL"/app/user/get_user_im"


@end

