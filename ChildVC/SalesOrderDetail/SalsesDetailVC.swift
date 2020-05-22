//
//  SalsesDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
enum DetailType {
    case salsesDetail
    case productDetail
    case salsesFormDetail
    case productFormDetail
    case supplierInfo
    case purchaseDetail
    case purchaseProductDetail
    case buyFormDetail
    case buyProductDetail
    case stockProductDetail
    case receiptOrder
    case InventoryInquiry
    case OutboundOrder
    case OutboundProductDetail
    case EquipmentInfo
    case CarInfo
    case installDetail
    case installProductDetail
    case SellReceOrderDetail
    case PaymentOrderDetail
}

class SalsesDetailVC: UITableViewController {
    var salesFormModel : SalesFormModel?
    var model : SalesOrderModel?
    var detailType : DetailType?
    var productModel : ProductModel?
    var productFormModel : ProductFormModel?
    var supplierModel:SupplierModel?
    var purchaseModel : PurchaseModel?
    var purchaseProductModel : PurchaseProductModel?
    var buyModel:BuyModel?
    var buyDetailModel:BuyDetailModel?
    var stockProductModel:StockProductModel?
    var receiptModel : ReceiptModel?
    var inventoryModel:InventoryModel?
    var outboundModel: OutboundModel?
    var outboundDetailModel : OutboundproductDetailModel?
    var equipmentModel : EquipmentModel?
    var carModel : CarModel?
    var installModel : InstallModel?
    var installProductModel : installProductDetailModel?
    var sellModel : SearchSellModel?
    var paymentModel : PaymentModel?
    
    lazy var btn : UIButton = {
        var btn = UIButton(frame: CGRect(x: 0, y: 50, width: 65, height: 30))
        btn.setImage(UIImage(named:"btn_navBack.png"), for: .normal)
        btn.addTarget(self, action: #selector(popClick), for: .touchUpInside)
        return btn
    }()
    lazy var outStockArray = ["未出库","部分出库","全部出库"]
    
    lazy var toInstallStateArr = ["不需安装","未转安装","部分转安装","全部转安装"]
    
    lazy var arr = ["否","是"]
    
    lazy var OrderStateArray = ["待审核","已审核","部分转销售","全部转销售"]
    
    lazy var section0TitleArray = ["客户名称","单据编号","出库仓库名称","业务日期","经手人","制单人","制单日期","产品名称"]
    lazy var section1TitleArray = ["产品合计金额","优惠","其他费用","总计金额","实收金额","欠款金额"]
    lazy var section2TitleArray = ["出库状态","转安装状态","备注","关联的销售订单","是否已关闭"]
    

     lazy var section0ProductTitleArray = ["产品名称","型号"]
    lazy var section1ProductTitleArray = ["单价","数量","金额","成本单价"]
    lazy var section2ProductTitleArray = ["已出库数量","是否需要安装","已转安装单数量"]
    
    lazy var section0SalesFormTitleArray = ["客户名称","单据编号","业务日期","经手人","制单人","制单日期","产品名称"]
    lazy var section1SalesFormTitleArray = ["产品合计金额","优惠","其他费用","总计金额"]
    lazy var section2SalesFormTitleArray = ["订单状态","备注","是否已关闭"]
    
    lazy var section0SalesFormInfoArray = [salesFormModel?.ClientName,salesFormModel?.SaleOrderNo,salesFormModel?.SaleDate,salesFormModel?.SaleUser,salesFormModel?.CreateUser,salesFormModel?.CreateDate,salesFormModel?.ProdNames]
    lazy var section1SalesFormInfoArray = ["\(salesFormModel?.SaleAmt ?? 0)元","\(salesFormModel?.DiscountAmt ?? 0)元","\(salesFormModel?.OtherFee ?? 0)元","\(salesFormModel?.TotalAmt ?? 0)元"]
    lazy var section2SalesFormInfoArray = [OrderStateArray[(salesFormModel?.OrderState)!-1],salesFormModel?.Remark,arr[(salesFormModel?.IsDel)!]]
    
    lazy var productInfoArray = [productModel?.ProdName ?? "",productModel?.Model ?? "","\(productModel?.SellPrice ?? 0)元","\(productModel?.SellCount ?? 0)台","\(productModel?.SellAmt ?? 0)元","\(productModel?.CostPrice ?? 0)元","\(productModel?.OutStockCount ?? 0)",arr[(productModel?.NeedInstall ?? 0)!],"\(productModel?.ToInstallCount ?? 0)"]
    
    lazy var section0ProductInfoArray = [productModel?.ProdName ?? "",productModel?.Model ?? ""]
    lazy var section1ProductInfoArray = ["\(productModel?.SellPrice ?? 0)元","\(productModel?.SellCount ?? 0)台","\(productModel?.SellAmt ?? 0)元","\(productModel?.CostPrice ?? 0)元"]
     lazy var section2ProductInfoArray = ["\(productModel?.OutStockCount ?? 0)",arr[(productModel?.NeedInstall ?? 0)!],"\(productModel?.ToInstallCount ?? 0)"]
    
    
     lazy var section0InfoArray:[String] = [model?.ClientName ?? "",model?.SellOrderNo ?? "",model?.WhName ?? "",model?.SellDate ?? "",model?.SellUser ?? "",model?.CreateUser ?? "",model?.CreateDate ?? "",model?.ProdNames ?? ""]
    lazy var section1InfoArray:[String] = ["\(model?.SellAmt ?? 0)元", "\(model?.DiscountAmt ?? 0)元","\(model?.OtherFee ?? 0)元","\(model?.TotalAmt ?? 0)元","\( model?.RealReceAmt ?? 0)元","\(model?.UnpaidAmt ?? 0)元"]
    lazy var section2InfoArray:[String] = [outStockArray[(model?.OutStockState)!-1],toInstallStateArr[(model?.ToInstallState)!],model?.Remark ?? "",model?.SaleOrderId ?? "",arr[(model?.IsDel)!]]
    
    lazy var section0ProductFormTitleArray = ["产品名称","型号"]
    lazy var section1ProductFormTitleArray = ["单价","数量","金额"]
    lazy var section2ProductFormTitleArray = ["已转销售数量"]
    lazy var section0ProductFormArray = [productFormModel?.ProdName ?? "",productFormModel?.Model ?? ""]
    
    lazy var section1ProductFormArray = ["\(productFormModel?.SalePrice ?? 0)元","\(productFormModel?.SaleCount ?? 0)台","\(productFormModel?.SaleAmt ?? 0)元"]
    
    lazy var section0SupplierTitleArray = ["供应商编码","供应商名称","供应商分类名称"]
    lazy var section1SupplierTitleArray = ["单位电话","联系人","联系人职务","联系电话","传真","邮箱","QQ","地址","备注"]
    lazy var section2SupplierTitleArray = ["期初欠款","应付欠款"]
    lazy var section0SupplierInfoArray = [supplierModel?.SupplierCode,supplierModel?.SupplierName,supplierModel?.ClassName]
    lazy var section1SupplierInfoArray = [supplierModel?.Tel,supplierModel?.Contact,supplierModel?.Position,supplierModel?.Mobile,supplierModel?.Fax,supplierModel?.Email,supplierModel?.QQ,supplierModel?.Address,supplierModel?.Remark]
    lazy var section2SupplierInfoArray = ["\(supplierModel?.InitPayAmt ?? 0)元","\(supplierModel?.PayAmt ?? 0)元"]
    
    lazy var section0PurchaseTitleArray = ["单据编号","供应商名称","业务日期","经手人","制单人","制单日期","产品名称"]
    lazy var section1PurchaseTitleArray = ["产品合计金额","税额","其他费用","总计金额"]
    lazy var section2PurchaseTitleArray = ["订单状态","备注","是否已关闭"]
    
    lazy var section0PurchaseInfoArray = [purchaseModel?.PurchOrderNo,purchaseModel?.SupplierName,purchaseModel?.PurchDate,purchaseModel?.PurchUser,purchaseModel?.CreateUser,purchaseModel?.CreateDate,purchaseModel?.ProdNames]
    lazy var section1PurchaseInfoArray = ["\(purchaseModel?.PurchAmt ?? 0)元","\(purchaseModel?.TaxAmt ?? 0)元","\(purchaseModel?.OtherFee ?? 0)元","\(purchaseModel?.TotalAmt ?? 0)元"]
    lazy var section2PurchaseInfoArray = [OrderStateArray[(purchaseModel?.OrderState)!-1],purchaseModel?.Remark,arr[(purchaseModel?.IsDel)!]]
    lazy var section0PurchaseProductTitlteArray = ["产品名称","型号"]
    lazy var section1PurchaseProductTitlteArray = ["单价","数量","金额","税率","税额","税后金额"]
    lazy var section2PurchaseProductTitlteArray = ["已转进货数量"]
    lazy var section0PurchaseProductInfoArray = [purchaseProductModel?.ProdName,purchaseProductModel?.Model]
    lazy var section1PurchaseProductInfoArray = ["\(purchaseProductModel?.PurchPrice ?? 0)元","\(purchaseProductModel?.PurchCount ?? 0)\(purchaseProductModel?.Unit ?? "")","\(purchaseProductModel?.PurchAmt ?? 0)元","\(purchaseProductModel?.TaxRate ?? 0)元","\(purchaseProductModel?.TaxAmt ?? 0)元","\(purchaseProductModel?.AfterTaxAmt ?? 0)元"]
    lazy var section2PurchaseProductInfoArray = ["\(purchaseProductModel?.ToBuyCount ?? 0)"]
    
    lazy var section0BuyFormTitleArray = ["单据编号","供应商名称","入库仓库名称","业务日期","经手人","制单人","制单日期","产品名称"]
    lazy var section1BuyFormTitleArray = ["产品合计金额","税额","其他费用","总计金额","实付金额","欠款金额"]
    lazy var section2BuyFormTitleArray = ["入库状态","备注","是否已作废"]
    lazy var section0BuyFormInfoArray = [buyModel?.BuyOrderNo,buyModel?.SupplierName,buyModel?.WhName,buyModel?.BuyDate,buyModel?.BuyUser,buyModel?.CreateUser,buyModel?.CreateDate,buyModel?.ProdNames]
    lazy var section1BuyFormInfoArray = ["\(buyModel?.BuyAmt ?? 0)元","\(buyModel?.TaxAmt ?? 0)元","\(buyModel?.OtherFee ?? 0)元","\(buyModel?.TotalAmt ?? 0)元","\(buyModel?.RealPayAmt ?? 0)元","\(buyModel?.UnpaidAmt ?? 0)元"]
    lazy var section2BuyFormInfoArray = [outStockArray[(buyModel?.ToStockState)!-1],buyModel?.Remark,arr[(buyModel?.IsDel)!]]
    lazy var section0BuyProductTitleArray = ["产品名称","型号"]
    lazy var section1BuyProductTitleArray = ["单价","数量","金额","税率","税额","税后金额"]
    lazy var section2BuyProductTitleArray = ["已入库数量"]
    lazy var section0BuyProductInfoArray = [buyDetailModel?.ProdName,buyDetailModel?.Model]
    lazy var section1BuyProductInfoArray = ["\(buyDetailModel?.BuyPrice ?? 0)元","\(buyDetailModel?.BuyCount ?? 0)\(buyDetailModel?.Unit ?? "")","\(buyDetailModel?.BuyAmt ?? 0)元","\(buyDetailModel?.TaxRate ?? 0)","\(buyDetailModel?.TaxAmt ?? 0)元","\(buyDetailModel?.AfterTaxAmt ?? 0)元"]
    lazy var section2BuyProductInfoArray = ["\(buyDetailModel?.ToStockCount ?? 0)"]
    
    lazy var section0StockProductTitleArray = ["产品编码","产品名称","产品分类名称","产品分组","规格型号","生产厂家","厂家编号"]
    lazy var section1StockProductTitleArray = ["参考进货价","销售单价"]
    lazy var section2StockProductTitleArray = ["库存下限","是否需要安装","是否计服务费","是否安装车辆","是否需要安装申请","需出安装证明","备注","待入库数","待出库数","当前库存数","当前库存金额","总入库数","总出库数"]
    lazy var section0StockProductInfoArray = [stockProductModel?.ProdCode,stockProductModel?.ProdName,stockProductModel?.ClassName,stockProductModel?.ProdGroup,stockProductModel?.Model,stockProductModel?.Vender,stockProductModel?.VenderNo]
    lazy var section1StockProductInfoArray = ["\(stockProductModel?.BuyPrice ?? 0)元","\(stockProductModel?.SalePrice ?? 0)元"]

    lazy var section2StockProductInfoArray:[String] = ["\(stockProductModel?.MinNum ?? 0)\(stockProductModel?.Unit ?? "")",arr[(stockProductModel?.NeedInstall)!],arr[(stockProductModel?.NeedFee)!],arr[(stockProductModel?.InstallCar)!],arr[(stockProductModel?.InstallApply)!],arr[(stockProductModel?.InstallCert)!],(stockProductModel?.Remark)!,"\(stockProductModel?.WInStock ?? 0)","\(stockProductModel?.WOutStock ?? 0)","\(stockProductModel?.CurStock ?? 0)","\(stockProductModel?.CurAmount ?? 0)元","\(stockProductModel?.InStock ?? 0)","\(stockProductModel?.OutStock ?? 0)"]
    lazy var businessTypeArray = ["进货","销售退货","调拔","借入","借出归还"]
    lazy var section0ReceiptTitleArray = ["单据编号","仓库名称"]
    lazy var section1ReceiptTitleArray = ["业务类型","往来单位名称","关联单据编号","业务日期","经手人","制单人","制单日期","产品名称"]
    lazy var section2ReceiptTitleArray = ["备注","是否已作废"]
    lazy var section0ReceiptInfoArray = [receiptModel?.InOrderNo,receiptModel?.WhName]
    lazy var section1ReceiptInfoArray = [businessTypeArray[((receiptModel?.BusiType)!-1)],receiptModel?.ObjName,receiptModel?.OrderNo,receiptModel?.InDate,receiptModel?.InUser,receiptModel?.CreateUser,receiptModel?.CreateDate,receiptModel?.ProdNames]
    lazy var section2ReceiptInfoArray = [receiptModel?.Remark,arr[(receiptModel?.IsDel)!]]
    lazy var section0InventoryTitleArray = ["产品名称","规格型号"]
    lazy var section1InventoryTitleArray = ["仓库名称","待入库数","待出库数","当前库存数"]
    lazy var section2InventoryTitleArray = ["当前成本价","当前库存金额","总入库数","总出库数"]
    lazy var section0InventoryInfoArray = [inventoryModel?.ProdName,inventoryModel?.Model]
    lazy var section1InventoryInfoArray  = [inventoryModel?.WhName,"\(inventoryModel?.WInStock ?? 0)","\(inventoryModel?.WOutStock ?? 0)","\(inventoryModel?.CurStock ?? 0)"]
    lazy var section2InventoryInfoArray  = ["\(inventoryModel?.CurCostPrice ?? 0)元","\(inventoryModel?.CurAmount ?? 0)元","\(inventoryModel?.InStock ?? 0)","\(inventoryModel?.OutStock ?? 0)"]
    lazy var section0OutBoundTitleArray = ["单据编号","仓库名称"]
    lazy var section1OutBoundTitleArray = ["业务类型","往来单位名称","关联单据编号","业务日期","经手人","制单人","制单日期","产品名称"]
    lazy var section2OutBoundTitleArray = ["备注","是否已作废"]
    lazy var section0OutBoundInfoArray = [outboundModel?.OutOrderNo,outboundModel?.WhName]
    lazy var section1OutBoundInfoArray = [businessTypeArray[(outboundModel?.BusiType)!-1],outboundModel?.ObjName,outboundModel?.OrderNo,outboundModel?.OutDate,outboundModel?.OutUser,outboundModel?.CreateUser,outboundModel?.CreateDate,outboundModel?.ProdNames]
    lazy var section2OutBoundInfoArray = [outboundModel?.Remark,arr[(outboundModel?.IsDel)!]]
    lazy var section0OutBoundProductTitleArray = ["产品名称","规格型号"]
    lazy var section1OutBoundProductTitleArray = ["单价","数量","金额"]
    lazy var section2OutBoundProductTitleArray = ["成本单价"]
    lazy var section0OutBoundProductInfoArray = [outboundDetailModel?.ProdName,outboundDetailModel?.Model]
    lazy var section1OutBoundProductInfoArray = ["\(outboundDetailModel?.OutPrice ?? 0)元","\(outboundDetailModel?.OutCount ?? 0)","\(outboundDetailModel?.OutAmt ?? 0)元"]
     lazy var section2OutBoundProductInfoArray = ["\(outboundDetailModel?.CostPrice ?? 0)元"]
    
    lazy var section0EquipmentTitleArray = ["客户名称","产品名称"]
    lazy var section1EquipmentTitleArray = ["规格型号","设备编号","设备序列号","车牌号","SIM卡号","安装人员姓名"]
    lazy var section2EquipmentTitleArray = ["安装日期","服务收费状态","服务费开始日期","服务费结束日期","备注"]
    lazy var feeStateArray = ["不收服务费","正常","过期"]
    lazy var section0EquipmentInfoArray = [equipmentModel?.ClientName,equipmentModel?.ProdName]
    lazy var section1EquipmentInfoArray = [equipmentModel?.Model,equipmentModel?.TerminalNo,equipmentModel?.Sn,equipmentModel?.LicNum,equipmentModel?.SIM,equipmentModel?.InstallEmpName]
    lazy var section2EquipmentInfoArray = [equipmentModel?.InstallDate,feeStateArray[(equipmentModel?.FeeState)!],equipmentModel?.FeeBegin,equipmentModel?.FeeEnd,equipmentModel?.Remark]
    lazy var section0CarTitleArray = ["客户名称","车牌号"]
    lazy var section1CarTitleArray = ["是否有安装申请","车架号","发动机号"]
    lazy var section2CarTitleArray = ["车牌颜色","车辆型号","备注"]
    lazy var colorTypeArray = ["蓝色","黄色","黑色","白色","绿色","其他"]
    lazy var section0CarInfoArray = [carModel?.ClientName,carModel?.LicNum]
    lazy var section1CarInfoArray = [arr[(carModel?.HadApply)!],carModel?.FraNum,carModel?.EngNum]
    lazy var section2CarInfoArray = [colorTypeArray[(carModel?.PlateColor)!-1],carModel?.Model,carModel?.Remark]
    lazy var section0InstallTitleArray = ["单据编号","业务类型"]
    lazy var section1InstallTitleArray = ["客户名称","联系人","联系电话","安装地址","关联单据编号","产品名称","制单人","制单日期"]
    lazy var section2InstallTitleArray = ["安装人员","安装状态","备注","是否已作废"]
    lazy var section0InstallInfoArray = [installModel?.InstallOrderNo,"销售安装"]
    lazy var installStateArray = ["未安装","部分安装","全部安装"]
    lazy var section1InstallInfoArray = [installModel?.ClientName,installModel?.Contact,installModel?.Mobile,installModel?.Address,installModel?.OrderNo,installModel?.ProdNames,installModel?.CreateUser,installModel?.CreateDate]
    lazy var section2InstallInfoArray = [installModel?.InstallerNames,installStateArray[(installModel?.InstallState)!-1],installModel?.Remark,arr[(installModel?.IsDel)!]]
    lazy var section0InstallProductTitleArray = ["产品名称","规格型号"]
    lazy var section1InstallProductTitleArray = ["设备编号","设备序列号","是否已安装","是否安装车辆","车牌号"]
    lazy var section2InstallProductTitleArray = ["安装人员","安装日期"]
    lazy var section0InstallProductInfoArray = [installProductModel?.ProdName,installProductModel?.Model]
    lazy var section1InstallProductInfoArray = [installProductModel?.TerminalNo,installProductModel?.Sn,arr[(installProductModel?.IsInstalled)!],arr[installProductModel!.InstallCar],installProductModel?.LicNum]
    lazy var section2InstallProductInfoArray = [installProductModel?.InstallEmpName,installProductModel?.InstallDate]
    lazy var section0SellTitleArray = ["单据编号","客户名称"]
    lazy var section1SellTitleArray = ["应收金额","优惠","实收金额"]
    lazy var section2SellTitleArray = ["结算账户名称","收款日期","经手人","制单人","制单日期","备注","是否已作废"]
    lazy var section0SellInfoArray = [sellModel?.SellReceNo,sellModel?.ClientName]
    lazy var section1SellInfoArray = ["\(sellModel?.TotalAmt ?? 0)元","\(sellModel?.DiscountAmt ?? 0)元","\(sellModel?.RealReceAmt ?? 0)元"]
    lazy var section2SellInfoArray = [sellModel?.AccountName,sellModel?.ReceDate,sellModel?.ReceUser,sellModel?.CreateUser,sellModel?.CreateDate,sellModel?.Remark,arr[(sellModel?.IsDel)!]]
    lazy var section0PaymentTitleArray = ["单据编号","供应商名称"]
    lazy var section1PaymentTitleArray = ["应付金额","优惠","实付金额"]
    lazy var section2PaymentTitleArray = ["结算账户名称","付款日期","经手人","制单人","制单日期","备注","是否已作废"]
    lazy var section0PaymentInfoArray = [paymentModel?.BuyPayNo,paymentModel?.SupplierName]
    lazy var section1PaymentInfoArray = ["\(paymentModel?.TotalAmt ?? 0)元","\(paymentModel?.DiscountAmt ?? 0)元","\(paymentModel?.RealPayAmt ?? 0)元"]
    lazy var section2PaymentInfoArray = [paymentModel?.AccountName,paymentModel?.PayDate,paymentModel?.PayUser,paymentModel?.CreateUser,paymentModel?.CreateDate,paymentModel?.Remark,arr[(paymentModel?.IsDel)!]]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.bounces = false
        view.backgroundColor = UIColor.groupTableViewBackground
        if detailType == .CarInfo {self.title = "车辆信息详情"}
        if detailType == .EquipmentInfo {self.title = "设备信息详情"}
        if detailType == .supplierInfo {self.title = "供应商详情"}
        if detailType == .productDetail || detailType == .productFormDetail || detailType == .purchaseProductDetail || detailType == .stockProductDetail{
            self.title = "产品详情"
        }else{
            if detailType == .supplierInfo {return}
            let headview = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 5))
            headview.backgroundColor = UIColor.groupTableViewBackground
            tableView.tableHeaderView = headview
        }
        if detailType == .stockProductDetail,stockProductModel?.ProdImages != "" {
            let headerView = StockHeaderView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: HeadViewHeight))
           
            tableView.tableHeaderView = headerView
            
            headerView.addSubview(btn)
            
            headerView.stockProductModel = stockProductModel
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        if detailType != .stockProductDetail {return}
        if stockProductModel?.ProdImages != "" {
            
            automaticallyAdjustsScrollViewInsets = false
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//            navigationController?.navigationBar.shadowImage = UIImage()
//            navigationController?.navigationBar.subviews.first?.alpha = 0
//            titleColorChange(alpha: 0)
           
            navigationController?.navigationBar.barStyle = .black
            tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
            navigationController?.navigationBar.alpha = 0
            
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        if detailType != .stockProductDetail {return}
        if stockProductModel?.ProdImages != ""{
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.alpha = 1
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 0}
        return 20
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view1 = UIView()
        view1.backgroundColor = UIColor.groupTableViewBackground
        return view1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            switch detailType {
            case .salsesDetail?:
                return section0TitleArray.count
            case .productDetail?:
                return section0ProductTitleArray.count
            case .salsesFormDetail?:
                return section0SalesFormTitleArray.count
            case .productFormDetail?:
                return section0ProductFormTitleArray.count
            case .supplierInfo?:
                return section0SupplierTitleArray.count
            case .purchaseDetail?:
                return section0PurchaseTitleArray.count
            case.purchaseProductDetail?:
                return section0PurchaseProductTitlteArray.count
            case .buyFormDetail?:
                return section0BuyFormTitleArray.count
            case .buyProductDetail?:
                return section0BuyProductTitleArray.count
            case .stockProductDetail?:
                return section0StockProductTitleArray.count
            case .receiptOrder?:
                return section0ReceiptTitleArray.count
            case .InventoryInquiry?:
                return section0InventoryTitleArray.count
            case .OutboundOrder?:
                return section0OutBoundTitleArray.count
            case .OutboundProductDetail?:
                return section0OutBoundProductTitleArray.count
            case .EquipmentInfo?:
                return section0EquipmentTitleArray.count
            case .CarInfo?:
                return section0CarTitleArray.count
            case .installDetail?:
                return section0InstallTitleArray.count
            case .installProductDetail?:
                return section0InstallProductTitleArray.count
            case .SellReceOrderDetail?:
                return section0SellTitleArray.count
            case .PaymentOrderDetail?:
                return section0PaymentTitleArray.count
            default: return 0
            }
            
        case 1:
            switch detailType {
            case .salsesDetail?:
                return section1TitleArray.count
            case .productDetail?:
                return section1ProductTitleArray.count
            case .salsesFormDetail?:
                return section1SalesFormTitleArray.count
            case .productFormDetail?:
                return section1ProductFormTitleArray.count
            case .supplierInfo?:
                return section1SupplierTitleArray.count
            case .purchaseDetail?:
                return section1PurchaseTitleArray.count
            case.purchaseProductDetail?:
                return section1PurchaseProductTitlteArray.count
            case .buyFormDetail?:
                return section1BuyFormTitleArray.count
            case .buyProductDetail?:
                return section1BuyProductTitleArray.count
            case .stockProductDetail?:
                return section1StockProductTitleArray.count
            case .receiptOrder?:
                return section1ReceiptTitleArray.count
            case .InventoryInquiry?:
                return section1InventoryTitleArray.count
            case .OutboundOrder?:
                return section1OutBoundTitleArray.count
            case .OutboundProductDetail?:
                return section1OutBoundProductTitleArray.count
            case .EquipmentInfo?:
                return section1EquipmentTitleArray.count
            case .CarInfo?:
                return section1CarTitleArray.count
            case .installDetail?:
                return section1InstallTitleArray.count
            case .installProductDetail?:
                return section1InstallProductTitleArray.count
            case .SellReceOrderDetail?:
                return section1SellTitleArray.count
            case .PaymentOrderDetail?:
                return section1PaymentTitleArray.count
            default: return 0
            }
            
        default:
            switch detailType {
            case .salsesDetail?:
                return section2TitleArray.count
            case .productDetail?:
                return section2ProductTitleArray.count
            case .salsesFormDetail?:
                return section2SalesFormTitleArray.count
            case .productFormDetail?:
                return 1
            case .supplierInfo?:
                return section2SupplierTitleArray.count
            case .purchaseDetail?:
                return section2PurchaseTitleArray.count
            case.purchaseProductDetail?:
                return section2PurchaseProductTitlteArray.count
            case .buyFormDetail?:
                return section2BuyFormTitleArray.count
            case .buyProductDetail?:
                return section2BuyProductTitleArray.count
            case .stockProductDetail?:
                return section2StockProductTitleArray.count
            case .receiptOrder?:
                return section2ReceiptTitleArray.count
            case .InventoryInquiry?:
                return section2InventoryTitleArray.count
            case .OutboundOrder?:
                return section2OutBoundTitleArray.count
            case .OutboundProductDetail?:
                return section2OutBoundProductTitleArray.count
            case .EquipmentInfo?:
                return section2EquipmentTitleArray.count
            case .CarInfo?:
                return section2CarTitleArray.count
            case .installDetail?:
                return section2InstallTitleArray.count
            case .installProductDetail?:
                return section2InstallProductTitleArray.count
            case .SellReceOrderDetail?:
                return section2SellTitleArray.count
            case .PaymentOrderDetail?:
                return section2PaymentTitleArray.count
            default: return 0
            }
        }
}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell?.selectionStyle = .none
//            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
            switch indexPath.section {
            case 0:
                switch detailType {
                case .salsesDetail?:
                    cell?.textLabel?.text = section0TitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0InfoArray[indexPath.row]
                case .productDetail?:
                    cell?.textLabel?.text = section0ProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0ProductInfoArray[indexPath.row]
                case .salsesFormDetail?:
                    cell?.textLabel?.text = section0SalesFormTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0SalesFormInfoArray[indexPath.row]
                case .productFormDetail?:
                    cell?.textLabel?.text = section0ProductFormTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0ProductFormArray[indexPath.row]
                case .supplierInfo?:
                    cell?.textLabel?.text = section0SupplierTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0SupplierInfoArray[indexPath.row]
                case .purchaseDetail?:
                    cell?.textLabel?.text = section0PurchaseTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0PurchaseInfoArray[indexPath.row]
                case.purchaseProductDetail?:
                    cell?.textLabel?.text = section0PurchaseProductTitlteArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0PurchaseProductInfoArray[indexPath.row]
                case .buyFormDetail?:
                    cell?.textLabel?.text = section0BuyFormTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0BuyFormInfoArray[indexPath.row]
                case .buyProductDetail?:
                    cell?.textLabel?.text = section0BuyProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0BuyProductInfoArray[indexPath.row]
                case .stockProductDetail?:
                    cell?.textLabel?.text = section0StockProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0StockProductInfoArray[indexPath.row]
                case .receiptOrder?:
                    cell?.textLabel?.text = section0ReceiptTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0ReceiptInfoArray[indexPath.row]
                case .InventoryInquiry?:
                    cell?.textLabel?.text = section0InventoryTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0InventoryInfoArray[indexPath.row]
                case .OutboundOrder?:
                    cell?.textLabel?.text = section0OutBoundTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0OutBoundInfoArray[indexPath.row]
                case .OutboundProductDetail?:
                    cell?.textLabel?.text = section0OutBoundProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0OutBoundProductInfoArray[indexPath.row]
                case .EquipmentInfo?:
                    cell?.textLabel?.text = section0EquipmentTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0EquipmentInfoArray[indexPath.row]
                case .CarInfo?:
                    cell?.textLabel?.text = section0CarTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0CarInfoArray[indexPath.row]
                case .installDetail?:
                    cell?.textLabel?.text = section0InstallTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0InstallInfoArray[indexPath.row]
                case .installProductDetail?:
                    cell?.textLabel?.text = section0InstallProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0InstallProductInfoArray[indexPath.row]
                case .SellReceOrderDetail?:
                    cell?.textLabel?.text = section0SellTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0SellInfoArray[indexPath.row]
                case .PaymentOrderDetail?:
                    cell?.textLabel?.text = section0PaymentTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section0PaymentInfoArray[indexPath.row]
                default: break
                }
                
            case 1:
                switch detailType {
                case .salsesDetail?:
                    cell?.textLabel?.text = section1TitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1InfoArray[indexPath.row]
                case .productDetail?:
                    cell?.textLabel?.text = section1ProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1ProductInfoArray[indexPath.row]
                case .salsesFormDetail?:
                    cell?.textLabel?.text = section1SalesFormTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1SalesFormInfoArray[indexPath.row]
                case .productFormDetail?:
                    cell?.textLabel?.text = section1ProductFormTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1ProductFormArray[indexPath.row]
                case .supplierInfo?:
                    cell?.textLabel?.text = section1SupplierTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1SupplierInfoArray[indexPath.row]
                case .purchaseDetail?:
                    cell?.textLabel?.text = section1PurchaseTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1PurchaseInfoArray[indexPath.row]
                case.purchaseProductDetail?:
                    cell?.textLabel?.text = section1PurchaseProductTitlteArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1PurchaseProductInfoArray[indexPath.row]
                case .buyFormDetail?:
                    cell?.textLabel?.text = section1BuyFormTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1BuyFormInfoArray[indexPath.row]
                case .buyProductDetail?:
                    cell?.textLabel?.text = section1BuyProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1BuyProductInfoArray[indexPath.row]
                case .stockProductDetail?:
                    cell?.textLabel?.text = section1StockProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1StockProductInfoArray[indexPath.row]
                case .receiptOrder?:
                    cell?.textLabel?.text = section1ReceiptTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1ReceiptInfoArray[indexPath.row]
                case .InventoryInquiry?:
                    cell?.textLabel?.text = section1InventoryTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1InventoryInfoArray[indexPath.row]
                case .OutboundOrder?:
                    cell?.textLabel?.text = section1OutBoundTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1OutBoundInfoArray[indexPath.row]
                case .OutboundProductDetail?:
                    cell?.textLabel?.text = section1OutBoundProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1OutBoundProductInfoArray[indexPath.row]
                case .EquipmentInfo?:
                    cell?.textLabel?.text = section1EquipmentTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1EquipmentInfoArray[indexPath.row]
                case .CarInfo?:
                    cell?.textLabel?.text = section1CarTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1CarInfoArray[indexPath.row]
                case .installDetail?:
                    cell?.textLabel?.text = section1InstallTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1InstallInfoArray[indexPath.row]
                case .installProductDetail?:
                    cell?.textLabel?.text = section1InstallProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1InstallProductInfoArray[indexPath.row]
                case .SellReceOrderDetail?:
                    cell?.textLabel?.text = section1SellTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1SellInfoArray[indexPath.row]
                case .PaymentOrderDetail?:
                    cell?.textLabel?.text = section1PaymentTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section1PaymentInfoArray[indexPath.row]
                default: break
                }
                
            default:
                switch detailType {
                case .salsesDetail?:
                    cell?.textLabel?.text = section2TitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2InfoArray[indexPath.row]
                case .productDetail?:
                    cell?.textLabel?.text = section2ProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2ProductInfoArray[indexPath.row]
                case .salsesFormDetail?:
                    cell?.textLabel?.text = section2SalesFormTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2SalesFormInfoArray[indexPath.row]
                case .productFormDetail?:
                    cell?.textLabel?.text = section2ProductFormTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = "\(productFormModel?.ToSellCount ?? 0)"
                case .supplierInfo?:
                    cell?.textLabel?.text = section2SupplierTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2SupplierInfoArray[indexPath.row]
                case .purchaseDetail?:
                    cell?.textLabel?.text = section2PurchaseTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2PurchaseInfoArray[indexPath.row] 
                case.purchaseProductDetail?:
                    cell?.textLabel?.text = section2PurchaseProductTitlteArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2PurchaseProductInfoArray[indexPath.row]
                case .buyFormDetail?:
                    cell?.textLabel?.text = section2BuyFormTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2BuyFormInfoArray[indexPath.row]
                case .buyProductDetail?:
                    cell?.textLabel?.text = section2BuyProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2BuyProductInfoArray[indexPath.row]
                case .stockProductDetail?:
                    cell?.textLabel?.text = section2StockProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2StockProductInfoArray[indexPath.row]
                case .receiptOrder?:
                    cell?.textLabel?.text = section2ReceiptTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2ReceiptInfoArray[indexPath.row]
                case .InventoryInquiry?:
                    cell?.textLabel?.text = section2InventoryTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2InventoryInfoArray[indexPath.row]
                case .OutboundOrder?:
                    cell?.textLabel?.text = section2OutBoundTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2OutBoundInfoArray[indexPath.row]
                case .OutboundProductDetail?:
                    cell?.textLabel?.text = section2OutBoundProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2OutBoundProductInfoArray[indexPath.row]
                case .EquipmentInfo?:
                    cell?.textLabel?.text = section2EquipmentTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2EquipmentInfoArray[indexPath.row]
                case .CarInfo?:
                    cell?.textLabel?.text = section2CarTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2CarInfoArray[indexPath.row]
                case .installDetail?:
                    cell?.textLabel?.text = section2InstallTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2InstallInfoArray[indexPath.row]
                case .installProductDetail?:
                    cell?.textLabel?.text = section2InstallProductTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2InstallProductInfoArray[indexPath.row]
                case .SellReceOrderDetail?:
                    cell?.textLabel?.text = section2SellTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2SellInfoArray[indexPath.row]
                case .PaymentOrderDetail?:
                    cell?.textLabel?.text = section2PaymentTitleArray[indexPath.row]
                    cell?.detailTextLabel?.text = section2PaymentInfoArray[indexPath.row]
                default: break
                }
                
            }

        }
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 1))
        lineView.backgroundColor = UIColor.groupTableViewBackground
        cell?.addSubview(lineView)
        
        return cell!
    }
}
extension SalsesDetailVC {
    fileprivate func titleColorChange(alpha:CGFloat) {

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.gray.withAlphaComponent(alpha)]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(leftBtnImgString: "btn_navBack.png", target: self, action: #selector(popClick), CALLBACK: { (btn) in
            if alpha >= 0.9 {
                btn.setImage(UIImage(named: "backBtn.png"), for: .normal)
                navigationController?.navigationBar.barStyle = .default
            
            }else{
                navigationController?.navigationBar.barStyle = .black
            }
        })
    }
    @objc private func popClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension SalsesDetailVC {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if detailType != .stockProductDetail {return}
        if stockProductModel?.ProdImages == "" {return}
        let offsetY = scrollView.contentOffset.y
        
        
//        self.navigationController?.navigationBar.subviews.first?.alpha = offsetY/CGFloat(HeadViewHeight-64)
         self.navigationController?.navigationBar.alpha = offsetY/CGFloat(HeadViewHeight-64)
        if offsetY <= 22 {self.navigationController?.navigationBar.alpha=0}
//        titleColorChange(alpha: offsetY/CGFloat(HeadViewHeight-64))
        navigationController?.navigationBar.barStyle = offsetY > 20 ? .default : .black
        if offsetY < 20 {scrollView.contentOffset.y = 20}
        btn.isHidden = offsetY > 20
    }
}
