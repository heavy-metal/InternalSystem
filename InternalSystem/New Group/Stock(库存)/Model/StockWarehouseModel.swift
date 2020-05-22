//
//  StockWarehouseModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/13.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class StockWarehouseModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [WarehouseModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class WarehouseModel : Mappable {
    var WhId = ""
    var WhName = ""
    var Contact = ""
    var Mobile = ""
    var Address = ""
    var Remark = ""
    var IsDefault = 0
    var IsLocked = 0
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        WhId <- map["WhId"]
        WhName <- map["WhName"]
        Contact <- map["Contact"]
        Mobile <- map["Mobile"]
        Address <- map["Address"]
        Remark <- map["Remark"]
        IsDefault <- map["IsDefault"]
        IsLocked <- map["IsLocked"]
        
    }
}
