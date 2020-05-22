//
//  SalsesOrderDetailModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class SalsesOrderDetailModel: Mappable {
    var Code = ""
    var message = ""
    var Data : SalesOrderModel?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Data <- map["Data"]
    }
}

