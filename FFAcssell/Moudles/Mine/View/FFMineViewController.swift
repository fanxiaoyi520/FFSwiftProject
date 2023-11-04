//
//  FFMineViewController.swift
//  FFAcssell
//
//  Created by zhou on 2019/7/31.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import AEAlertView

class FFMineViewController: FFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = kLanguage("我的")

        // Do any additional setup after loading the view.
        
        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isScrollEnabled = false
        self.tableView.register(FFMineCell.classForCoder(), forCellReuseIdentifier: "FFMineCell")
        self.tableView.frame = CGRect(x: 0, y: 0, width: getScreenWidth(), height: getScreenHeight()-getTabBarHeight()-getStatusBarAndNavigationBarHeight())
        let size = UIImage(named: "setup_header")?.size
        let headerView = FFHeaderView(frame: CGRect(x: 0, y: 0, width: getScreenWidth(), height: getScreenWidth() * size!.height / size!.width))
        self.tableView.tableHeaderView = headerView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FFMineViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mineDataList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FFMineCell", for: indexPath) as! FFMineCell
        
        cell.backgroundColor = Theme.secondBackgroundColor()
        cell.backgroundView = nil
        cell.model = mineDataList()[indexPath.row]
        if indexPath.row != mineDataList().count - 1 {
            cell.accessoryType = .disclosureIndicator
        }
        cell.isHiddenLineView = indexPath.row == 0 ? true : false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row == 0) {
            let vc = FFAboutVersionsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        if (indexPath.row == 1) {
            let vc = FFChangePasswordViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        if (indexPath.row == mineDataList().count-1) {
            logout()
            return
        }
    }
}

extension FFMineViewController {
    func logout() -> Void {
        
        AEAlertView.show(title: "退出登陆", message: "确定退出登陆吗？", actions: ["取消","确定"]) { action in
            debugPrint("dismiss----Fastest")
            if (action.tag == 1) {
                FFUserManager.shared.logout()
            }
        }
    }
}
