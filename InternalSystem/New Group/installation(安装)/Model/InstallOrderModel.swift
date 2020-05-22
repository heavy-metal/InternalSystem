//
//  InstallOrderModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class InstallOrderModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [InstallModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class InstallModel: Mappable {
    var InstallOrderId = ""
    var InstallOrderNo = ""
    var BusiType = 0
    var ClientId = ""
    var ClientName = ""
    var Contact = ""
    var Mobile = ""
    var Address = ""
    var OrderId = ""
    var OrderNo = ""
    var ProdNames = ""
    var CreateUser = ""
    var CreateDate = ""
    var InstallerIds = ""
    var InstallerNames = ""
    var InstallState = 0
    var IsDel = 0
    var Remark = ""
    var installProductDetailArr : [installProductDetailModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        InstallOrderId <- map["InstallOrderId"]
        InstallOrderNo <- map["InstallOrderNo"]
        BusiType <- map["BusiType"]
        ClientId <- map["ClientId"]
        ClientName <- map["ClientName"]
        Contact <- map["Contact"]
        Mobile <- map["Mobile"]
        Address <- map["Address"]
        OrderId <- map["OrderId"]
        OrderNo <- map["OrderNo"]
        ProdNames <- map["ProdNames"]
        CreateUser <- map["CreateUser"]
        CreateDate <- map["CreateDate"]
        InstallerIds <- map["InstallerIds"]
        InstallerNames <- map["InstallerNames"]
        InstallState <- map["InstallState"]
        IsDel <- map["IsDel"]
        Remark <- map["Remark"]
        installProductDetailArr <- map["ProductDetail"]
    }
}
class installProductDetailModel : Mappable {
    var InstallOrderId = ""
    var ProdId = ""
    var ProdName = ""
    var Model = ""
    var Unit = ""
    var SerialNo = 0
    var DevId = ""
    var TerminalNo = ""
    var Sn = ""
    var IsInstalled = 0
    var InstallCar = 0
    var CarId = ""
    var LicNum = ""
    var InstallEmpId = ""
    var InstallEmpName = ""
    var InstallDate = ""
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        InstallOrderId <- map["InstallOrderId"]
        ProdId <- map["ProdId"]
        ProdName <- map["ProdName"]
        Model <- map["Model"]
        Unit <- map["Unit"]
        SerialNo <- map["SerialNo"]
        DevId <- map["DevId"]
        TerminalNo <- map["TerminalNo"]
        Sn <- map["Sn"]
        IsInstalled <- map["IsInstalled"]
        InstallCar <- map["InstallCar"]
        CarId <- map["CarId"]
        LicNum <- map["LicNum"]
        InstallEmpId <- map["InstallEmpId"]
        InstallEmpName <- map["InstallEmpName"]
        InstallDate <- map["InstallDate"]
    }
}
