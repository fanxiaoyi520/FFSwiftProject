//
//  FFOrderDetailsViewController.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/11.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class FFOrderDetailsViewController: FFBaseViewController {

    var dataItems: Array = Array<ProductInfo>()
    
    var item : Item?
    
    var orderDetailsHeaderView : FFOrderDetailsHeaderView?

    var orderDetailsFooterView : FFOrderDetailsFooterView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = kLanguage("订单详情")
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: getScreenWidth(), height: getScreenHeight())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FFOrderDetailsCell.classForCoder(), forCellReuseIdentifier: "FFOrderDetailsCell")
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clear
        
        let orderDetailsHeaderView = FFOrderDetailsHeaderView(frame: CGRect(x: 0, y: 0, width: getScreenWidth(), height: 20.0*4.0+6.0*3.0+12.0*2.0))
        tableView.tableHeaderView = orderDetailsHeaderView
        self.orderDetailsHeaderView = orderDetailsHeaderView
        
        let orderDetailsFooterView = FFOrderDetailsFooterView(frame: CGRect(x: 0, y: 0, width: getScreenWidth(), height: 300))
        orderDetailsFooterView.delegate = self
        tableView.tableFooterView = orderDetailsFooterView
        self.orderDetailsFooterView = orderDetailsFooterView

        getOrderDetailById()
    }
}

extension FFOrderDetailsViewController : UITableViewDataSource,UITableViewDelegate,FFOrderDetailsFooterViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FFOrderDetailsCell", for: indexPath) as! FFOrderDetailsCell
        cell.backgroundView = nil
        cell.backgroundColor = UIColor.clear
        let model = dataItems[indexPath.row]
        cell.item = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20.0*2.0+6.0+12.0*2.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        IQKeyboardManager.shared.resignFirstResponder()
        tableView.scrollsToTop = true
    }
    
    func back(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FFOrderDetailsViewController {
    
    func getOrderDetailById() -> Void {
        let parameters = [
            "OrderId": item?.orderId,
        ]
        
        NetworkManager.shared.request(url: GetOrderDetailById,
                                      method: .get,
                                      parameters: parameters as [String : Any],
                                      success: { (response: ResponseModel<FFOrderDetailsModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            debugPrint("====获取订单详情数据：\(String(describing: response.data?.toJSONString()))")
            self.orderDetailsHeaderView?.item = response.data
            self.orderDetailsFooterView?.item1 = self.item
            self.orderDetailsFooterView?.item = response.data
            self.dataItems = response.data?.productInfos ?? []
            self.tableView.reloadData()
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
}
