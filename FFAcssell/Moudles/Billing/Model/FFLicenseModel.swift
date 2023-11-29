//
//  FFLicenseModel.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/14.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import HandyJSON

class FFLicenseModelList: HandyJSON,Codable {
   
    var status: Int?
    var message: String?
    var data: Array<FFLicenseModel>?
    
    required init() {}
}

class FFLicenseModel: HandyJSON,Codable {
   
    var customerId: String?
    var carNum: String? = "无"
    var phone: String?
    var orderId: Int64?

    required init() {}
}

