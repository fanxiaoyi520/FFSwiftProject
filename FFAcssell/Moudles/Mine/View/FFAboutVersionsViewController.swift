//
//  FFAboutVersionsViewController.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/10.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import swiftScan

class FFAboutVersionsViewController: FFBaseViewController {
    
    lazy var titleLab: UILabel = {
        titleLab = UILabel()
        titleLab.numberOfLines = 0
        titleLab.textAlignment = .center
        titleLab.font = UIFont.fontWithPFRegular(13)
        titleLab.textColor = Theme.titleColor()
        titleLab.text = kLanguage("For iOS \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0") bulid \(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1.0.0")")
        return titleLab
    }()
    
    lazy var subTitleLab: UILabel = {
        subTitleLab = UILabel()
        subTitleLab.numberOfLines = 0
        subTitleLab.textAlignment = .center
        subTitleLab.font = UIFont.fontWithPFRegular(13)
        subTitleLab.textColor = Theme.subTitleColor()
        subTitleLab.text = kLanguage("扫描二维码,你的朋友也可以下载App")
        return subTitleLab
    }()
    
    var qrView = UIView()
    var qrImgView = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = kLanguage("关于版本")
        
        view.addSubview(titleLab)
        view.addSubview(subTitleLab)

        titleLab.snp.makeConstraints { make in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(getStatusBarAndNavigationBarHeight() + 100)
        }
       
        drawCodeShowView()
        
        subTitleLab.snp.makeConstraints { make in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(qrView.snp_bottomMargin).offset(80)
        }

        createQR1()
    }
    
    // MARK: - -----二维码、条形码显示位置
    func drawCodeShowView() {
        qrView.backgroundColor = Theme.btnBackgroundColor()
        qrView.layer.shadowOffset = CGSize(width: 0, height: 2)
        qrView.layer.shadowRadius = 2
        qrView.layer.shadowColor = UIColor.black.cgColor
        qrView.layer.shadowOpacity = 0.5

        self.view.addSubview(qrView)
        qrView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLab.snp_bottomMargin).offset(80)
            make.width.equalToSuperview().multipliedBy(4.0 / 6.0)
            make.height.equalTo(qrView.snp.width)
        }

        qrView.addSubview(qrImgView)
        qrImgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(qrView).offset(-12)
            make.height.equalTo(qrView).offset(-12)
        }
    }

    func createQR1() {

        self.view.layoutIfNeeded()
        let qrImg = LBXScanWrapper.createCode(codeType: "CIQRCodeGenerator", codeString: "lbxia20091227@foxmail.com", size: qrImgView.bounds.size, qrColor: UIColor.black, bkColor: UIColor.white)

        let logoImg = UIImage(named: "tabbar_home_select_.png")
        qrImgView.image = LBXScanWrapper.addImageLogo(srcImg: qrImg!, logoImg: logoImg!, logoSize: CGSize(width: 30, height: 30))
    }

    deinit {
        print("MyCodeViewController deinit")
    }

}
