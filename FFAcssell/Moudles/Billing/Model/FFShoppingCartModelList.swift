//
//  FFShoppingCartModelList.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/14.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import HandyJSON

class FFShoppingCartModelList: HandyJSON,Codable {

    var items: Array<FFShoppingCartModel>?
    required init() {}
}

class FFShoppingCartModel: HandyJSON,Codable,Hashable {

    var id: Int64? = Int64(arc4random())
    var name: String?
    var price: Float?
    var num: Int64 = 0
    var istemporary: Bool = false
    var typeStr: String = "product" //product or item
    var smallSum: Float = 0

    required init() {}
    
    static func ==(lhs: FFShoppingCartModel, rhs: FFShoppingCartModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
