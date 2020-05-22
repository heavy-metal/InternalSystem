//
//  EquipmentInfoModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/15.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class EquipmentInfoModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [EquipmentModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class EquipmentModel:Mappable {
    var DevId = ""
    var ClientId = ""
    var ClientName = ""
    var ProdId = ""
    var ProdName = ""
    var Model = ""
    var Unit = ""
    var TerminalNo = ""
    var Sn = ""
    var CarId = ""
    var LicNum = ""
    var SIM = ""
    var InstallEmpId = ""
    var InstallEmpName = ""
    var InstallDate = ""
    var FeeState = 0
    var FeeBegin = ""
    var FeeEnd = ""
    var Remark = ""
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        DevId <- map["DevId"]
        ClientId <- map["ClientId"]
        ClientName <- map["ClientName"]
        ProdId <- map["ProdId"]
        ProdName <- map["ProdName"]
        Model <- map["Model"]
        Unit <- map["Unit"]
        TerminalNo <- map["TerminalNo"]
        Sn <- map["Sn"]
        CarId <- map["CarId"]
        LicNum <- map["LicNum"]
        SIM <- map["SIM"]
        InstallEmpId <- map["InstallEmpId"]
        InstallEmpName <- map["InstallEmpName"]
        InstallDate <- map["InstallDate"]
        FeeState <- map["FeeState"]
        FeeBegin <- map["FeeBegin"]
        FeeEnd <- map["FeeEnd"]
        Remark <- map["Remark"]
        
    }
}
