package com.king.fruits.core.util;

/**
 * 版权：融贯资讯 <br/>
 * 作者：yong.chen@rogrand.com <br/>
 * 生成日期：2013年11月6日 <br/>
 * 描述：调用服务接口后返回的操作码 和 信息
 */
public enum SysCode {
    // 成功代码：000000
    // 系统代码：200000
    // 业务逻辑代码：
    //      登录：100100
    //      注册：100200
    //      短信：100300
    //      商户：100400
    //      用户：100500
    //      服务：100600
    //      活动：100700
    //      对话：100800
    //      消息：100900
    //      订单：101000
    // 优惠券验证：101100
    
	SUCCESS("000000", "操作成功"),
	SYS_ERR("111111", "操作错误"),
	NO_ERR("222222", "系统未知错误"),
	
	USER_NOT_REGISTE("000001", "用户尚未注册"),
	USER_IS_REGISTE("000002", "用户已经注册"),
	USER_IS_ERR_REGISTE("000003", "用户注册失败"),
	USER_AND_PWD_ERROR("000005", "账户或密码错误"),
	USER_AND_OUT_ERROR("000011", "账户停止服务"),
	
	PWD_IS_ERROR("000006", "账号或密码错误"),
	PWD_IS_EXPIRED("000006", "临时密码已过期"),
	VILIPWD_IS_ERROR("000008", "验证码错误"),
	VILIPWD_IS_EXPIRED("000013","验证码已过期"),
	UP_PWD_IS_ERROR("000007", "修改密码失败"),
	PARAM_IS_ERROR("000004", "参数错误"),
	ATTION_IS_ERROR("000010", "用户关注商户失败"),
	EFFERCODE_IS_ERROR("000012", "推荐码不存在"),
	REVIEW_IS_ERROR("000009", "评论失败"),
	
	SMS_SEND_ERR("333333", "短信发送失败"),
	SMS_STOP_SEND_ERR("444444", "请输入000000通过验证"),
	
	UPLOAD_IS_ERR("200001", "上传证信息失败"),
	UPLOAD_MSG_IS_ERR("200001", "上传语音信息失败"),
	UPLOAD_IMG_IS_ERR("200002", "上传图片失败"),
	UPLOAD_FILE_IS_ERR("200003","上传文件失败"),
	
	MERCHANT_NOT_FOUND("100400", "商户信息不存在"),
	MERCHANT_DONT_LOGIN("100401", "总店商户不可以登录"),
	MERCHANT_NOT_REGISTE("100001", "商户尚未注册"),
	MERCHANT_IS_REGISTE("100002", "商户已经注册"),
	MERCHANT_IS_VILIDATE("100004", "商户正在审核中"),
	MERCHANT_ISNOT_VILIDATE("100004", "商户审核未通过"),
	MERCHANT_IS_QUERY_ERR("100006", "数据加载失败"),
	MERCHANT_IS_ERR_REGISTE("100003", "商户注册失败"),
	MERCHANT_IS_RESPONSED("100007", "您已在另一设备上响应过该服务"),
	MERCHANT_IS_ERR_RESPONSE("100005", "商户响应失败"),
	MERCHANT_ADDRESS_UPDATE ("1000013", "地址已经被其他人修改过了"),
	MERCHANT_IS_REVIEWED("100014", "您已在另一设备上评论过该服务"),
	
	MERCHANT_IS_FAVORITES("100501","商户已经被收藏"),
	MERCHANT_MODIFY_ERROR("100400", "修改商户信息失败"),
	
	SERVICE_NOT_FOUND("100600", "用户服务不存在"),
	SERVICE_ISNOT_BUY_MEDICINE("100601", "该服务不是买药服务"),
	SERVICE_IS_GRAB("100602", "已经有商户抢单"),
	SERVICE_IS_EXPIRED("100603", "订单超时啦，进入下一个订单吧!"),
	SERVICE_IS_DISTANCE("100604","超过商户配送范围"),
	SERVICE_IS_ACCEPT("100605","该服务已采纳过商户回复"),
	
	MEMBER_TEL_ISEXIST_M ("100020","总店存在相同会员电话"),
	MEMBER_TEL_ISEXIST ("100021","存在相同会员电话"),
	MEMBER_TEL_NOTEXIST("100022","会员电话不存在"),
	
	MEMBER_ADD_ERROR("100019","新增会员失败"),
	MEMBER_EDIT_ERROR("100020","编辑会员失败"),
	
	UPGRADE_SOURCE_NOTFOUND("300001", "原始账号不存在"),
	UPGRADE_SOURCE_IS_NOT_SINGLE("300002", "原始账号信息类型不是单体药房"),
	UPGRADE_SOURCE_EXIST_RECORD("300003", "原始账号已升级过"),
	UPGRADE_TARGET_EXIST("300004", "升级账号已存在"),
	UPGRADE_TARGET_EXIST_VERIFING("300005", "升级账号已存在，并正在审核"),
	UPGRADE_TARGET_ISNULL("300006", "升级信息为空"),
	UPGRADE_FAILURE("3000007", "账号升级失败"),
	
	NEED_LOGOUT("0", "需要注销用户"),
	NOT_LOGOUT("1", "无需注销用户"),
	
	ACTIVETY_IS_NULL("4000001", "活动不存在"),
	ACTIVETY_IS_EXPIRET("4000002", "活动已过期"),
	ACTIVETY_IS_NOTSTART("4000004", "活动还没有开始"),
	TEL_IS_ATT("4000003","您已报名，请勿重复提交 "),
	
	DIALOG_NOT_FOUND("100800", "消息对话未找到"),
	
	MESSAGE_SOURCE_TYPE_UNDEFINED("100900", "消息来源类型未定义"),
	
	ORDER_NOT_FOUND("101000", "订单信息未找到"),
	ORDER_HAS_CANCELED("101001", "该订单已取消"),
	ORDER_CAN_NOT_BE_CANCELED("101002", "该订单已无法取消"),
	
	/* 没用了
	COUPON_CHECK_SUCCESS("5000001","验证成功！"),
	COUPON_CHECK_ERROR("5000002","该二维码的优惠活动，本店不支持使用！"),
	COUPON_CHECK_ERROR_OVERDUE("5000003","验证失败！优惠券已经过期！"),
	COUPON_CHECK_ERROR_RECEIVED("5000004","验证失败！优惠券已经被验证！"),
	COUPON_CHECK_ERROR_DISABLE("5000005","验证失败，该优惠券已经被禁止使用！"),
	*/
	
	COUPON_VERIFY_CODE_IS_NULL("101101", "验证码不能为空"),
	COUPON_VERIFY_COUPON_INFO_NOT_FOUND("101102", "未找到对应的优惠券信息"),
	COUPON_VERIFY_RECEIVE_INFO_NOT_FOUND("101103", "未找到对应的优惠券领取信息"),
	COUPON_VERIFY_IS_NOT_MY_COUPON("101104", "该优惠活动，本店不支持使用！"),
	COUPON_VERIFY_COUPON_IS_DISABLED("101105", "该优惠券已被禁止使用"),
	COUPON_VERIFY_COUPON_NOT_BEGIN("101106", "该优惠券未到使用时间"),
	COUPON_VERIFY_COUPON_IS_OVERDUE("101107", "该优惠券活动已过期"),
	COUPON_VERIFY_COUPON_HAD_USED("101108", "该优惠券已被使用"),
	
	COUPON_RECEIVE_SUCCESS("000000","优惠券领取成功，可从“我的”进行查看！"),
	COUPON_RECEIVE_HAD_RECEIVED("5000006","您已经领取该优惠券"),
	COUPON_RECEIVE_IS_DISABLED("5000007","该优惠活动已停止"),
	COUPON_RECEIVE_IS_DELETE("5000008","该优惠活动已删除"),
	COUPON_RECEIVE_IS_OFFLINE("5000009","该优惠券活动已下线"),
	COUPON_RECEIVE_NOTIN_TIMERANGE("5000011", "当前不在优惠活动时间范围内"),
	COUPON_RECEIVE_NOTIN_SUITRANGE("5000012", "您不在优惠活动适用对象范围内"),
	
	//======================================1.0中有2.0没有的错误信息  start=========================
	MERCHANT_NOT_LOGIN("100012", "商户尚未登录"),
	
	
	//======================================1.0中有2.0没有的错误信息  end=========================
	;
	
	private SysCode(String code, String message) {
		this.code = code;
		this.message = message;
	}
	
	private String code;
	private String message;
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
}
