//
//  FFSendListViewController.swift
//  FFAcssell
//
//  Created by zhou on 2019/7/31.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFHomeListViewController: FFBaseViewController {

    var homeHeaderView = FFHomeHeaderView(dataItems: statusArr(), frame: CGRect(x: 0, y: 0, width: getScreenWidth(), height: 51))
    
    var dataItems: Array = Array<ItemList>()

    var noDataStatusView = NoDataStatusView(frame: CGRect(x: 0, y: 0, width: getScreenWidth(), height: getScreenHeight()-getStatusBarAndNavigationBarHeight()), tips: kLanguage("暂无数据"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(homeHeaderView)

        homeHeaderView.delegate = self
                    
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: homeHeaderView.frame.size.height, width: getScreenWidth(), height: getScreenHeight()-homeHeaderView.frame.size.height-getTabBarHeight()-getStatusBarAndNavigationBarHeight())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.classForCoder(), forCellReuseIdentifier: "HomeTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = IndexPath(row: 0, section: 0)
        getDashboardList(indexPath: indexPath)
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

extension FFHomeListViewController : UIScrollViewDelegate, FFHomeHeaderViewDelegate {
    
    func homeHeaderViewCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("====切换tab:\(indexPath.row)")
        getDashboardList(indexPath: indexPath)
    }
}

extension FFHomeListViewController {
    func getDashboardList(indexPath:IndexPath) -> Void {
        //day,month,year
        var inputStr = "day"
        switch indexPath.row {
        case 0:
            inputStr = "day"
        case 1:
            inputStr = "month"
        case 2:
            inputStr = "year"
        default:
            inputStr = "day"
        }
        
        let parameters = [
            "timestr": inputStr,
        ]
        
        NetworkManager.shared.request(url: GetDashboardList,
                                      method: .get,
                                      parameters: parameters,
                                      success: { (response: ResponseModel<HomeModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            debugPrint("====获取订单列表：\(String(describing: response.data?.toJSONString()))")
            self.dataItems = response.data?.itemList ?? []
            self.tableView.reloadData()
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
}

extension FFHomeListViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (dataItems.isEmpty || dataItems.count == 0) {

            view.addSubview(noDataStatusView)
        } else {
            noDataStatusView.removeFromSuperview()
        }
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell

        let model = dataItems[indexPath.row]
        cell.item = model
        cell.lineView.isHidden = dataItems.count == indexPath.row ? true : false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.scrollsToTop = true
    }
}
