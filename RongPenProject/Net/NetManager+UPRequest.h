//
//  NetManager+UPRequest.h
//  jiyouhui2020
//
//  Created by zanghui  on 2020/7/30.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "NetManager.h"



@interface NetManager (UPRequest)


#pragma mark - 智能笔接口数据
#pragma mark - 登录 获取验证码

/**
 用户登录
 
 @param mobile 手机号
 @param yan 验证码
**/
- (void)login_indexWithMobile:(NSString *)mobile Yan:(NSString *)yan;

/**
 获取验证码
 login_send
 @param mobile 手机号
 @param action 行为 非找回密码为空即可，否则传值为:findpwd
 **/
- (void)login_sendWithMobile:(NSString *)mobile Action:(NSString *)action;

/**
密码登录
login_pwdlogin
@param mobile 手机号
@param password 密码
**/
- (void)login_pwdloginWithMobile:(NSString *)mobile Password:(NSString *)password;

/**
设置年级
login_setgread
@param uid 会员id
@param grade 年级 1.一年级 2.二年级 3.三年级 4.四年级 5.五年级 6.六年级 7.初一 8.初二 9.初三 10.高一 11.高二 12.高三
**/
- (void)login_setgreadWithUid:(NSString *)uid Grade:(NSString *)grade;

/**
 忘记密码-验证码校验
 login_repwdjy
 @param mobile 手机号
 @param yan 验证码
 **/
- (void)login_repwdjyWithMobile:(NSString *)mobile Yan:(NSString *)yan;

/**
 忘记密码
 login_repwddo
 @param uid 忘记密码-验证码校验接口返回的uid
 @param newpwd 新的密码
 **/
- (void)login_repwddoWithUid:(NSString *)uid Newpwd:(NSString *)newpwd;

/**
 会员信息更新
 login_renewing
 @param uid 会员uid 登录成功后返回的uid
 **/
- (void)login_renewingWithUid:(NSString *)uid;


/// 编辑会员信息
/// @param uid 用户id
/// @param avatar 头像
/// @param nickname 昵称
/// @param grade 班级
/// @param age 年龄
/// @param sex 性别
- (void)member_usereditWithUid:(NSString *)uid Avatar:(NSString *)avatar NicName:(NSString *)nickname Grade:(NSString *)grade Age:(NSString *)age andSex:(NSString *)sex;

/*问题反馈 member_feedback
 参数：
 uid 会员uid
 mobile 联系电话
 weixin 微信号码
 type 反馈类型：遇到问题、提出建议
 image 问题截图
 content 问题描述
 */
- (void)member_feedbackWithUid:(NSString *)uid Mobile:(NSString *)mobile Weixin:(NSString *)weixin Type:(NSString *)type Image:(NSString *)image Content:(NSString *)content;
/// 编辑会员头像
/// @param uid 用户id
/// @param avatar 头像
/// @param nickname 昵称
/// @param grade 班级
/// @param age 年龄
/// @param sex 性别
- (void)member_userHeaderEditWithUid:(NSString *)uid Avatar:(NSData *)avatar NicName:(NSString *)nickname Grade:(NSString *)grade Age:(NSString *)age andSex:(NSString *)sex;



/*关于我们 member_about
参数：
*/
- (void)member_aboutWithNoParam;

/**
 获取地区
 main_area
 **/
- (void)main_areaWithNoParam;
    
#pragma mark - 用户账号 account


#pragma mark - 首页
/// 获取轮播图
- (void)main_banner;

/// 获取教辅列表
/// @param uid 用户id
- (void)getMain_buybookWithUid:(NSString *)uid;


/// 获取教辅详情页
/// @param uid 用户id
/// @param bookid 教辅id
- (void)getMain_jfinfoWithUid:(NSString *)uid Unitid:(NSString *)unitid andBookId:(NSString *)bookid;

#pragma mark - 点读


/// 获取单元音频
/// @param unitid 单元id
/// @param bookid 教辅id
- (void)main_downMP3urlWithUnitid:(NSString *)unitid andBookId:(NSString *)bookid;


/// 目录
/// @param bookid 教辅id
/// @param unitid 单元id
/// @param zspage 页码

- (void)main_assessWithUnitid:(NSString *)unitid BookId:(NSString *)bookid andZspage:(NSString *)zspage;

#pragma mark - 闯关听写



/// 切换教材
/// @param uid 用户id
- (void)Pass_indexbookWithUid:(NSString *)uid;

/// 闯关提交结果
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
/// @param gqid 关卡id
- (void)Pass_txresultWithUid:(NSString *)uid andBookId:(NSString *)bookid Unitid:(NSString *)unitid andGqid:(NSString *)gqid;

/// 获取闯关听写-单元列表
/// @param uid 用户id
/// @param bookid 教辅id
- (void)Pass_txWithUid:(NSString *)uid andBookId:(NSString *)bookid;

/// 闯关听写-关卡列表
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
- (void)Pass_gqlistWithUid:(NSString *)uid andBookId:(NSString *)bookid andUnitid:(NSString *)unitid;


/// 闯关听写-关卡详情
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
/// @param gqid 关卡id
- (void)Pass_gqinfoWithUid:(NSString *)uid andBookId:(NSString *)bookid Unitid:(NSString *)unitid andGqid:(NSString *)gqid;

#pragma mark - 闯关中英互译

/// 获取闯关中英互译-单元列表
/// @param uid 用户id
/// @param bookid 教辅id
- (void)Pass_cntoenWithUid:(NSString *)uid andBookId:(NSString *)bookid;

/// 闯关中英互译-关卡列表
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
- (void)Pass_cntoenlistWithUid:(NSString *)uid andBookId:(NSString *)bookid andUnitid:(NSString *)unitid;


/// 闯关中英互译-关卡详情
/// @param uid 用户id
/// @param bookid 教辅id
/// @param unitid 单元id
/// @param gqid 关卡id
- (void)Pass_cntoeninfoWithUid:(NSString *)uid andBookId:(NSString *)bookid Unitid:(NSString *)unitid andGqid:(NSString *)gqid;



#pragma mark - 我的

/**
 我的课程(录播课程、直播课程) 参数 Course_index
 参数：
 page 分页 默认1
 type 录播、直播
 **/
- (void)Course_indexWithPage:(NSString *)page Type:(NSString *)type;

/**
 已购课程 参数
 参数：
 uid 当前会员id
 page 分页 默认1
 **/
- (void)Course_orderlistWithPage:(NSString *)page Uid:(NSString *)uid;

/**
 立即购买 参数
 参数：
 uid 会员id
 id 课程id
 type 类型 列表中返回的值 录播、直播
 **/
- (void)Course_buyWithType:(NSString *)type Uid:(NSString *)uid  Id:(NSString *)id;
/**
 播放课程（适用于录播课程,【直播课程请直接跳H5 请使用 已购课程 返回的 livelink】） 参数
 参数：
 goodsid 课程id 已购课程返回的
 uid 会员id
 ordersn 订单号
 type 类型 录播
 **/
- (void)Course_autoplayWithGoodsid:(NSString *)goodsid Uid:(NSString *)uid Ordersn:(NSString *)ordersn Type:(NSString *)type;

/**
 课程详情 参数
 参数：
 id 课程id
 type 类型 列表中返回的值 录播、直播
 **/
- (void)Course_infoWithId:(NSString *)id Type:(NSString *)type;

/**
 课程确认订单 参数
 参数：
 uid 当前会员id
 id 立即购买 返回的订单id
 ordersn 订单号
 **/
- (void)Course_qrorderWithId:(NSString *)id Uid:(NSString *)uid Ordersn:(NSString *)ordersn;

/// 我的消息
/// @param uid 用户id
- (void)Message_indexWithUid:(NSString *)uid;


/// 消息详情
/// @param uid 用户id
/// @param type type 类型 1.购买消息 2.上课提醒 3.系统消息
- (void)Message_infoWithUid:(NSString *)uid andType:(NSString *)type;

#pragma mark - 商城

/**
 商城
 Shop_index
 **/
- (void)Shop_indexWithNoParam;

/**
 商品详情
 id 商品的id
 type 我的商城 接口返回的type 商品、教辅、练习册
 Shop_info
 **/
- (void)Shop_infoWithId:(NSString *)id Type:(NSString *)type;

/**
 立即购买-确定 Shop_buy
 uid 当前会员id
 total 商品总价格
 goods 商品列表
 **/
- (void)Shop_buyWithUid:(NSString *)uid Total:(NSString *)total Goods:(NSArray *)goods;

/**
 Shop_nums
 编辑数量 参数
 参数：
 orderid 订单id
 fid 订单附加表id 确认订单 返回的fid
 num 数量 (传总数)
 **/
- (void)Shop_numsWithOrderid:(NSString *)orderid Fid:(NSString *)fid Num:(NSString *)num;

/**
 确认订单 Shop_qrorder
 uid 当前会员id
 id 立即购买-确定 返回的订单id
 ordersn 订单号
 **/
- (void)Shop_qrorderWithUid:(NSString *)uid Id:(NSString *)id  Ordersn:(NSString *)ordersn;

/**
 地址添加 Member_addresstj
 uid 当前会员id
 name 姓名
 mobile 手机号
 sheng 省份id
 shi 市id
 qu 区id
 address 详细地址
 defaults 不为空则为默认
 **/
- (void)Member_addresstjWithUid:(NSString *)uid Name:(NSString *)name  Mobile:(NSString *)mobile  Sheng:(NSString *)sheng  Shi:(NSString *)shi  Qu:(NSString *)qu  Address:(NSString *)address  Defaults:(NSString *)defaults;

/**
 Member_addresseditdo
 地址编辑执行 参数
 参数：
 uid 当前会员id
 id 地址id
 name 姓名
 mobile 手机号
 sheng 省份id
 shi 市id
 qu 区id
 address 详细地址
 defaults 不为空则为默认
 **/
- (void)Member_addresseditdoWithUid:(NSString *)uid Id:(NSString *)id Name:(NSString *)name  Mobile:(NSString *)mobile  Sheng:(NSString *)sheng  Shi:(NSString *)shi  Qu:(NSString *)qu  Address:(NSString *)address  Defaults:(NSString *)defaults;
/**
 地址列表 Member_address
 参数：
 uid 当前会员id
 **/
- (void)Member_addressWithUid:(NSString *)uid;

/**
 地址编辑 参数
 参数：
 uid 当前会员id
 id 地址id
 **/
- (void)Member_addresseditWithUid:(NSString *)uid Id:(NSString *)id;


/**
 设置收货地址 参数
 参数：
 uid 当前会员id
 orderid 确认订单 返回的orderid
 addressid 地址id
 **/
- (void)Shop_xzaddressWithUid:(NSString *)uid Orderid:(NSString *)orderid Addressid:(NSString *)addressid;

/**
 参数Course_settime
 设置上课时间（直播课程确认订单页面）有修改 参数
 参数：
 uid 当前会员id
 orderid 确认订单 返回的orderid
 time 时间 确认订单接口 中的 Timelist 中的id
 **/
- (void)Course_settimeWithUid:(NSString *)uid Id:(NSString *)id Time:(NSString *)time;

/**
 地址删除 参数
 参数：
 uid 当前会员id
 id 地址id
 **/
- (void)Member_addressdelWithUid:(NSString *)uid Id:(NSString *)id;

/**
 设置默认 参数
 参数：
 uid 当前会员id
 id 地址id
 **/
- (void)Member_setdefaultWithUid:(NSString *)uid Id:(NSString *)id;
/**
 我的订单Order_index
 参数：
 uid 会员id
 page 分页 默认1
 type 1.我的课程 2.我的商城
 **/
- (void)Order_indexWithUid:(NSString *)uid page:(NSString *)page type:(NSString *)type;

/**
 参数 Order_info
 查看订单 参数
 参数：
 uid 会员id
 orderid 订单id
 ordersn 订单号
 **/
- (void)Order_infoWithUid:(NSString *)uid orderid:(NSString *)orderid  ordersn:(NSString *)ordersn;


/**
 申请退款 参数
 参数：
 uid 会员id
 orderid 订单id
 yunyin 原因 1.时间长没有发货 2.产品购买重复 3.产品破损 4.其他原因
 pic 截图
 mobile 手机号
 **/
- (void)Order_refundWithUid:(NSString *)uid orderid:(NSString *)orderid yunyin:(NSString *)yunyin mobile:(NSString *)mobile pic:(NSArray *)pic;

/**
 确认收货 参数
 参数：
 uid 会员id
 orderid 订单id
 **/
- (void)Order_confirmWithUid:(NSString *)uid orderid:(NSString *)orderid;
/**
收货地址(退款专用)
 **/
- (void)Order_tuiaddressWithNoParam;

/**
快递公司
 **/
- (void)Order_kdcompanyWithNoParam;

/**
 提交快递单号 参数
 参数：
 uid 会员id
 orderid 订单id
 tkorderid 退款订单id 我的订单返回的
 companyid 快递公司id
 kdorder 快递单号
 pic 凭证照片
 **/
- (void)Order_submitorderWithUid:(NSString *)uid orderid:(NSString *)orderid tkorderid:(NSString *)tkorderid companyid:(NSString *)companyid kdorder:(NSString *)kdorder;

/**
 查看物流 参数
 参数：
 wlordersn 物流单号
 ordersn 订单号
 **/
- (void)Order_logisticsWithWlordersn:(NSString *)wlordersn rdersn:(NSString *)ordersn;
/**
 参数
 取消订单新增 参数Order_cancel
 参数：
 uid 会员id
 orderid 订单id
 **/
- (void)Order_cancelWithUid:(NSString *)uid orderid:(NSString *)orderid;

/**
 支付（通用） 参数
 参数：
 uid 当前会员id
 ordersn 订单号
 **/
- (void)Pay_buyWithUid:(NSString *)uid Ordersn:(NSString *)ordersn;

/**
 参数Pay_zbpay
 支付（直播课程专用） 参数
 参数：
 uid 当前会员id
 ordersn 订单号
 **/
- (void)Pay_zbpayUid:(NSString *)uid Ordersn:(NSString *)ordersn;

@end

