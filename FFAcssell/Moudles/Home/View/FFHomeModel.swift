//
//  FFHomeModel.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/10.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import HandyJSON

class HomeModel: HandyJSON,Codable {
    var itemList: Array<ItemList>?
    required init() {}
}

class ItemList: HandyJSON,Codable {
    //{\"title\":\"客户数量\",\"value\":\"28 个\",\"color\":\"green\",\"action\":\"日\",\"icon\":null}
    var title: String?
    var value: String?
    var color: Int64?
    var action: String?
    var icon: String?
    required init() {}
}
