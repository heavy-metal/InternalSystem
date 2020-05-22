//
//  CarInfoModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/15.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class CarInfoModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [CarModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class CarModel: Mappable {
    var CarId = ""
    var ClientId = ""
    var ClientName = ""
    var LicNum = ""
    var HadApply = 0
    var FraNum = ""
    var EngNum = ""
    var PlateColor = 0
    var Model = ""
    var Remark = ""
   
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        CarId <- map["CarId"]
        ClientId <- map["ClientId"]
        ClientName <- map["ClientName"]
        LicNum <- map["LicNum"]
        HadApply <- map["HadApply"]
        FraNum <- map["FraNum"]
        EngNum <- map["EngNum"]
        PlateColor <- map["PlateColor"]
        Model <- map["Model"]
        Remark <- map["Remark"]
        
        
    }
}
