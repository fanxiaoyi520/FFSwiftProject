//
//  FFItemModelList.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/14.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import HandyJSON

class FFItemModelList: HandyJSON,Codable {

    var page: Int64?
    var pageSize: Int64?
    var total: Int64?
    var items: Array<ItemInfo>?
    required init() {}
}
