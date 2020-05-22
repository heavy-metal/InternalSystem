//
//  Const.swift
//  InternalSystem
//
//  Created by gail on 2018/1/31.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

let GlobalColor : UIColor = {
    return  UIColor(red: 0/255.0, green: 171/255.0, blue: 235/255.0, alpha: 1)
}()

let SCREEN_WIDTH = UIScreen.main.bounds.width

let SCREEN_HEIGHT = UIScreen.main.bounds.height
//http://125.89.196.8:2080  http://192.168.0.21:2080
let IPADRESS = "http://125.89.196.8:2080"

let PORT = "/MobileHttp.aspx?Cmd="

let NavBarHeight = SCREEN_HEIGHT == 812.0 ? 88 : 64

let HeadViewHeight = 250
//个人信息模块

let userLoginUrl = IPADRESS + PORT + "UserLogin&LoginType=3"

let changePwdUrl = IPADRESS + PORT + "ChangePwd"

let AppModuleUrl = IPADRESS + PORT + "GetAppModule"

let UpdateUmTokenUrl = IPADRESS + PORT + "UpdateUmToken"

//销售模块

let HadFunRightUrl = IPADRESS + PORT + "GetHadFunRight" //查询权限

let salesModuleID = "E054AF52-AA64-4868-B1C7-19ADA5E6F0B9"

let purchaseModuleID = "2D86E5F9-C443-4ADB-B742-8795155B93D7"

let stockModuleID = "898C1AEF-0CF2-4040-8242-69E1D60A14E0"

let installationModuleID = "BDEC1E2A-5513-44A1-8AC1-1193A757D35F"

let FinanceModuleID = "ED74603E-F90E-447C-9467-84E272D8993E"

let ClientInfoUrl = IPADRESS + PORT + "SearchClient&PageSize=10" 

let salesOderUrl = IPADRESS + PORT + "SearchSellOrder&PageSize=10"

let salesOderDetailUrl = IPADRESS + PORT + "GetSellOrderDetail"

let SearchSaleOrderUrl = IPADRESS + PORT + "SearchSaleOrder&PageSize=10"

let GetSaleOrderDetailUrl = IPADRESS + PORT + "GetSaleOrderDetail"

//采购模块
let SearchSupplierUrl = IPADRESS + PORT + "SearchSupplier&PageSize=10"

let supplierClassUrl = IPADRESS + PORT + "SupplierClass"

let searchPurchOrderUrl = IPADRESS + PORT + "SearchPurchOrder&PageSize=10"

let getPurchOrderDetailUrl = IPADRESS + PORT + "GetPurchOrderDetail"

let SearchBuyOrderUrl = IPADRESS + PORT + "SearchBuyOrder&PageSize=10"

let GetBuyOrderDetailUrl = IPADRESS + PORT + "GetBuyOrderDetail"

//库存模块
let SearchProductUrl = IPADRESS + PORT + "SearchProduct&PageSize=10"

let ProdClassUrl  = IPADRESS + PORT + "ProdClass"

let SearchWarehouseUrl = IPADRESS + PORT + "SearchWarehouse&PageSize=10"

let SearchInOrderUrl = IPADRESS + PORT + "SearchInOrder&PageSize=10"

let GetInOrderDetailUrl = IPADRESS + PORT + "GetInOrderDetail"

let SearchStockUrl = IPADRESS + PORT + "SearchStock&PageSize=10"

let GetStockDetailUrl = IPADRESS + PORT + "GetStockDetail"

let SearchOutOrderUrl = IPADRESS + PORT + "SearchOutOrder&PageSize=10"

let GetOutOrderDetailUrl = IPADRESS + PORT + "GetOutOrderDetail"

let SearchDeviceUrl = IPADRESS + PORT + "SearchDevice&PageSize=10"

let SearchCarUrl = IPADRESS + PORT + "SearchCar&PageSize=10"

let SearchInstallOrderUrl = IPADRESS + PORT + "SearchInstallOrder&PageSize=10"

let GetInstallOrderDetailUrl = IPADRESS + PORT + "GetInstallOrderDetail"

//财务模块
let SearchSellReceUrl = IPADRESS + PORT + "SearchSellRece&PageSize=10"

let GetSellReceDetailUrl = IPADRESS + PORT + "GetSellReceDetail"

let SearchAccountUrl = IPADRESS + PORT + "SearchAccount&PageSize=10"

let SearchBuyPayUrl = IPADRESS + PORT + "SearchBuyPay&PageSize=10"

let GetBuyPayDetailUrl = IPADRESS + PORT + "GetBuyPayDetail"
