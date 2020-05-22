//
//  SellReceDetailModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class SellReceDetailModel: Mappable {
    var Code = ""
    var message = ""
    var sellModel : SearchSellModel?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        sellModel <- map["Data"]
    }
}
