//
//  SearchRequestVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/7.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
enum PurchaseSearchType {
    case supplierInfo
    case purchase
    case buyForm
    case stockProductInfo
    case receiptOrder
    case InventoryInquiry
    case OutboundOrder
    case EquipmentInfo
    case CarInfo
    case InstallationSheet
    case SellReceOrder
    case PaymentOrder
}
class SearchRequestVC: BaseTableViewVC {
    var purchaseSearchType:PurchaseSearchType?
    lazy var classIdArray : [String] = [String]()
    lazy var classNameArray : [String] = [String]()
    
    lazy var stockClassNameArray : [String] = [String]()
    lazy var stockClassIdArray : [String] = [String]()
    
    lazy var searchParams:[String:String] = [String:String]()
    lazy var supplierTitleArray = ["供应商分类","是否有欠款"]
    lazy var purchaseTitleArray = ["起始日期","结束日期","订单状态","是否显示已关闭订单"]
    lazy var orderStateArray = ["待审核","已审核","部分转销售","全部转销售"]
    lazy var array = ["否","是"]
    lazy var buyFormTitleArray = ["起始日期","结束日期","入库状态","是否有欠款","是否显示已作废单据"]
    lazy var stateArray = ["未入库","部分入库","全部入库"]
    lazy var stockTitleArray = ["产品分类","是否有库存","是否有需要安装"]
    
    lazy var receiptOrderTitleArray = ["起始日期","结束日期","业务类型"]
    lazy var businessTypeArray = ["进货","销售退货","调拔","借入","借出归还"]
    lazy var InventoryInquiryTitleArray = ["产品分类","是否有库存"]
    lazy var outboundOrderTitleArray = ["起始日期","结束日期","业务类型","是否显示已作废单据"]
    lazy var EquipmentInfoArray = ["起始日期","结束日期","服务收费状态"]
    lazy var feeStateArray = ["不收服务费","正常","过期"]
    lazy var InstallArray = ["起始日期","结束日期","安装状态","业务类型","是否显示已作废单据"]
    lazy var installStateArray = ["未安装","部分安装","全部安装"]
    lazy var installArray = ["销售安装"]
    lazy var SellReceArray = ["起始日期","结束日期","是否显示已作废单据"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "筛选"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(btnClick))
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = UIColor.groupTableViewBackground
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        if purchaseSearchType == .supplierInfo {getSupplierClass()}
        if purchaseSearchType == .stockProductInfo || purchaseSearchType == .InventoryInquiry {getProdClass()}
    }
    @objc fileprivate func btnClick() {
        
        self.searchController.isActive = false
        
        if  !self.searchParams.values.isEmpty {
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.setDefaultAnimationType(.native)
            SVProgressHUD.show()
        }
        self.navigationController?.popViewController(animated: true)
        switch self.purchaseSearchType {
        case .supplierInfo?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"supplierInfo"), object: self.searchParams)
        case .purchase?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"purchaseOrder"), object: self.searchParams)
        case .buyForm?:
             NotificationCenter.default.post(name: NSNotification.Name(rawValue:"buyForm"), object: self.searchParams)
        case .stockProductInfo?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"stockProductInfo"), object: self.searchParams)
        case .receiptOrder?:
             NotificationCenter.default.post(name: NSNotification.Name(rawValue:"receiptOrder"), object: self.searchParams)
        case .InventoryInquiry?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"InventoryInquiry"), object: self.searchParams)
        case .OutboundOrder?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"OutboundOrder"), object: self.searchParams)
        case .EquipmentInfo?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"EquipmentInfo"), object: self.searchParams)
        case .CarInfo?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"CarInfo"), object: self.searchParams)
        case .InstallationSheet?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"InstallationSheet"), object: self.searchParams)
        case .SellReceOrder?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"SellReceOrder"), object: self.searchParams)
        case .PaymentOrder?:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"PaymentOrder"), object: self.searchParams)
        default: break
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        searchController.isActive = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.purchaseSearchType {
        case .supplierInfo?:
            return supplierTitleArray.count
        case .purchase?:
            return purchaseTitleArray.count
        case .buyForm?:
            return buyFormTitleArray.count
        case .stockProductInfo?:
            return stockTitleArray.count
        case .receiptOrder?:
            return receiptOrderTitleArray.count
        case .InventoryInquiry?:
            return InventoryInquiryTitleArray.count
        case .OutboundOrder?:
            return outboundOrderTitleArray.count
        case .EquipmentInfo?:
            return EquipmentInfoArray.count
        case .CarInfo?:
            return 1
        case .InstallationSheet?:
            return InstallArray.count
        case .SellReceOrder?:
            return SellReceArray.count
        case .PaymentOrder?:
            return SellReceArray.count
        default:
            return 0
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "filterCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "filterCell")
            cell?.selectionStyle = .none
            cell?.accessoryType = .disclosureIndicator
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            switch self.purchaseSearchType {
            case .supplierInfo?:
                cell?.textLabel?.text = supplierTitleArray[indexPath.row]
            case .purchase?:
                cell?.textLabel?.text = purchaseTitleArray[indexPath.row]
            case .buyForm?:
                cell?.textLabel?.text = buyFormTitleArray[indexPath.row]
            case .stockProductInfo?:
                cell?.textLabel?.text = stockTitleArray[indexPath.row]
            case .receiptOrder?:
                cell?.textLabel?.text = receiptOrderTitleArray[indexPath.row]
            case .InventoryInquiry?:
                cell?.textLabel?.text = InventoryInquiryTitleArray[indexPath.row]
            case .OutboundOrder?:
                cell?.textLabel?.text = outboundOrderTitleArray[indexPath.row]
            case .EquipmentInfo?:
                cell?.textLabel?.text = EquipmentInfoArray[indexPath.row]
            case .CarInfo?:
                cell?.textLabel?.text = "是否有安装申请"
            case .InstallationSheet?:
                cell?.textLabel?.text = InstallArray[indexPath.row]
            case .SellReceOrder?:
                cell?.textLabel?.text = SellReceArray[indexPath.row]
            case .PaymentOrder?:
                cell?.textLabel?.text = SellReceArray[indexPath.row]
            default:break
            }
            
            cell?.detailTextLabel?.text = "请选择"
        }
        let lineView = UIView(frame: CGRect(x: 0, y: 44-1, width: SCREEN_WIDTH, height: 1))
        lineView.backgroundColor = UIColor.groupTableViewBackground
        cell?.addSubview(lineView)
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchController.searchBar.resignFirstResponder()
        let cell = tableView.cellForRow(at: indexPath)
        switch indexPath.row {
        case 0:
            switch self.purchaseSearchType {
            case .supplierInfo?:
                BRStringPickerView.showStringPicker(withTitle: supplierTitleArray[indexPath.row], dataSource: classNameArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.classNameArray.index(of: str as! String)!
                    let classid = self?.classIdArray[index!]
                    self?.searchParams["ClassId"] = classid
                })
            case .purchase?:
                BRDatePickerView.showDatePicker(withTitle: purchaseTitleArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["PurchDateBegin"] = str
                })
            case .buyForm?:
                BRDatePickerView.showDatePicker(withTitle: buyFormTitleArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self](str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["BuyDateBegin"] = str
                })
            case .stockProductInfo?:
                BRStringPickerView.showStringPicker(withTitle: stockTitleArray[indexPath.row], dataSource: stockClassNameArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.stockClassNameArray.index(of: str as! String)!
                    self?.searchParams["ClassId"] = self?.stockClassIdArray[index!]
                })
            case .receiptOrder?:
                BRDatePickerView.showDatePicker(withTitle: receiptOrderTitleArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["InDateBegin"] = str
                })
            case .InventoryInquiry?:
                BRStringPickerView.showStringPicker(withTitle: InventoryInquiryTitleArray[indexPath.row], dataSource: stockClassNameArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.stockClassNameArray.index(of: str as! String)!
                    self?.searchParams["ClassId"] = self?.stockClassIdArray[index!]
                })
            case . OutboundOrder?:
                BRDatePickerView.showDatePicker(withTitle: outboundOrderTitleArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["OutDateBegin"] = str
                })
            case .EquipmentInfo?:
                BRDatePickerView.showDatePicker(withTitle: EquipmentInfoArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["InstallDateBegin"] = str
                })
             case .CarInfo?:
                BRStringPickerView.showStringPicker(withTitle: "是否有安装申请", dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["HadApply"] = "\(index ?? 0)"
                })
            case .InstallationSheet?:
                BRDatePickerView.showDatePicker(withTitle: InstallArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["CreateDateBegin"] = str
                })
            case .SellReceOrder?:
                BRDatePickerView.showDatePicker(withTitle: SellReceArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["ReceDateBegin"] = str
                })
            case .PaymentOrder?:
                BRDatePickerView.showDatePicker(withTitle: SellReceArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["PayDateBegin"] = str
                })
            default:break
            }
            
            
        case 1:
            switch self.purchaseSearchType {
            case .supplierInfo?:
                BRStringPickerView.showStringPicker(withTitle: supplierTitleArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: {[weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["HadFee"] = "\(index ?? 0)"
                })
            case .purchase?:
                BRDatePickerView.showDatePicker(withTitle: purchaseTitleArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["PurchDateEnd"] = str
                })
            case .buyForm?:
                BRDatePickerView.showDatePicker(withTitle: buyFormTitleArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self](str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["BuyDateEnd"] = str
                })
            case .stockProductInfo?:
                BRStringPickerView.showStringPicker(withTitle: stockTitleArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["HadQuantity"] = "\(index ?? 0)"
                })
            case .receiptOrder?:
                BRDatePickerView.showDatePicker(withTitle: receiptOrderTitleArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["InDateEnd"] = str
                })
            case .InventoryInquiry?:
                BRStringPickerView.showStringPicker(withTitle: InventoryInquiryTitleArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["HadQuantity"] = "\(index ?? 0)"
                })
            case . OutboundOrder?:
                BRDatePickerView.showDatePicker(withTitle: outboundOrderTitleArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["OutDateEnd"] = str
                })
            case .EquipmentInfo?:
                BRDatePickerView.showDatePicker(withTitle: EquipmentInfoArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["InstallDateEnd"] = str
                })
            case .InstallationSheet?:
                BRDatePickerView.showDatePicker(withTitle: InstallArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["CreateDateEnd"] = str
                })
            case .SellReceOrder?:
                BRDatePickerView.showDatePicker(withTitle: SellReceArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["ReceDateEnd"] = str
                })
            case .PaymentOrder?:
                BRDatePickerView.showDatePicker(withTitle: SellReceArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str
                    self?.searchParams["PayDateEnd"] = str
                })
            default: break
            }
        case 2:
            switch self.purchaseSearchType {
            case .purchase?:
                BRStringPickerView.showStringPicker(withTitle: purchaseTitleArray[indexPath.row], dataSource: orderStateArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: {[weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.orderStateArray.index(of: str as! String)!
                    self?.searchParams["OrderState"] = "\(index! + 1)"
                })
            case .buyForm?:
                BRStringPickerView.showStringPicker(withTitle: buyFormTitleArray[indexPath.row], dataSource: stateArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: {[weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.stateArray.index(of: str as! String)!
                    self?.searchParams["ToStockState"] = "\(index! + 1)"
                })
            case .stockProductInfo?:
                BRStringPickerView.showStringPicker(withTitle: stockTitleArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["NeedInstall"] = "\(index ?? 0)"
                })
            case .receiptOrder?:
                BRStringPickerView.showStringPicker(withTitle: receiptOrderTitleArray[indexPath.row], dataSource: businessTypeArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.businessTypeArray.index(of: str as! String)!
                    self?.searchParams["BusiType"] = "\(index! + 1 )"
                })
            case . OutboundOrder?:
                BRStringPickerView.showStringPicker(withTitle: outboundOrderTitleArray[indexPath.row], dataSource: businessTypeArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.businessTypeArray.index(of: str as! String)!
                    self?.searchParams["BusiType"] = "\(index! + 1 )"
                })
            case .EquipmentInfo?:
                BRStringPickerView.showStringPicker(withTitle: EquipmentInfoArray[indexPath.row], dataSource: feeStateArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.feeStateArray.index(of: str as! String)!
                    self?.searchParams["FeeState"] = "\(index ?? 0)"
                })
            case .InstallationSheet?:
                BRStringPickerView.showStringPicker(withTitle: InstallArray[indexPath.row], dataSource: installStateArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.installStateArray.index(of: str as! String)!
                    self?.searchParams["InstallState"] = "\(index! + 1)"
                })
            case .SellReceOrder?,.PaymentOrder?:
                BRStringPickerView.showStringPicker(withTitle: SellReceArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["ShowDel"] = "\(index ?? 0)"
                })
            default:break
            }
            
        case 3:
            switch self.purchaseSearchType {
            case .purchase?:
                BRStringPickerView.showStringPicker(withTitle: purchaseTitleArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: {[weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["ShowClose"] = "\(index ?? 0)"
                })
            case .buyForm?:
                BRStringPickerView.showStringPicker(withTitle: outboundOrderTitleArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: {[weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["HadFee"] = "\(index ?? 0)"
                })
            case . OutboundOrder?:
                BRStringPickerView.showStringPicker(withTitle: outboundOrderTitleArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["ShowDel"] = "\(index ?? 0)"
                })
            case .InstallationSheet?:
                BRStringPickerView.showStringPicker(withTitle: InstallArray[indexPath.row], dataSource: installArray, defaultSelValue: nil, isAutoSelect: false, resultBlock: { [weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.installArray.index(of: str as! String)!
                    self?.searchParams["BusiType"] = "\(index! + 1)"
                })
            default: break
            }
        case 4:
            switch self.purchaseSearchType {
            case.buyForm?:
                BRStringPickerView.showStringPicker(withTitle: buyFormTitleArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: {[weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["ShowDel"] = "\(index ?? 0)"
                })
            case .InstallationSheet?:
                BRStringPickerView.showStringPicker(withTitle: InstallArray[indexPath.row], dataSource: array, defaultSelValue: nil, isAutoSelect: false, resultBlock: {[weak self] (str) in
                    cell?.detailTextLabel?.text = str as? String
                    let index = self?.array.index(of: str as! String)!
                    self?.searchParams["ShowDel"] = "\(index ?? 0)"
                })
            default: break
            }
            
        default: break
        }
    }
}
extension SearchRequestVC {
    fileprivate func getSupplierClass () {
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            AlamofireTool.getRequest(URLString: supplierClassUrl, params: ["UserId":userInfo["userId"] ?? ""], success: { (result) in
                if let array = result["Data"] as? NSArray {
                    for dic in array {
                        self.classIdArray.append((dic as! [String:String])["ClassId"]!)
                        self.classNameArray.append((dic as! [String:String])["ClassName"]!)
                    }
                }
                
            }, Failure: { (error) in
                SVProgressHUD.showError(withStatus: error as! String)
                SVProgressHUD.dismiss(withDelay: 2)
            })
        }
    }
    fileprivate func getProdClass() {
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            AlamofireTool.getRequest(URLString: ProdClassUrl, params: ["UserId":userInfo["userId"] ?? ""], success: { (result) in
                if let array = result["Data"] as? NSArray {
                    for dic in array {
                        self.stockClassIdArray.append((dic as! [String:String])["ClassId"]!)
                        self.stockClassNameArray.append((dic as! [String:String])["ClassName"]!)
                    }
                }
            }, Failure: { (error) in
                SVProgressHUD.showError(withStatus: error as! String)
                SVProgressHUD.dismiss(withDelay: 2)
            })
        }
    }
    
}
extension SearchRequestVC : UISearchResultsUpdating ,UISearchBarDelegate,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.count == 0 {return}
        self.searchParams["SearchText"] = searchController.searchBar.text
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.btnClick()
    }
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
    
}
