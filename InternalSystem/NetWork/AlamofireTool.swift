//
//  AlamofireTool.swift
//  InternalSystem
//
//  Created by gail on 2018/1/31.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import Alamofire
public typealias Success = (_ response:[String : Any])->()
public typealias Failure = (_ error : Error)->()

class AlamofireTool: NSObject {
    
    private override init(){}
}
extension AlamofireTool {
    
    class func getRequest(URLString:String,params:[String:Any]? = nil,success: @escaping Success ,Failure:@escaping Failure ) {
        
        
        
        Alamofire.request(URLString, method: .get, parameters: params).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value as? [String: Any] {
                    success(value)
                }
            case .failure(let error):
                Failure(error)
            }
            
        }
    }
    class func backReLoginVC(){
        UIApplication.shared.keyWindow?.rootViewController = LoginViewControllor()
    }
}
