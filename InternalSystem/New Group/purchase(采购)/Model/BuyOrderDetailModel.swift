//
//  BuyOrderDetailModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/12.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class BuyOrderDetailModel: Mappable {
    var Code = ""
    var message = ""
    var buyModel : BuyModel?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        buyModel <- map["Data"]
        
    }
}
