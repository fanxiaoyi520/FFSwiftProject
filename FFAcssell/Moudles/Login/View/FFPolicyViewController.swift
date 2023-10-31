//
//  FFPolicyViewController.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/25.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

class FFPolicyViewController: FFBaseViewController {
    
    var titleStr : String? = nil
    
    let textView = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = kLanguage(titleStr ?? "")
        
        view.addSubview(textView)
        textView.frame = CGRect(x: 25, y: getStatusBarAndNavigationBarHeight()+12, width: getScreenWidth()-25*2, height: getScreenHeight()-getStatusBarAndNavigationBarHeight()-12)
        
        if let fileURL = Bundle.main.url(forResource: titleStr, withExtension: "txt") {
            do {
                let fileContents = try String(contentsOf: fileURL)
                textView.text = fileContents
            } catch {
                print("Error reading file: \(error.localizedDescription)")
            }
        }
        
    }
}



