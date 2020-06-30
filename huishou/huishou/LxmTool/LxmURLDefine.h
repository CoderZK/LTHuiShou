//
//  LxmURLDefine.h
//  shenbian
//
//  Created by 李晓满 on 2018/11/12.
//  Copyright © 2018年 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>
//https://www.czmakj.com/collect/API%E6%96%87%E6%A1%A3.html

#define ISLOGIN [LxmTool ShareTool].isLogin
#define TOKEN [LxmTool ShareTool].session_token

#define Base_URL @"https://huishou.zftgame.com/collect"

@interface LxmURLDefine : NSObject
/**
 发送验证码
 */
#define  sendCodeNew  Base_URL"/app/sendCode"
/**
 注册
 */
#define  app_register  Base_URL"/app/register"
/**
 登录
 */
#define  app_login  Base_URL"/app/login"
/**
 退出登录
 */
#define  app_logout  Base_URL"/app/logout"
/**
 app-忘记密码第一步
 */
#define  app_forgetPassword1  Base_URL"/app/forgetPassword1"
/**
 app-忘记密码
 */
#define  app_forgetPassword  Base_URL"/app/forgetPassword"
/**
 获取个人信息
 */
#define  app_user_get_userInfo  Base_URL"/app/user/get_userInfo"
/**
 修改昵称
 */
#define  app_user_username  Base_URL"/app/user/username"
/**
 修改性别
 */
#define  app_user_sex  Base_URL"/app/user/sex"
/**
 修改头像
 */
#define  modify_head_pic  Base_URL"/app/user/head_pic"
/**
 修改密码
 */
#define  app_user_updatePassword  Base_URL"/app/user/updatePassword"
/**
 修改手机号
 */
#define  app_user_updateTelephone  Base_URL"/app/user/updateTelephone"
/**
 实名认证
 */
#define  app_user_realname  Base_URL"/app/user/realname"
/**
 首页一级分类
 */
#define  first_type_list  Base_URL"/app/first_type_list"
/**
 根据一级分类获取二级分类
 */
#define  second_type_list  Base_URL"/app/second_type_list"
/**
 根据一级分类二级分类获取商品列表
 */
#define  good_listNew  Base_URL"/app/good_list"
/**
 app-首页数据
 */
#define  index_list  Base_URL"/app/index_list"
/**
 商品估价信息
 */
#define  good_detail  Base_URL"/app/good_detail"

/**
 用户提交订单
 */
#define  send_orderTwo  Base_URL"/app/user/send_order"
/**
 获取省列表
 */
#define  get_province  Base_URL"/app/user/get_province"
/**
 获取市列表
 */
#define  get_city  Base_URL"/app/user/get_city"

/**
 获取县列表
 */
#define  get_district  Base_URL"/app/user/get_district"

/**
 我的订单列表
 */
#define  my_order  Base_URL"/app/user/my_order"
/**
 用户-我的订单数
 */
#define  my_count_order  Base_URL"/app/user/my_count_order"
/**
 用户-订单详情
 */
#define  my_order_detail  Base_URL"/app/user/my_order_detail"
/**
 查询物流
 */
#define  way_detailNew  Base_URL"/app/user/way_detail"
/**
 修改订单状态
 */
#define  app_order_status  Base_URL"/app/user/app_order_status"
/**
 提现
 */
#define  normal_cash_out  Base_URL"/app/user/normal_cash_out"
/**
 明细列表
 */
#define  money_list  Base_URL"/app/user/money_list"
/**
 明细详情
 */
#define  money_detail  Base_URL"/app/user/money_detail"
/**
 第三方外链-跳转直接登录
 */
#define  get_linkNew  Base_URL"/app/user/get_link"
/**
 反馈
 */
#define  lxm_feedback  Base_URL"/app/user/feedback"

/**
 图片上传
 */
#define  fileUpload  Base_URL"/app/fileUpload"

/**
 上传token
 */
#define  umeng_id_up  Base_URL"/app/user/umeng_id_up"
/**
 获取准备信息
 */
#define  ready_info  Base_URL"/app/user/ready_info"

/**
 支付
 */
#define  rechargeNew  Base_URL"/app/user/recharge"
/**
 获取环信信息
 */
#define  get_huanxin  Base_URL"/app/user/get_huanxin"
/**
   支付宝支付
 */
#define  ali_payNew  Base_URL"/app/user/ali_pay"
/**
  问题详情
*/
#define  wei_pay_codeNew  Base_URL"/app/user/wei_pay_code"
/**
  问题详情
*/
#define  question_list  Base_URL"/app/question_list"
/**
  搜索
*/
#define  search_good_name  Base_URL"/app/search_good_name"

/**
  获取环信的信息
*/
#define  get_huanxin  Base_URL"/app/user/get_huanxin"
/**
  获取和我聊天人的消息的头像昵称等
*/
#define  get_user_im  Base_URL"/app/user/get_user_im"



/**
 获取图片地址
 */
+(NSString *)getPicImgWthPicStr:(NSString *)pic;

@end

