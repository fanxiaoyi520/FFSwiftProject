//
//  FFCheck.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/8.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation

class FFCheck {
    
    // MARK: - 正则匹配手机号
    class func checkTelNumber(_ telNumber: String) -> Bool {
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$"
        let CU = "^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$"
        let CT = "^1((33|53|8[09])\\d|349|700)\\d{7}$"
        
        let regextestcm = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestcu = NSPredicate(format: "SELF MATCHES %@", CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@", CT)
        
        if regextestcm.evaluate(with: telNumber) || regextestct.evaluate(with: telNumber) || regextestcu.evaluate(with: telNumber) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - 正则匹配用户密码6-18位数字和字母组合
    class func checkPassword(_ password: String) -> Bool {
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: password)
    }
    
    // MARK: - 正则匹配用户姓名,20位的中文或英文
    class func checkUserName(_ userName: String) -> Bool {
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: userName)
    }
    
    // MARK: - 正则匹配用户身份证号15或18位
    class func checkUserIdCard(_ idCard: String) -> Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: idCard)
    }
    
    // MARK: - 正则匹员工号,12位的数字
    class func checkEmployeeNumber(_ number: String) -> Bool {
        let pattern = "^[0-9]{12}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: number)
    }
    
    // MARK: - 正则匹配URL
    class func checkURL(_ url: String) -> Bool {
        let pattern = "^[0-9A-Za-z]{1,50}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: url)
    }
}
