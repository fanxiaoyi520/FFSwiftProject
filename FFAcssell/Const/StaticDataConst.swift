//
//  StaticDataConst.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/9.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation

class Mine {
    var title : String?
    var imageStr : String?
        
    required init(title:String?,imageStr:String?) {
        self.title = title
        self.imageStr = imageStr
    }
}
func mineDataList() -> Array<Mine> {

    return [Mine(title: kLanguage("关于版本"), imageStr: "mine_download"),Mine(title: kLanguage("修改密码"), imageStr: "mine_edit"),Mine(title: kLanguage("退出账号"), imageStr: "mine_arrow")]
}

func statusArr() -> Array<String> {
    return Array<String>(arrayLiteral: kLanguage("今日"),kLanguage("本月"),kLanguage("今年"))
}

func checkListArr() -> Array<String> {
    return Array<String>(arrayLiteral: kLanguage("今日"),kLanguage("本月"),kLanguage("今年"),kLanguage("全部"))
}

func billingArr() -> Array<String> {
    return Array<String>(arrayLiteral: kLanguage("商品"),kLanguage("项目"),kLanguage("购物车"))
}

func loginTypeArr() -> Array<String> {
    return Array<String>(arrayLiteral: kLanguage("账户密码登陆"),kLanguage("手机号登陆"))
}

