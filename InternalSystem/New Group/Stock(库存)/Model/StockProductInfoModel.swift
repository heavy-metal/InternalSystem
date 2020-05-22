//
//  StockProductVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/12.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class StockProductInfoModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [StockProductModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class StockProductModel: Mappable {
    var ProdId = ""
    var ProdCode = ""
    var ProdName = ""
    var ClassId = ""
    var ClassName = ""
    var ProdGroup = ""
    var Model = ""
    var Vender = ""
    var VenderNo = ""
    var Unit = ""
    var BuyPrice = 0.0
    var SalePrice = 0.0
    var MinNum = 0.0
    var ProdImages = ""
    var AttachFiles = ""
    var NeedInstall = 0
    var NeedFee = 0
    var InstallCar = 0
    var InstallApply = 0
    var InstallCert = 0
    var Remark = ""
    var WInStock = 0.0
    var WOutStock = 0.0
    var CurStock = 0.0
    var CurAmount = 0.0
    var InStock = 0.0
    var OutStock = 0.0
    required init?(map: Map){}
    
    func mapping(map: Map){
        ProdId <- map["ProdId"]
        ProdCode <- map["ProdCode"]
        ProdName <- map["ProdName"]
        ClassId <- map["ClassId"]
        ClassName <- map["ClassName"]
        ProdGroup <- map["ProdGroup"]
        Model <- map["Model"]
        Vender <- map["Vender"]
        VenderNo <- map["VenderNo"]
        Unit <- map["Unit"]
        BuyPrice <- map["BuyPrice"]
        SalePrice <- map["SalePrice"]
        MinNum <- map["MinNum"]
        ProdImages <- map["ProdImages"]
        AttachFiles <- map["AttachFiles"]
        NeedInstall <- map["NeedInstall"]
        NeedFee <- map["NeedFee"]
        InstallCar <- map["InstallCar"]
        InstallApply <- map["InstallApply"]
        InstallCert <- map["InstallCert"]
        Remark <- map["Remark"]
        WInStock <- map["WInStock"]
        WOutStock <- map["WOutStock"]
        CurStock <- map["CurStock"]
        CurAmount <- map["CurAmount"]
        InStock <- map["InStock"]
        OutStock <- map["OutStock"]
    }
}
