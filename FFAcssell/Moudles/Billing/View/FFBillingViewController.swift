//
//  FFPublishListViewController.swift
//  FFAcssell
//
//  Created by zhou on 2019/7/31.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import RZCarPlateNoTextField
import IQKeyboardManagerSwift
import HandyJSON
import MJRefresh
import AEAlertView

class FFBillingViewController: FFBaseViewController {

    var dataItems0: Array = Array<ProductInfo>()
    
    var dataItems1: Array = Array<ItemInfo>()
    
    var dataItems2: Array = Array<FFShoppingCartModel>()
    
    var orderModel: FFOrderModel = FFOrderModel()
    
    var billingHeaderView : FFBillingHeaderView?
    
    var searchView : FFSearchView?
    
    var billingBottomView : FFBillingBottomView?

    var id : String? = "0"

    var allNum : Int64 = 0

    var selIndex : Int?
    
    var page0 : Int64 = 0

    var page1 : Int64 = 0

    var tableView0 : UITableView?
    var tableView1 : UITableView?
    var tableView2 : UITableView?

    var licenseModelList : FFLicenseModelList?
    var licenseModel : FFLicenseModel?

    var isNoLicense : Bool?
    
    var productName : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selIndex = 0
        let billingHeaderView = FFBillingHeaderView(frame: CGRect(x: 0, y: 0, width: getScreenWidth(), height: 131))
        view.addSubview(billingHeaderView)
        billingHeaderView.delegate = self
        self.billingHeaderView = billingHeaderView
        
        let searchView = FFSearchView(frame: CGRect(x: 0, y: billingHeaderView.frame.size.height, width: getScreenWidth(), height: 50))
        view.addSubview(searchView)
        searchView.delegate = self
        self.searchView = searchView
        
        view.addSubview(baseScrollView)
        baseScrollView.isPagingEnabled = true
        baseScrollView.delegate = self
        baseScrollView.frame = CGRect(x: 0, y: billingHeaderView.frame.size.height+searchView.frame.size.height, width: getScreenWidth(), height: getScreenHeight()-getTabBarHeight()-billingHeaderView.frame.size.height-searchView.frame.size.height)
        baseScrollView.contentSize = CGSize(width: getScreenWidth()*CGFloat(billingArr().count), height: baseScrollView.frame.height)
        
        let billingBottomView = FFBillingBottomView(frame: CGRect(x: 0, y: getScreenHeight()-110-getSafeAreaHeight()-billingHeaderView.frame.size.height, width: getScreenWidth(), height: 110))
        view.addSubview(billingBottomView)
        self.billingBottomView = billingBottomView
        billingBottomView.delegate = self
        
        for (index, number) in billingArr().enumerated() {
            print("Number at index \(index) is \(number)")
            let tableView = UITableView(frame: CGRect(x: CGFloat(index)*getScreenWidth(), y: 0, width: getScreenWidth(), height: baseScrollView.frame.height-getTabBarHeight()-110), style: .plain)
            tableView.showsHorizontalScrollIndicator = false
            tableView.showsVerticalScrollIndicator = false
            tableView.backgroundColor = UIColor.clear
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tag = 100 + index
            baseScrollView.addSubview(tableView)
            if (index == 0) {
                tableView0 = tableView
                tableView.register(FFBillingDisplayCell.classForCoder(), forCellReuseIdentifier: "FFBillingDisplayCell0")
            }
            
            if (index == 1) {
                tableView1 = tableView
                tableView.register(FFBillingDisplayCell.classForCoder(), forCellReuseIdentifier: "FFBillingDisplayCell1")
            }
            
            if (index == 2) {
                tableView2 = tableView
                tableView.register(FFBillingAddCell.classForCoder(), forCellReuseIdentifier: "FFBillingAddCell")
            }
        }
        
        
        tableView0?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadData0()
        })
        
        // 设置上拉加载
        tableView0?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.loadMoreData0()
        })

        tableView1?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadData1()
        })
        
        // 设置上拉加载
        tableView1?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.loadMoreData1()
        })
        
        addNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getStockInList()
        getItemList()
    }
    
    private func addNotification() {
            NotificationCenter.default.addObserver(self, selector: #selector(handleReleaseSuccess), name: Notification.Name(rawValue: "CheckListCellEditBtnAction"), object: nil)
        }
     
    /// 销毁监听
    deinit {
         NotificationCenter.default.removeObserver(self)
     }
     
    /// 收到通知后执行的操作
    /// 可以通过userInfo获取到通知传递的数据
    @objc
    private func handleReleaseSuccess(notifi: Notification) {
        self.baseScrollView.setContentOffset(CGPoint(x: getScreenWidth()*2, y: 0), animated: true)
        self.billingHeaderView?.updateTabbar(index: 2)
        ///执行收到通知后的操作
        let item = notifi.userInfo?["info"] as? Item
        getOrderDetailById(item: item ?? Item())
        debugPrint("====编辑的订单数据:\(String(describing: item?.toJSONString()))")
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

extension FFBillingViewController : FFBillingHeaderViewDelegate,UIScrollViewDelegate,FFCustomPopupViewDelegate {
    
    func customPopupViewSureBtn(sender: UIButton, model: FFShoppingCartModel) {
        debugPrint("====新增项目内容:\(model.toJSONString() ?? "")")

        allNum = allNum + model.num
        model.typeStr = "item"
        let item = ItemInfo()
        item.itemId = model.id ?? 0
        item.itemName = model.name
        item.outPrice = model.price ?? 0
        item.qty = Int(model.num)
        item.smallSum = Float(Int(item.outPrice) * (item.discount / 100) * (item.qty - item.canPayQty));

        orderModel.itemInfos.append(item)
        orderModel.itemInfos = Array(Set(orderModel.itemInfos))
        orderModel.itemInfos = orderModel.itemInfos.map { item in
            if (item.itemId == model.id) {
                item.smallSum = Float(Int(item.outPrice) * (item.discount / 100) * (item.qty - item.canPayQty));
            }
            return item
        }

        dataItems2.append(model)
        dataItems2 = Array(Set(dataItems2))
        
        self.billingHeaderView?.updateNum(num: allNum)
        self.billingBottomView?.update(model: orderModel)
        self.tableView2?.reloadData()
    }
    
    func addProject(sender: UIButton) {
        let customPopupView = FFCustomPopupView(frame: CGRect(x: 0, y: 0, width: getScreenWidth()-50*2, height: 260))
        customPopupView.layer.cornerRadius = 2
        customPopupView.layer.masksToBounds = true
        customPopupView.delegate = self
        let vProperty = FWPopupViewProperty()
        vProperty.popupCustomAlignment = .center
        vProperty.popupAnimationType = .scale
        vProperty.maskViewColor = UIColor(white: 0, alpha: 0.3)
        vProperty.touchWildToHide = "1"
        vProperty.popupViewEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        vProperty.animationDuration = 0.2
        customPopupView.vProperty = vProperty
        
        customPopupView.show { (popupView, popupViewState) in
            print("\(popupViewState.rawValue)")
        }
    }
    
    func selBtnNoLicense(sender: UIButton) {
        self.isNoLicense = sender.isSelected
        self.billingHeaderView?.updateContent(licenseModel: FFLicenseModel(),completion: { [weak self] in
            self?.updateFrame()
        })
    }
    
    func billingHeaderViewSaveBtnAction(sender: UIButton) {
        IQKeyboardManager.shared.resignFirstResponder()
        
        createCustomers()
    }
    
    func rz_textFieldEditingValueChanged(textField: RZCarPlateNoTextField) {
        getBaseTypeList(textField: textField)
    }
    
    func billingHeaderViewCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("====开单切换tabbar:\(indexPath)")
        debugPrint("====baseScrollView宽度度:\(baseScrollView.frame.width)")
        debugPrint("====baseScrollView高度:\(baseScrollView.frame.height)")
        selIndex = indexPath.row
        let screenWidth = UIScreen.main.bounds.width
        let scrollDistance = CGFloat(indexPath.item) * screenWidth
        self.baseScrollView.setContentOffset(CGPoint(x: scrollDistance, y: 0), animated: true)
        
        if (selIndex == 0 || selIndex == 1) {
            baseScrollView.frame = CGRect(x: 0, y: (billingHeaderView?.frame.size.height)!+(searchView?.frame.size.height)!, width: getScreenWidth(), height: getScreenHeight()-getTabBarHeight()-(billingHeaderView?.frame.size.height)!-(searchView?.frame.size.height)!)
            searchView?.isHidden = false
        } else {
            baseScrollView.frame = CGRect(x: 0, y: (billingHeaderView?.frame.size.height)!, width: getScreenWidth(), height: getScreenHeight()-getTabBarHeight()-(billingHeaderView?.frame.size.height)!)
            searchView?.isHidden = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == self.baseScrollView else { return }
        let screenWidth = UIScreen.main.bounds.width
        let contentOffsetX = scrollView.contentOffset.x
        if contentOffsetX.truncatingRemainder(dividingBy: screenWidth) == 0 {
            // 滚动结束后，根据滚动距离更新UICollectionView的当前选中项
            let selectedIndex = Int(contentOffsetX / screenWidth)
            selIndex = selectedIndex
            self.billingHeaderView?.updateTabbar(index: selectedIndex)
        }
    }
}

extension FFBillingViewController : UITableViewDataSource,UITableViewDelegate,FFBillingDisplayCellDelegate,FFBillingAddCellDelegate,FFBillingBottomViewDelegate,FFSearchViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == tableView0) {
            return dataItems0.count
        }
        
        if (tableView == tableView1) {
            return dataItems1.count
        }
        
        return self.dataItems2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == tableView0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FFBillingDisplayCell0", for: indexPath) as! FFBillingDisplayCell
            cell.item0 = dataItems0[indexPath.row]
            cell.delegate = self
            cell.tableView = tableView0
            return cell
        }
        
        if (tableView == tableView1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FFBillingDisplayCell1", for: indexPath) as! FFBillingDisplayCell
            cell.item1 = dataItems1[indexPath.row]
            cell.delegate = self
            cell.tableView = tableView1
            return cell
        }

        if (tableView == tableView2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FFBillingAddCell", for: indexPath) as! FFBillingAddCell
            cell.item = dataItems2[indexPath.row]
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        IQKeyboardManager.shared.resignFirstResponder()
    }
    
    func billingDisplayCelladdBtnAction(sender: UIButton, tableView: UITableView) {
        allNum+=1
        debugPrint("====购物车总数量:\(allNum)")

        let model = FFShoppingCartModel()
        if (tableView == tableView0) {
            let indexPath = tableView.indexPath(for: sender.superview?.superview as! UITableViewCell)
            model.name = self.dataItems0[indexPath?.row ?? 0].productName
            model.price = self.dataItems0[indexPath?.row ?? 0].price1
            model.id = self.dataItems0[indexPath?.row ?? 0].stockId
            model.typeStr = "product"
            
            let item = self.dataItems0[indexPath?.row ?? 0]
            item.outPrice = model.price ?? 0
            item.smallSum = Float(Int(item.outPrice) * (item.discount / 100) * (item.qty - item.canPayQty));
            orderModel.productInfos.append(item)
            orderModel.productInfos = Array(Set(orderModel.productInfos))
            orderModel.productInfos = orderModel.productInfos.map { item in
                if (item.stockId == model.id) {
                    item.outPrice = model.price ?? 0
                    item.qty += 1
                    item.smallSum = Float(Int(item.outPrice) * (item.discount / 100) * (item.qty - item.canPayQty));
                }
                return item
            }
        }
        
        if (tableView == tableView1) {
            let indexPath = tableView.indexPath(for: sender.superview?.superview as! UITableViewCell)
            model.name = self.dataItems1[indexPath?.row ?? 0].itemName
            model.price = self.dataItems1[indexPath?.row ?? 0].price
            model.id = self.dataItems1[indexPath?.row ?? 0].itemId
            model.typeStr = "item"
            let item = self.dataItems1[indexPath?.row ?? 0]
            item.outPrice = model.price ?? 0
            item.smallSum = Float(Int(item.outPrice) * (item.discount / 100) * (item.qty - item.canPayQty));
            orderModel.itemInfos.append(item)
            orderModel.itemInfos = Array(Set(orderModel.itemInfos))
            orderModel.itemInfos = orderModel.itemInfos.map { item in
                if (item.itemId == model.id) {
                    item.outPrice = model.price ?? 0
                    item.qty += 1
                    item.smallSum = Float(Int(item.outPrice) * (item.discount / 100) * (item.qty - item.canPayQty));
                }
                return item
            }
        }
        
        dataItems2.append(model)
        dataItems2 = Array(Set(dataItems2))
                    
        dataItems2 = dataItems2.map { item in
            if (item.id == model.id) {
                item.num += 1
            }
            return item
        }
        
        
        self.billingHeaderView?.updateNum(num: allNum)
        self.billingBottomView?.update(model:orderModel)
        self.tableView2?.reloadData()
        debugPrint("====订单数据:\(String(describing: orderModel.toJSONString()))")
    }
    
    func updateItem(item: FFShoppingCartModel) {
        debugPrint("====更新FFShoppingCartModel内容:\(item.toJSONString() ?? "")")
        
        if (item.typeStr == "product") {
            orderModel.productInfos = orderModel.productInfos.filter({ model in
                model.qty = model.qty-1
                model.smallSum = Float(Int(model.outPrice) * (model.discount / 100) * (model.qty - model.canPayQty));
                if (model.qty  <= 0) {
                    return model.stockId != item.id
                }
                return true
            })
        }

        if (item.typeStr == "item" && !item.istemporary) {
            orderModel.itemInfos = orderModel.itemInfos.filter({ model in
                model.qty = model.qty-1
                model.smallSum = Float(Int(model.outPrice) * (model.discount / 100) * (model.qty - model.canPayQty));
                if (model.qty  <= 0) {
                    return model.itemId != item.id
                }
                return true
            })
        }
        
        if (item.typeStr == "item" && item.istemporary) {
            orderModel.itemInfos = orderModel.itemInfos.filter({ model in
                if (model.itemId == item.id) {
                    model.qty = model.qty-1
                    model.smallSum = Float(Int(model.outPrice) * (model.discount / 100) * (model.qty - model.canPayQty));
                    if (model.qty  <= 0) {
                        return model.itemId != item.id
                    }
                }
                return true
            })
        }
        
        if (item.num == 0) {
            dataItems2 = dataItems2.filter { model in
                model.num > 0
            }
            tableView2?.reloadData()
            return
        }
        
        dataItems2 = dataItems2.map { model in
            if (model.id == item.id) {
                model.num = item.num
            }
            return model
        }
        
        allNum = dataItems2.reduce(0) { $0 + $1.num}
        debugPrint("====购物车总数量:\(allNum)")
        self.billingHeaderView?.updateNum(num: allNum)
        self.billingBottomView?.update(model: orderModel)
        self.tableView2?.reloadData()
    }
    
    func saveBtnAction(sender:UIButton) {
        orderSaveOrCheckout()
    }
    
    func checkoutBtnAction(sender:UIButton) {
        orderSaveOrCheckout(isFormalOrder: true)
    }
    
    func searchViewSearchBtnActionWithParams(text:String) {
        debugPrint("====搜索内容:\(text)")
        productName = text
        if (selIndex == 0) {
            loadData0()
        } else {
            loadData1()
        }
    }
}

extension FFBillingViewController {
    
    func clickTopPopView(json:FFLicenseModelList) -> Void {
        let titles = json.data?.compactMap({ model in
            model.carNum
        })
        
        if (titles?.count == 0) {
            self.billingHeaderView?.updateContent(licenseModel: FFLicenseModel(),completion: { [weak self] in
                self?.updateFrame()
            })
            return
        }
        
        let property = FWMenuViewProperty()
        property.popupCustomAlignment = .topCenter
        property.popupAnimationType = .scale
        property.maskViewColor = UIColor.clear
        property.touchWildToHide = "1"
        property.popupViewEdgeInsets = UIEdgeInsets(top: (self.billingHeaderView?.textField.frame.maxY ?? 100) + getStatusBarAndNavigationBarHeight(), left: 0, bottom: 0, right: 0)
        property.topBottomMargin = 10
        property.animationDuration = 0.3
        property.popupArrowStyle = .none
        property.popupArrowVertexScaleX = 0.5
        property.cornerRadius = 5
        
        let menuView = FWMenuView.menu(itemTitles: titles, itemImageNames: nil, itemBlock: { (popupView, index, title) in
            debugPrint("Menu：点击了第\(index)个按钮")
            self.licenseModel = json.data?[index]
            self.billingHeaderView?.textField.text = json.data?[index].carNum
            IQKeyboardManager.shared.resignFirstResponder()
            self.billingHeaderView?.updateContent(licenseModel: json.data?[index] ?? FFLicenseModel(),completion: { [weak self] in
                self?.updateFrame()
            })
        }, property: property)
        menuView.show()
    }
    
    func updateFrame() -> Void {
        if (selIndex == 0 || selIndex == 1) {
            baseScrollView.frame = CGRect(x: 0, y: (billingHeaderView?.frame.size.height)!+(searchView?.frame.size.height)!, width: getScreenWidth(), height: getScreenHeight()-getTabBarHeight()-(billingHeaderView?.frame.size.height)!-(searchView?.frame.size.height)!)
            searchView?.isHidden = false
            self.baseScrollView.contentSize = CGSize(width: getScreenWidth()*CGFloat(billingArr().count), height: self.baseScrollView.frame.height)
            self.searchView?.frame = CGRect(x: 0, y: (self.billingHeaderView?.frame.size.height)!, width: getScreenWidth(), height: 50)
        } else {
            baseScrollView.frame = CGRect(x: 0, y: (billingHeaderView?.frame.size.height)!, width: getScreenWidth(), height: getScreenHeight()-getTabBarHeight()-(billingHeaderView?.frame.size.height)!)
            searchView?.isHidden = true
            self.baseScrollView.contentSize = CGSize(width: getScreenWidth()*CGFloat(billingArr().count), height: self.baseScrollView.frame.height)
            self.searchView?.frame = CGRect(x: 0, y: (self.billingHeaderView?.frame.size.height)!, width: getScreenWidth(), height: 50)
        }
        
        switch selIndex {
        case 0,1,3:
            self.tableView0?.frame = CGRect(x: CGFloat(self.selIndex ?? 0)*getScreenWidth(), y: 0, width: getScreenWidth(), height: self.baseScrollView.frame.height-getTabBarHeight()-110)
            self.tableView1?.frame = CGRect(x: getScreenWidth(), y: 0, width: getScreenWidth(), height: self.baseScrollView.frame.height-getTabBarHeight()-110)
            self.tableView2?.frame = CGRect(x: CGFloat(2)*getScreenWidth(), y: 0, width: getScreenWidth(), height: self.baseScrollView.frame.height-getTabBarHeight()-110)
        default:break
        }
        
        self.billingBottomView?.frame = CGRect(x: 0, y: (self.billingHeaderView?.frame.size.height ?? 131)+(self.searchView?.frame.size.height ?? 50) + self.baseScrollView.frame.height-getTabBarHeight()-110, width: getScreenWidth(), height: 110)
    }
    
    // 下拉刷新方法
    private func loadData0() {
        page0 = 1
        getStockInList()
    }

    // 上拉加载方法
    private func loadMoreData0() {
        page0 += 1
        getStockInList(isLoadMoreData: true)
    }
    
    // 下拉刷新方法
    private func loadData1() {
        page1 = 1
        getItemList()
    }

    // 上拉加载方法
    private func loadMoreData1() {
        page1 += 1
        getItemList(isLoadMoreData: true)
    }
}

extension FFBillingViewController {
    
    //搜索车牌信息
    func getBaseTypeList(textField: RZCarPlateNoTextField) -> Void {
        
        let parameters = [
            "type": "customer",
            "carNum":textField.text ?? "",
        ] as [String : Any]
        
        NetworkManager.shared.request(url: GetBaseTyoeList,
                                      method: .get,
                                      parameters: parameters,
                                      success: { (response: ResponseModel<FFLicenseModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            let json = JSONDeserializer<FFLicenseModelList>.deserializeFrom(json: response.jsonString)
            if (json?.status == 401) {FFUserManager.shared.logout()}
            
            debugPrint("====查询车牌号数据：\(String(describing: json?.toJSON()))")
            self.licenseModelList = json
            self.clickTopPopView(json: json ?? FFLicenseModelList())
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
    
    func getStockInList(isLoadMoreData:Bool = false) -> Void {
        let parameters = [
            "Page": page0,
            "PageSize":20,
            "productName":productName ?? ""
        ] as [String : Any]
        
        NetworkManager.shared.request(url: GetStockInList,
                                      method: .get,
                                      parameters: parameters,
                                      success: { (response: ResponseModel<FFStockModelList>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            if (isLoadMoreData) {
                if response.data?.items?.count ?? 0 < 10 {
                    // 已经加载完全部数据
                    self.tableView0?.mj_footer?.endRefreshingWithNoMoreData()
                    
                } else {
                    self.dataItems0 += response.data?.items ?? []
                    self.dataItems0 = self.dataItems0.compactMap { model in
                        model.qty = 0
                        return model
                    }
                    self.tableView0?.reloadData()
                    self.tableView0?.mj_footer?.endRefreshing()
                }
            } else {
                self.dataItems0 = response.data?.items ?? []
                self.dataItems0 = self.dataItems0.compactMap { model in
                    model.qty = 0
                    return model
                }
                self.tableView0?.reloadData()
                self.tableView0?.mj_header?.endRefreshing()
            }
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
    
    func getItemList(isLoadMoreData:Bool = false) -> Void {
        let parameters = [
            "Page": page1,
            "PageSize":20,
            "productName":productName ?? ""
        ] as [String : Any]
        
        NetworkManager.shared.request(url: GetItemList,
                                      method: .get,
                                      parameters: parameters,
                                      success: { (response: ResponseModel<FFItemModelList>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            if (isLoadMoreData) {
                if response.data?.items?.count ?? 0 < 10 {
                    // 已经加载完全部数据
                    self.tableView1?.mj_footer?.endRefreshingWithNoMoreData()
                    
                } else {
                    self.dataItems1 += response.data?.items ?? []
                    self.dataItems1 = self.dataItems1.compactMap { model in
                        model.qty = 0
                        return model
                    }
                    self.tableView1?.reloadData()
                    self.tableView1?.mj_footer?.endRefreshing()
                }
            } else {
                self.dataItems1 = response.data?.items ?? []
                self.tableView1?.reloadData()
                self.tableView1?.mj_header?.endRefreshing()
            }
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
    
    // 订单保存或结账
    func orderSaveOrCheckout(isFormalOrder:Bool? = false) -> Void {
        
        if (self.billingHeaderView?.textField.text == "" || self.billingHeaderView?.textField.text == nil) {
            ToastManager.shared.showToast(message: kLanguage("请填写车牌号码"),position: .center)
            return
        }
                
        if (self.billingHeaderView?.accountTXT.text == "" || self.billingHeaderView?.accountTXT.text == nil) {
                        
            if (self.licenseModel?.phone == "" || self.licenseModel?.phone == nil) {
                ToastManager.shared.showToast(message: kLanguage("请输入手机号"),position: .center)
                return
            }
        }
        
        orderModel.isFormalOrder = isFormalOrder ?? false
        let totalPrice = dataItems2.reduce(0.0) { $0 + (($1.price ?? 0.0) * Float($1.num)) }
        orderModel.actualAmount = totalPrice
        orderModel.customerId = self.licenseModel != nil ? self.licenseModel?.customerId : id
        let parameters = orderModel.toJSON()
        
        NetworkManager.shared.request(url: OrderSave,
                                      method: .post,
                                      parameters: parameters,
                                      success: { (response: ResponseModel<FFItemModelList>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            ToastManager.shared.showToast(message: response.message ?? "保存成功")
            if (self.orderModel.isFormalOrder == true) {
                self.allNum = 0
                self.dataItems2.removeAll()
                self.orderModel = FFOrderModel()
                self.billingHeaderView?.accountTXT.text = ""
                self.billingHeaderView?.textField.text = ""
                self.billingHeaderView?.updateNum(num: self.allNum)
                self.billingBottomView?.update(model: self.orderModel)
                self.tableView2?.reloadData()
            }
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
    
    func createCustomers() -> Void {
        let parameters = [
            "carNum": self.billingHeaderView?.textField.text ?? "",
            "phone":self.billingHeaderView?.accountTXT.text ?? "",
        ] as [String : Any]
        NetworkManager.shared.request(url: CreateCustomers,
                                      method: .post,
                                      parameters: parameters,
                                      success: { (response: ResponseModel<FFItemModelList>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            
            let json = JSONDeserializer<ResponseModel1>.deserializeFrom(json: response.jsonString)
            self.id = json?.data
            self.licenseModel = nil
            debugPrint("====保存用户：\(String(describing: response.message))")
            ToastManager.shared.showToast(message: kLanguage("保存成功"),position: .center)
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
    
    func getOrderDetailById(item:Item) -> Void {
        let parameters = [
            "OrderId": item.orderId,
        ]
        
        NetworkManager.shared.request(url: GetOrderDetailById,
                                      method: .get,
                                      parameters: parameters as [String : Any],
                                      success: { (response: ResponseModel<FFOrderModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            debugPrint("====获取订单详情数据：\(String(describing: response.data?.toJSONString()))")
            self.orderModel = response.data ?? FFOrderModel()
            var arr = Array<FFShoppingCartModel>()
            let itemArr = self.orderModel.itemInfos.map { item in
                let model = FFShoppingCartModel()
                model.id = item.itemId
                model.name = item.itemName
                model.price = item.price
                model.num = Int64(item.qty)
                model.typeStr = "item"
                return model
            }
            
            let productArr = self.orderModel.productInfos.map { item in
                let model = FFShoppingCartModel()
                model.id = item.stockId
                model.name = item.storeName
                model.price = item.price1
                model.num = Int64(item.qty)
                return model
            }
            arr = itemArr + productArr
            self.dataItems2 = arr
            self.tableView2?.reloadData()
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
}
