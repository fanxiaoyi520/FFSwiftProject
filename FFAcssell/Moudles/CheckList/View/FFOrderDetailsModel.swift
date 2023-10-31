//
//  FFOrderDetailsModel.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/11.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import HandyJSON

class FFOrderDetailsModel: HandyJSON,Codable {
    
    var orderId: Int64?
    var billId: Int64?
    var orderStartTime: String?
    var orderEndTime: String?
    var tradeTime: String?
    var createTime: String?
    var printTime: String?
    var storeName: String?
    var customerName: String?
    var customerPhone: String?
    var carNum: String?
    var carClsStr: String?
    var userName: String?
    var organizationName: String?
    var address: String?
    var storePhone: String?
    var km: Int64?
    var payway: String?
    var remark: String?
    var invoiceTypeName: String?
    var actualAmount: Float?
    var productInfos : Array<ProductInfo>?
    var itemInfos : Array<ItemInfo>?
    
    required init() {}
}

//class ProductInfo: HandyJSON,Codable {
//
//    var stockId: Int64?
//    var productId: Int64?
//    var originCode: String?
//    var productName: String?
//    var model: String?
//    var inPrice: Int64?
//    var qty: Int64?
//    var unitName: String?
//    var price1: Float?
//    var price2: Float?
//    var discount: Int64?
//    var discountAmount: Int64?
//    var smallSum: Int64?
//    var rowKey: String?
//    var outPrice: Float?
//    var sn: String?
//    var welcomePerson: String?
//    var exePerson: String?
//    var canPayQty: Int64?
//    var cardNum: String?
//
//    required init() {}
//}
//
//class ItemInfo: HandyJSON,Codable {
//
//    var rowKey: String?
//    var itemId: Int64?
//    var itemName: String?
//    var outPrice: Int64?
//    var qty: Int64?
//    var taskHours: Int64?
//    var discount: Int64?
//    var discountAmount: Int64?
//    var smallSum: Int64?
//    var unitName: String?
//    var welcomePerson: String?
//    var exePerson: String?
//    var canPayQty: String?
//    var cardNum: String?
//
//    required init() {}
//}
