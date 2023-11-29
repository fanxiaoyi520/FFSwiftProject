//
//  FFPublishListViewController.swift
//  FFAcssell
//
//  Created by zhou on 2019/7/31.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MJRefresh
import AEAlertView

class FFCheckListViewController: FFBaseViewController {
    
    var dataItems: Array = Array<Item>()

    var page : Int64 = 1
    
    var indexPath : IndexPath? = IndexPath(row: 0, section: 0)
    
    var noDataStatusView = NoDataStatusView(frame: CGRect(x: 0, y: 51+50+12*2, width: getScreenWidth(), height: getScreenHeight()-getStatusBarAndNavigationBarHeight()), tips: kLanguage("暂无数据"))
    
    lazy var searchTXT: FFTextField = {
        let textField = FFTextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("请输入车牌号/手机号")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.keyboardType = .webSearch
        textField.delegate = self
        textField.clearButtonMode = .unlessEditing
        let originalImage = UIImage(named: "search")

        let newSize = CGSize(width: 25, height: 25)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let scaledImage = renderer.image { _ in
            originalImage?.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        }

        let leftView = UIImageView(image: scaledImage)
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    var homeHeaderView = FFHomeHeaderView(dataItems: checkListArr(), frame: CGRect(x: 0, y:50+24, width: getScreenWidth(), height: 51))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(searchTXT)
        searchTXT.frame = CGRect(x: 12, y: 12, width: getScreenWidth()-12*2, height: 50)

        view.addSubview(homeHeaderView)
        homeHeaderView.delegate = self
        homeHeaderView.dataItems = checkListArr()
                    
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y:homeHeaderView.frame.size.height+self.searchTXT.frame.size.height+12*2, width: getScreenWidth(), height: getScreenHeight()-homeHeaderView.frame.size.height-getTabBarHeight()-self.searchTXT.frame.size.height-24)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FFCheckListCell.classForCoder(), forCellReuseIdentifier: "FFCheckListCell")
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            // 这里写下拉刷新时的操作，比如发起网络请求获取最新的数据
            // 刷新完成后，记得调用endRefreshing()方法结束刷新状态
            self.loadData()
        })
        
        // 设置上拉加载
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            // 这里写上拉加载时的操作，比如发起网络请求加载更多数据
            // 加载完成后，记得调用endRefreshing()方法结束加载状态
            self.loadMoreData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        page = 1
        getOrderListInMobile(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
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

extension FFCheckListViewController : UIScrollViewDelegate, FFHomeHeaderViewDelegate,UITextFieldDelegate {
    
    func homeHeaderViewCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("====切换tab:\(indexPath.row)")
        self.indexPath = indexPath
        self.page = 1
        self.tableView.mj_footer?.resetNoMoreData()
        getOrderListInMobile(indexPath: indexPath)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        IQKeyboardManager.shared.resignFirstResponder()
        getOrderListInMobile(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
        return true
    }
}

extension FFCheckListViewController {
    func getOrderListInMobile(indexPath:IndexPath,isLoadMoreData:Bool = false) -> Void {
        if (!isLoadMoreData) {
            self.dataItems.removeAll()
        }
        //day,month,year
        var inputStr = "day"
        switch indexPath.row {
        case 0:
            inputStr = "day"
        case 1:
            inputStr = "month"
        case 2:
            inputStr = "year"
        case 3:
            inputStr = "all"
        default:
            inputStr = "day"
        }
        
        var parameters : [String : Any]?
        if (isTelNumber(num: searchTXT.text ?? "")) {
             parameters = [
                "timespan": inputStr,
                "Page":page,
                "pageSize":10,
                "phone":searchTXT.text ?? ""
            ] as [String : Any]
        } else {
             parameters = [
                "timespan": inputStr,
                "Page":page,
                "pageSize":10,
            ] as [String : Any]
        }
        

        NetworkManager.shared.request(url: GetOrderListInMobile,
                                      method: .get,
                                      parameters: parameters,
                                      success: { [weak self] (response: ResponseModel<FFCheckListModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            debugPrint("====获取订单列表：\(String(describing: response.data?.toJSONString()))")
            if (isLoadMoreData) {
                if response.data?.items?.count ?? 0 < 10 {
                    // 已经加载完全部数据
                    self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
                    
                } else {
                    self?.dataItems += response.data?.items ?? []
                    self?.tableView.reloadData()
                    self?.tableView.mj_footer?.endRefreshing()
                }
            } else {
                self?.dataItems = response.data?.items ?? []
                self?.tableView.reloadData()
                self?.tableView.mj_header?.endRefreshing()
            }
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            self.tableView.mj_header?.endRefreshing()
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
    
    // 下拉刷新方法
    private func loadData() {
        page = 1
        getOrderListInMobile(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
    }

    // 上拉加载方法
    private func loadMoreData() {
        page += 1
        getOrderListInMobile(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0),isLoadMoreData: true)
    }
    
    
    
    func orderCancelById(item:Item) -> Void {
        
        let parameters = [
            "ID": item.orderId ?? "",
        ] as [String : Any]
        
        NetworkManager.shared.request(url: OrderCancelById,
                                      method: .post,
                                      parameters: parameters,
                                      success: { [weak self] (response: ResponseModel<FFCheckListModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            debugPrint("====注销订单：\(String(describing: response.data?.toJSONString()))")
            self?.tableView.mj_header?.beginRefreshing()
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
}

extension FFCheckListViewController : UITableViewDataSource,UITableViewDelegate,FFCheckListCellDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (dataItems.isEmpty || dataItems.count == 0) {

            view.addSubview(noDataStatusView)
        } else {
            noDataStatusView.removeFromSuperview()
        }
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FFCheckListCell", for: indexPath) as! FFCheckListCell
        if (indexPath.row <= dataItems.count-1) {
            let model = dataItems[indexPath.row]
            cell.item = model
            cell.lineView.isHidden = dataItems.count == indexPath.row ? true : false
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20.0*4.0+6.0*3.0+12.0*2.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        IQKeyboardManager.shared.resignFirstResponder()
        tableView.scrollsToTop = true
        
        let item = dataItems[indexPath.row]
        guard let id = item.statusId,id != 0 else { return }
        let vc = FFOrderDetailsViewController()
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkListCellEditBtnAction(_ sender: UIButton, cell: UITableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let item = dataItems[indexPath?.row ?? 0]
        AEAlertView.show(title: "", message: "修改订单将清空购物车数据！", actions: ["取消","确定"]) { action in
            if (action.tag == 1) {
                self.navigationController?.tabBarController?.selectedIndex = 1
                NotificationCenter.default.post(name: Notification.Name(rawValue: "CheckListCellEditBtnAction"), object: nil, userInfo: ["info": item])
            }
        }
    }
    
    func checkListCellLogOffBtnAction(_ sender: UIButton, cell: UITableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let item = dataItems[indexPath?.row ?? 0]
        AEAlertView.show(title: "", message: "确定要注销此订单吗？", actions: ["取消","确定"]) { [self] action in
            if (action.tag == 1) {
                orderCancelById(item: item)
            }
        }
    }
}


