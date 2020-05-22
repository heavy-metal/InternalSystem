//
//  BuyPayDetailModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class BuyPayDetailModel: Mappable {
    var Code = ""
    var message = ""
    var paymentModel : PaymentModel?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        paymentModel <- map["Data"]
    }
}
