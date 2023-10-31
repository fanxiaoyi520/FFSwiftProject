//
//  FFUserInfo.swift
//  FFAcssell
//
//  Created by zhou on 2019/8/1.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import HandyJSON


class TokenModel: HandyJSON,Codable {
    var token: String?
    var expire: String?
    var refreshToken: String?
    var refreshExpire: String?

    required init() {}
}

class UserModel: HandyJSON,Codable {

    var userId: Int64?
    var customerId: Int64?
    var supplierId: Int64?
    var employeeId: Int64?
    var organizationId: Int64?
    var userName: String?
    var phone: String?
    var email: String?
    var loginIdentity: Int64?
    var isLeader: Int64?
    var dueTime: String?
    var isEnabled: Int64?
    var lastLogonTime: String?
    var wxOpenId: String?
    var clientInfo: String?
    var nickName: String?
    var headerImg: String?
    var employee: Employee?
    var customer: Customer?
    var supplier: Supplier?
    var roleGroup: RoleGroup?
    var token: String?
    var tokenDueTime: String?

    required init() {}
}

class Employee: HandyJSON,Codable {

    var employeeId: Int64?
    var groupId: Int64?
    var storeId: Int64?
    var deptId: Int64?
    var departmentId: Int64?
    var name: String?
    var sex: Int64?

    required init() {}
}

class Customer: HandyJSON, Codable {
    var storeName: String?
    var customerId: Int64?
    var customerName: String?
    var sex: Int64?
    var phone: String?
    var address: String?
    var comeNum: Int64?
    var carNum: String?
    var frameNum: String?
    var engineNum: String?
    var carClsStr: String?
    var km: Int64?
    var insuCompany: String?
    var insuDueDate: String?
    var yearCKDueDate: String?
    var balance: Int64?
    var openId: String?
    var storeId: Int64?
    var userId: Int64?
    var createId: Int64?
    var createTime: String?
    var changeId: Int64?
    var changeTime: String?
    var organizationId: Int64?
    
    required init() {}
}

class Supplier:HandyJSON, Codable {
    var supplierId: Int?
    var name: String?
    var contactPerson: String?
    var phone: String?
    var email: String?
    var postCode: String?
    var address: String?
    var openingBank: String?
    var bankCardNum: String?
    var remark: String?
    var createId: Int?
    var createTime: String?
    var changeId: Int?
    var changeTime: String?
    var organizationId: Int?
    
    required init() {}
}

class RoleGroup:HandyJSON, Codable {
    var groupId: Int?
    var groupName: String?
    var menuIdStr: [Int]?
    var apiIdStr: String?
    var hasStore: Int?
    var hasDept: Int?
    var hasDel: Int?
    var hasUpd: Int?
    var createId: Int?
    var createTime: String?
    var changeId: Int?
    var changeTime: String?
    var organizationId: Int?
    
    required init() {}
}
