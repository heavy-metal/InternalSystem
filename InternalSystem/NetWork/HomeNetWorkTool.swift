import UIKit

class HomeNetWorkTool: AlamofireTool {
    
    class func getLoginInfo (params:[String:String]? ,Success:@escaping (_ model:LoginModel,_ message:String?)->() ,Failure:@escaping Failure) {
        
        AlamofireTool.getRequest(URLString: userLoginUrl, params: params, success: { (result) in
            
            guard let model = LoginInfoModel(JSON: result) else{
                return
            }
            if model.message == "成功" {
                 Success(model.loginModel! ,model.message)
            }else {
                SVProgressHUD.showError(withStatus: model.message)
                SVProgressHUD.dismiss(withDelay: 2)
            }
        }) { (error) in
            Failure(error)
        }
    }
    class func GetAppModule(parentId:String ,Success:@escaping (_ array:[ModuleModel])->() ,Failure:@escaping Failure) {
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            
            AlamofireTool.getRequest(URLString: AppModuleUrl, params: ["UserId":userInfo["userId"]! ,"ParentId":parentId], success: { (result) in
                if result["Code"] as! String == "1"{
                    guard let model = AppModuleModel(JSON: result) else {return}
                    Success(model.Data!)
                }else{
                    SVProgressHUD.showError(withStatus: result["Message"] as! String)
                    SVProgressHUD.dismiss(withDelay: 2)
                }
                
            }, Failure: { (error) in
                
            })
        }
    }
    
    class func SearchClient(params:[String:String]? ,Success:@escaping (Page,[ClientModel])->() ,Failure:@escaping Failure) {
        
        AlamofireTool.getRequest(URLString: ClientInfoUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let clientInfoModel = ClientInfoModel(JSON: result) else {return}
            
            Success(clientInfoModel.page!,clientInfoModel.array!)
            
            }) { (error) in
                SVProgressHUD.showError(withStatus: error as! String)
                SVProgressHUD.dismiss(withDelay: 2)
            }
    }
    
    
    class func SearchSellOrder(params:[String:String]? ,Success:@escaping (Page,[SalesOrderModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: salesOderUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let salesOrderInfoModel = SalesOrderInfoModel(JSON: result) else {return}
            
            Success(salesOrderInfoModel.page!,salesOrderInfoModel.array!)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as! String)
            SVProgressHUD.dismiss(withDelay: 2)
            
        }
    }
//    salesOderDetailUrl
    class func GetSalesOderDetail(params:[String:String]? ,Success:@escaping ([ProductModel])->() ,Failure:@escaping Failure) {
    
        AlamofireTool.getRequest(URLString: salesOderDetailUrl, params: params, success: { (result) in

            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
           guard let salsesOrderDetailModel = SalsesOrderDetailModel(JSON: result) else {return}
            
            
            SVProgressHUD.dismiss()
            Success((salsesOrderDetailModel.Data?.productArray)!)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchSaleOrder (params:[String:String]? ,Success:@escaping (Page,[SalesFormModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchSaleOrderUrl, params: params, success: { (result) in
            
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            SVProgressHUD.dismiss()
            guard let model = Sales0rderFormModel(JSON: result) else {return}
            Success(model.page!,model.array!)
            
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    
    class func GetSaleOrderDetail(params:[String:String]? ,Success:@escaping ([ProductFormModel])->() ,Failure:@escaping Failure){
        AlamofireTool.getRequest(URLString: GetSaleOrderDetailUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            SVProgressHUD.dismiss()
            guard let model = Sales0rderFormDetailModel(JSON: result) else {return}
            Success((model.Data?.productDetailArray)!)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    
    
}
