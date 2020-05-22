//
//  ProductDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
enum ProductType {
    case salsesOrder
    case salsesOrderForm
    case purchaseForm
    case buyForm
    case receiptOrder
    case InventoryInquiry
    case OutboundOrder
    case installOrder
    
}

class ProductDetailVC: UITableViewController {
    var salesFormModel : SalesFormModel?
    var model:SalesOrderModel?
    lazy var infoArray = [ProductModel]()
    lazy var formInfoArray = [ProductFormModel]()
    lazy var purchaseProductArray = [PurchaseProductModel]()
    lazy var buyDetailArray = [BuyDetailModel]()
    lazy var receiptDetailArray = [ReceiptDetailModel]()
    lazy var inventoryArray = [InventoryModel]()
    lazy var outboundproductDetailArray = [OutboundproductDetailModel]()
    lazy var installProductArray = [installProductDetailModel]()
    var productType:ProductType?
    var purchaseModel : PurchaseModel?
    var buyModel:BuyModel?
    var receiptModel:ReceiptModel?
    var inventoryModel:InventoryModel?
    var outBoundModel : OutboundModel?
    var installModel : InstallModel?
    var installProductModel : installProductDetailModel?
    var receModel : receDetailModel?
    var sellModel : SearchSellModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.show()
        
        getData()
    
        tableView.separatorStyle = .none
        tableView.rowHeight = 105
        tableView.register(UINib(nibName: "ClientInfoCell", bundle: nil), forCellReuseIdentifier: "productDetailVC")
        tableView.backgroundColor = UIColor.groupTableViewBackground
        if productType == .InventoryInquiry {self.title = "库存明细"}
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch productType {
        case .salsesOrder?:
            return infoArray.count
        case .salsesOrderForm?:
            return formInfoArray.count
        case .purchaseForm?:
            return self.purchaseProductArray.count
        case .buyForm?:
            return buyDetailArray.count
        case .receiptOrder?:
            return receiptDetailArray.count
        case .InventoryInquiry?:
            return inventoryArray.count
        case .OutboundOrder?:
            return outboundproductDetailArray.count
        case .installOrder?:
            return installProductArray.count
        
        default: return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productDetailVC", for: indexPath) as! ClientInfoCell
        switch productType {
        case .salsesOrder?:
            let infoModel = self.infoArray[indexPath.row]
            cell.clientNameLabel.text = infoModel.ProdName
            cell.contactLabel.text = "型号:\(infoModel.Model)"
            cell.phoneLabel.text = "¥\(infoModel.SellPrice)*\(infoModel.SellCount)" + infoModel.Unit
            cell.collectMoneyLabel.text = "¥\(infoModel.SellAmt)元"
        case .salsesOrderForm?:
            let model = self.formInfoArray[indexPath.row]
            cell.clientNameLabel.text = model.ProdName
            cell.contactLabel.text = "型号:" + (model.Model)
            cell.phoneLabel.text = "¥\(String(describing: model.SalePrice))*\(String(describing: model.SaleCount))" + model.Unit
            cell.collectMoneyLabel.text = "¥\(model.SaleAmt)元"
        case .purchaseForm?:
            let model = self.purchaseProductArray[indexPath.row]
            cell.clientNameLabel.text = model.ProdName
            cell.contactLabel.text = "型号:" + (model.Model)
            cell.phoneLabel.text = "¥\(String(describing: model.PurchPrice))*\(String(describing: model.PurchCount))" + model.Unit
            cell.collectMoneyLabel.text = "¥\(model.PurchAmt)元"
        case .buyForm?:
            let model = self.buyDetailArray[indexPath.row]
            cell.clientNameLabel.text = model.ProdName
            cell.contactLabel.text = "型号:" + (model.Model)
            cell.phoneLabel.text = "¥\(String(describing: model.BuyPrice))*\(String(describing: model.BuyCount))" + model.Unit
            cell.collectMoneyLabel.text = "¥\(model.BuyAmt)元"
        case .receiptOrder?:
            let model = self.receiptDetailArray[indexPath.row]
            cell.clientNameLabel.text = model.ProdName
            cell.contactLabel.text = "型号:" + (model.Model)
            cell.phoneLabel.text = "¥\(String(describing: model.InPrice))*\(String(describing: model.InCount))" + model.Unit
            cell.collectMoneyLabel.text = "¥\(model.InAmt)元"
        case .InventoryInquiry?:
            let model = self.inventoryArray[indexPath.row]
            cell.clientNameLabel.text = model.ProdName
            cell.contactLabel.text = "型号:" + (model.Model)
            cell.phoneLabel.text = "¥\(String(describing: model.CurCostPrice))*\(String(describing: model.CurStock))" + model.Unit
            cell.collectMoneyLabel.text = "¥\(model.CurAmount)元"
         case .OutboundOrder?:
            let model = self.outboundproductDetailArray[indexPath.row]
            cell.clientNameLabel.text = model.ProdName
            cell.contactLabel.text = "型号:" + (model.Model)
            cell.phoneLabel.text = "¥\(String(describing: model.OutPrice))*\(String(describing: model.OutCount))" + model.Unit
            cell.collectMoneyLabel.text = "¥\(model.OutAmt)元"
        case .installOrder?:
            let model = self.installProductArray[indexPath.row]
            cell.clientNameLabel.text = model.ProdName
            cell.contactLabel.text = "型号:" + (model.Model)
            cell.phoneLabel.text = model.LicNum
            cell.collectMoneyLabel.text = ""
        
        default:break
        }
       
        
        let lineview = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 5))
        lineview.backgroundColor = UIColor.groupTableViewBackground
        cell.addSubview(lineview)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let salesDetailVC = SalsesDetailVC()
        
        switch productType {
        case .salsesOrder?:
            salesDetailVC.detailType = .productDetail
            salesDetailVC.productModel = self.infoArray[indexPath.row]
            
        case .salsesOrderForm?:
            salesDetailVC.detailType = .productFormDetail
            salesDetailVC.productFormModel = self.formInfoArray[indexPath.row]
        case .purchaseForm?:
            salesDetailVC.detailType = .purchaseProductDetail
            salesDetailVC.purchaseProductModel = self.purchaseProductArray[indexPath.row]
        case .buyForm?:
            salesDetailVC.detailType = .buyProductDetail
            salesDetailVC.buyDetailModel = self.buyDetailArray[indexPath.row]
        case .InventoryInquiry?:
            salesDetailVC.detailType = .InventoryInquiry
            salesDetailVC.inventoryModel = self.inventoryArray[indexPath.row]
        case .OutboundOrder?:
            salesDetailVC.detailType = .OutboundProductDetail
            salesDetailVC.outboundDetailModel = self.outboundproductDetailArray[indexPath.row]
        case.installOrder?:
            salesDetailVC.detailType = .installProductDetail
            salesDetailVC.installProductModel = self.installProductArray[indexPath.row]
        default:break
        }
        self.navigationController?.pushViewController(salesDetailVC, animated: true)
    }

    
}
extension ProductDetailVC {
    fileprivate func getData() {
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            var params = ["UserId":userInfo["userId"]]
            switch productType {
            case .salsesOrder?:
                params["SellOrderId"] = model?.SellOrderId
                HomeNetWorkTool.GetSalesOderDetail(params: params as? [String : String], Success: { (array) in
                    
                    self.infoArray =  array
                    
                    self.tableView.reloadData()
                    
                }) { (error) in
                    
                }
            case .salsesOrderForm?:
                params["SaleOrderId"] = salesFormModel?.SaleOrderId
                HomeNetWorkTool.GetSaleOrderDetail(params: params as? [String : String], Success: { (array) in
                    self.formInfoArray = array
                    self.tableView.reloadData()
                }, Failure: { (error) in
                    
                })
            case .purchaseForm?:
                params["PurchOrderId"] = purchaseModel?.PurchOrderId
                PurchaseTool.GetPurchOrderDetail(params: params as? [String:String], Success: { (array) in
                    self.purchaseProductArray = array
                    self.tableView.reloadData()
                }, Failure: { (error) in
                    
                })
            case .buyForm?:
                params["BuyOrderId"] = buyModel?.BuyOrderId
                PurchaseTool.GetBuyOrderDetail(params: params as? [String : String], Success: { (array) in
                    self.buyDetailArray = array
                    self.tableView.reloadData()
                }, Failure: { (error) in
                    
                })
            case .receiptOrder?:
                params["InOrderId"] = receiptModel?.InOrderId
                StockTool.GetInOrderDetail(params: params as? [String : String], Success: { (array) in
                    self.receiptDetailArray = array
                    self.tableView.reloadData()
                }, Failure: { (error) in
                    
                })
            case .InventoryInquiry?:
                params["ProdId"] = inventoryModel?.ProdId
                StockTool.GetStockDetail(params: params as? [String : String], Success: { (array) in
                    
                    self.inventoryArray = array
                    self.tableView.reloadData()
                }, Failure: { (error) in
                    
                })
            case .OutboundOrder?:
                params["OutOrderId"] = outBoundModel?.OutOrderId
                StockTool.GetOutOrderDetail(params: params as? [String : String], Success: { (array) in
                    self.outboundproductDetailArray = array
                    self.tableView.reloadData()
                }, Failure: { (error) in
                    
                })
            case .installOrder?:
                params["InstallOrderId"] = installModel?.InstallOrderId
                StockTool.GetInstallOrderDetail(params: params as? [String : String], Success: { (array) in
                    self.installProductArray = array
                    self.tableView.reloadData()
                }, Failure: { (error) in
                    
                })
           
            default:break
            }
            
        
        }
        
    }
}
