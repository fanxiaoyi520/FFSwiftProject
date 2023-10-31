//
//  NoDataStatusView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/10.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class NoDataStatusView: UIView {
    
    private let tipsImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "RoomM_icon_404")
        imageView.image = image
        return imageView
    }()
    
    private let tipsLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontWithPFRegular(15)
        label.textColor = Theme.lineBtnTitleColor()
        label.text = "暂无数据"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var isBottom: Bool = false
    
    init(frame: CGRect, tips: String) {
        super.init(frame: frame)
        initialize(tips: tips, isBottom: false)
    }
    
    init(frame: CGRect, tips: String, isBottom: Bool) {
        super.init(frame: frame)
        initialize(tips: tips, isBottom: isBottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize(tips: "", isBottom: false)
    }
    
    private func initialize(tips: String, isBottom: Bool) {
        self.isBottom = isBottom
        addSubview(tipsImageView)
        tipsImageView.addSubview(tipsLab)
        tipsLab.text = tips
        addConstraints()
    }
    
    private func addConstraints() {
        tipsImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            if isBottom {
                make.height.equalTo(getScreenWidth() / 2 * 174 / 250)
                make.width.equalTo(getScreenWidth() / 2)
            } else {
                make.height.equalTo((getScreenWidth() - 62 * 2) * 174 / 250)
                make.width.equalTo(getScreenWidth() - 62 * 2)
            }
        }
        
        tipsLab.snp.makeConstraints { make in
            make.width.equalTo(tipsImageView.snp.width)
            make.bottom.equalTo(tipsImageView.snp.bottom).offset(-5)
            make.height.greaterThanOrEqualTo(22)
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Custom drawing code if needed
    }
}
