//
//  Model.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/8.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import HandyJSON

class ResponseModel<T: HandyJSON>: HandyJSON {
    var status: Int?
    var message: String?
    var data: T?
    var jsonString: String?
    required init() {}
}


class ResponseModel1: HandyJSON {
    var status: Int?
    var message: String?
    var data: String?
    required init() {}
}
