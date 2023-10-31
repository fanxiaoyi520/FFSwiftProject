//
//  FFCheckListModel.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/11.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import HandyJSON


class FFCheckListModel: HandyJSON,Codable {
    var page: Int64?
    var pageSize: Int64?
    var total: Int64?
    var items: Array<Item>?

    required init() {}
}

class Item: HandyJSON,Codable {
    
    var orderId: Int64?
    var organizationId: Int64?
    var storeName: String?
    var customerName: String?
    var phone: String?
    var carNum: String?
    var carClsStr: String?
    var amount: Float?
    var remark: String?
    var userName: String?
    var createTime: String?
    var statusId: Int64?
    var storeId: Int64?
    var keyStore: String?
    var feedback: String?
    var feedDate: String?
    var paywayId: Int64?
    var payTime: String?
    var billDetailId: Int64?
    var itemId: Int64?
    var productId: Int64?
    var itemCode: String?
    var itemName: String?
    var model: String?
    var originCode: String?
    var outQty: Int64?
    var unitName: String?
    var costPrice: Float?
    var outPrice: Int64?
    var billTypeId: Int64?
    var customerId: Int64?
    var clsIdStr: Int64?
    var saleCount: Int64?
    var saleSum: Int64?
    var costSum: Int64?
    var profitSum: Int64?
    var dummy: String?
    var otherItemId: Int64?
    var price: Float?
    var qty: Int64?
    var welcomePerson: String?
    var exePerson: String?
    var powers: Array<String>?

    required init() {}
}
