//
//  ReceiptProductDetailModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/14.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class ReceiptProductDetailModel: Mappable {
    var Code = ""
    var message = ""
    var receiptModel : ReceiptModel?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        receiptModel <- map["Data"]
    }
}
