//
//  FFSearchViewController.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/27.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

protocol FFSearchViewDelegate : AnyObject {
    func searchViewSearchBtnActionWithParams(text:String)
}

class FFSearchView : UIView {
        
    weak var delegate : FFSearchViewDelegate?
    
    let searchTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("请输入商品信息查找")
        textField.font = kFontRegular(13)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.textAlignment = .left
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 10, height: 35)
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    let searchBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle(kLanguage("搜索"), for: .normal)
        btn.setTitleColor(Theme.btnBackgroundColor(), for: .normal)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(searchTXT)
        self.addSubview(searchBtn)
        
        searchTXT.snp.makeConstraints { make in
            make.left.equalTo(25)
            make.right.equalTo(-80)
            make.height.equalTo(35)
            make.top.equalTo(7.5)
        }
        
        searchBtn.snp.makeConstraints { make in
            make.left.equalTo(searchTXT.snp.right).offset(10)
            make.right.equalTo(-25)
            make.height.greaterThanOrEqualTo(20)
            make.centerY.equalToSuperview()
        }
        
        searchBtn.addTarget(self, action: #selector(searchBtnAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchBtnAction(_ sender:UIButton) -> Void {
        guard let str = searchTXT.text,str != "" else { return }
        if self.delegate != nil {
            self.delegate?.searchViewSearchBtnActionWithParams(text: str)
        }
    }
}
