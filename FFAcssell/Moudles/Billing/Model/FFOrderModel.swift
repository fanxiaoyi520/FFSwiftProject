//
//  FFOrderModel.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/17.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import HandyJSON

class FFOrderModel: HandyJSON {
    
    var customerId: String?
    var km: Int = 0
    var paywayId: Int = 1
    var welcomePerson: String?
    var exePerson: String?
    var invoiceTypeId: Int = 0
    var productInfos: Array<ProductInfo> = Array()
    var itemInfos: Array<ItemInfo> = Array()
    var actualAmount: Float = 0
    var isFormalOrder: Bool = false
    var orderStartTime: String? = ""
    var orderEndTime: String? = ""
    
    required init() {}
}

// 商品信息
class ProductInfo: HandyJSON,Codable,Hashable {
    static func == (lhs: ProductInfo, rhs: ProductInfo) -> Bool {
        return lhs.stockId == rhs.stockId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(stockId)
    }
    
    var stockId: Int64 = 0
    var storeName: String?
    var clsStr: String?
    var itemCode: String?
    var productName: String?
    var model: String?
    var originCode: String?
    var qty: Int = 0
    var unitName: String?
    var price1: Float = 0
    var price2: Float = 0
    var minQty: Int?
    var maxQty: Int?
    var productId: Int64 = 0
    var deptId: Int = 0
    var clsIdStr: String?
    var updateTime: String?
    var organizationId: Int = 0
    var key: String?
    var outPrice: Float = 0
    var sn: String?
    var discount: Int = 100
    var rowKey: String? = UUID().uuidString
    var canPayQty: Int = 0
    var cardNum: String?
    var discountAmount: Int = 0
    var smallSum: Float = 0
    
    required init() {}
}

// 服务信息
class ItemInfo: HandyJSON,Codable,Hashable {
    static func == (lhs: ItemInfo, rhs: ItemInfo) -> Bool {
        return lhs.itemId == rhs.itemId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(itemId)
    }
    
    var organizationId: Int = 0
    var itemId: Int64 = 0
    var itemCode: String?
    var itemName: String?
    var price: Float = 0
    var unitName: String?
    var price1: Int = 0
    var price2: Int = 0
    var taskHours: Int = 0
    var storeId: Int64 = 0
    var key: String?
    var outPrice: Float = 0
    var qty: Int = 0
    var discount: Int = 100
    var canPayQty: Int = 0
    var cardNum: String?
    var rowKey: String? = UUID().uuidString
    var discountAmount: Int = 0
    var smallSum: Float = 0
    var amount: Int = 0
    
    required init() {}
}
