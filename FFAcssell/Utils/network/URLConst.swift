//
//  URLlet.swift
//  FFAcssell
//
//  Created by zhou on 2019/7/31.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import Foundation

let BaseUrl = "http://dev.baichuan.pro:5000"


// 登录
let Login = "/api/User/Login"

// 用户信息
let GetUserInfo = "/api/User/GetUserInfo"

// 登出
let logOut = "/api/User/Logout"

// 获取商品
let getStockOutList = "/api/stock/getStockOutList"

// 获取支付方式枚举--搜索车牌信息
let GetBaseTyoeList = "/api/BaseType/GetBaseTypeList"

// 获取验证码
let getCode = "/api/SMS/GetCode"

// 重置密码
let ResetPassword = "/api/User/ResetUserPassword"

// 获取订单列表mobile( 准备弃用)
let GetOrderListInMobile = "/api/orders/getOrdersList"
//"/api/Orders/List"

// 获取订单详情mobile
let getOrderListItemDetailMobile = "/api/Order/Detail"

// 校验验证码
let validateCode = "/api/SMS/ValidateCode"

// 商家注册
let phoneMerchantRegister = "/api/User/MerchantRegister"

// 版本更新
let versionUpdate = "/api/Versions/GetVersion"

// 获取订单列表
let GetDashboardList = "/api/Dashboard/GetDashboardList"

// 获取验证码
let GetCode = "/api/Verification/GetCode"

// 通过OrderId获取订单详情数据
let GetOrderDetailById = "/api/Orders/GetOrderDetailById"

// 获取商品列表
let GetStockInList = "/api/Stock/GetStockInList"

// 获取项目列表
let GetItemList = "/api/Item/GetItemList"

// 订单保存
let OrderSave = "/api/orders/orderSave"

// 保存客户
let CreateCustomers = "/api/customers/createCustomers"

// 订单注销
let OrderCancelById = "/api/Orders/OrderCancelById"

// 注册
let MerchantRegister = "/api/User/MerchantRegister"
