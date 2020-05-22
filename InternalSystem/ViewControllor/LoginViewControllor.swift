 //
//  LoginViewControllor.swift
//  InternalSystem
//
//  Created by gail on 2018/1/31.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class LoginViewControllor: UIViewController {

    lazy var backImageView:UIImageView = {
        var backImageView = UIImageView(frame: view.frame)
        backImageView.image = UIImage(named: "pic1.jpg")
        let backView = UIView(frame: self.view.frame)
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backImageView.addSubview(backView)
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backViewGesture)))
        backImageView.isUserInteractionEnabled = true
        return backImageView
    }()
    lazy var titleLabel : UILabel = {
        var titleLabel = UILabel(frame: CGRect(x: (SCREEN_WIDTH-300)/2, y: 0, width: 300, height: 50))
        titleLabel.text = "Login"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.textAlignment = .center
        titleLabel.center = CGPoint(x: view.centerX, y: SCREEN_HEIGHT*0.2)
        return titleLabel
    }()
    lazy var detailLabel:UILabel = {
       var detailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        detailLabel.text = "欢迎登录广东信浓信息技术有限公司"
        detailLabel.textColor = UIColor.white
        detailLabel.textAlignment = .center
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        detailLabel.center = CGPoint(x: view.centerX, y: SCREEN_HEIGHT*0.85)
        return detailLabel
    }()
    lazy var username : ZJtextField = {
       var username = ZJtextField(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        username.center = CGPoint(x: view.centerX, y: SCREEN_HEIGHT*0.4)
        username.placeHolderLabel.text = "用户名"
        username.textField.tag = 0
        username.textField.delegate = self
        
        return username
    }()
    lazy var password : ZJtextField = {
        var password = ZJtextField(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        password.center = CGPoint(x: view.centerX, y: SCREEN_HEIGHT*0.5)
        password.placeHolderLabel.text = "密码"
        password.textField.tag = 1
        password.textField.delegate = self
        password.textField.isSecureTextEntry = true
        return password
    }()
    lazy var remberPassBtn:UIButton = {
        var remberPassBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        remberPassBtn.setImage(UIImage(named:"rember.png"), for: .normal)
        remberPassBtn.setImage(UIImage(named:"rember_select.png"), for: .selected)
        remberPassBtn.setTitle(" 下次自动登录", for: .normal)
        remberPassBtn.addTarget(self, action: #selector(remberPassWordClick), for: .touchUpInside)
        remberPassBtn.center = CGPoint(x: view.centerX, y: SCREEN_HEIGHT*0.6)
        remberPassBtn.setTitleColor(UIColor.white, for: .normal)
        remberPassBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return remberPassBtn
    }()
    
    lazy var login : UIButton = {
        var login = UIButton(type: .custom)
        login.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        login.center = CGPoint(x: view.centerX, y: SCREEN_HEIGHT*0.72)
        login.setTitle("SIGN IN", for: .normal)
        login.setTitleColor(UIColor.white, for: .normal)
        login.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        login.layer.cornerRadius = 20
        login.layer.borderColor = UIColor.white.cgColor
        login.backgroundColor = UIColor.clear
        login.layer.borderWidth = 2
        login.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
//        login.isEnabled = false
        return login
    }()
    
    lazy var codeArray = [String]()
    lazy var titleArray = [String]()
    
    var autoLogin : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //移除已经存储的菜单栏
        UserDefaults.standard.removeObject(forKey: "titleArray")
        UserDefaults.standard.removeObject(forKey: "codeArray")
        
        
        view.addSubview(backImageView)
        view.addSubview(titleLabel)
        view.addSubview(detailLabel)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(remberPassBtn)
        view.addSubview(login)
        
        
        
}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        ZJKeyChain.delete("userInfo")
        if ((ZJKeyChain.load("Login")) as? [String:String]) != nil{
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.setDefaultAnimationType(.native)
            SVProgressHUD.show()
            let loginInfo = (ZJKeyChain.load("Login")) as! [String:String]
            
            autoLogin = true
            getLoginInfo( name:loginInfo["userName"] ,passWord:loginInfo["passWord"])
        }
    }

}
extension LoginViewControllor : UITextFieldDelegate {
    @objc fileprivate func backViewGesture () {
        self.view.endEditing(true)
    }
    @objc fileprivate func remberPassWordClick (btn:UIButton) {
        btn.isSelected = !btn.isSelected
    }
    
    @objc fileprivate func loginClick () {
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.show()
        
        if username.textField.text=="" || password.textField.text=="" {
            SVProgressHUD.showError(withStatus: "用户名密码不能为空")
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }
        getLoginInfo(name: nil ,passWord: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        SVProgressHUD.dismiss()
        
        if textField.text == "" {
            SVProgressHUD.showError(withStatus: "用户名密码不能为空")
            SVProgressHUD.dismiss(withDelay: 2)
            return false
        }
        if textField.tag == 0 {
            textField.resignFirstResponder()
            password.textField.becomeFirstResponder()
        }else if textField.tag == 1 {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

extension LoginViewControllor {
    
    fileprivate func getLoginInfo (name:String? ,passWord:String?) {
        
        let passWord = autoLogin ? passWord : BaseTools.md5Hash(password.textField.text!)
        let userName = autoLogin ? name : username.textField.text!
        
//        let deviceId = UserDefaults.standard.value(forKey: "deviceId") ?? ""
        
        HomeNetWorkTool.getLoginInfo(params: ["UserName":userName!,"Password":passWord!], Success: { (loginModel,message) in
            
            if self.remberPassBtn.isSelected == true{
               self.savePassWord(userName:userName!,passWord: passWord!)
            }
            //存储用户信息
            self.saveUserInfo(loginModel: loginModel)
            
            self.GetAppModule()
            self.GetApp1Module()
            self.GetApp2Module()
            self.GetApp3Module()
            self.GetApp4Module()
            //延迟调用
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                SVProgressHUD.dismiss()
                

                UIApplication.shared.keyWindow?.rootViewController = CustomTabBarController()
               
            }
        }) { (error) in
            SVProgressHUD.showError(withStatus: "登录失败，请检查网络")
            self.autoLogin = false
        }
        
    }
    
}
extension LoginViewControllor {
    fileprivate func savePassWord (userName:String , passWord:String) {
        var loginInfo = [String:String]()
        loginInfo = ["userName":userName ,"passWord":passWord]
        
        ZJKeyChain.save("Login", data: loginInfo)
    }
    
    fileprivate func saveUserInfo (loginModel:LoginModel) {
        var userInfo = [String:String]()
        userInfo = ["userId":loginModel.userId! ,"roleNames":loginModel.roleNames ?? "" ,"empImg":loginModel.empImg ?? "" ,"lastTime":loginModel.lastTime ?? "" ,"name":loginModel.empName ?? "" ,"isManager":loginModel.isManager ?? "" ,"roleIds":loginModel.roleIDs!]
        
        ZJKeyChain.save("userInfo", data: userInfo)
        self.GetHadFunRight(loginModel.userId!)//查询权限
    }
}
extension LoginViewControllor {
    //查询权限
    fileprivate func GetHadFunRight(_ userId:String){
        
            AlamofireTool.getRequest(URLString: HadFunRightUrl, params: ["UserId":userId], success: { (result) in
                if result["Code"] as! String == "1" {
                    ZJKeyChain.save("Module", data: ["Module":userId])
                }
            }, Failure: { (error) in
                
            })
   }
}
//登录成功后获取菜单栏并存储
extension LoginViewControllor {
    func GetAppModule () {
        HomeNetWorkTool.GetAppModule(parentId: salesModuleID, Success: { (array) in
            
            for model in array {
                
                self.codeArray.append(model.ModuleCode)
                
                self.titleArray.append(model.ModuleName)
            }
            
            let info = UserDefaults.standard
            info.set(self.codeArray, forKey: "codeArray")
            info.set(self.titleArray, forKey: "titleArray")
            info.synchronize()
            
        }) { (error) in
            
        }
    }
    
    func GetApp1Module () {
        HomeNetWorkTool.GetAppModule(parentId: purchaseModuleID, Success: { (array) in
            
            var codeArray:[String] = [String]()
            var titleArray:[String] = [String]()
            for model in array {
                
                codeArray.append(model.ModuleCode)
                titleArray.append(model.ModuleName)
            }
            let info = UserDefaults.standard
            info.set(codeArray, forKey: "code1Array")
            info.set(titleArray, forKey: "title1Array")
            info.synchronize()
        }) { (error) in
        }
    }
    func GetApp2Module () {
        HomeNetWorkTool.GetAppModule(parentId: stockModuleID, Success: { (array) in
            
            var codeArray:[String] = [String]()
            var titleArray:[String] = [String]()
            for model in array {
                
                codeArray.append(model.ModuleCode)
                titleArray.append(model.ModuleName)
            }
            let info = UserDefaults.standard
            info.set(codeArray, forKey: "code2Array")
            info.set(titleArray, forKey: "title2Array")
            info.synchronize()
        }) { (error) in
        }
    }
    func GetApp3Module () {
        HomeNetWorkTool.GetAppModule(parentId: installationModuleID, Success: { (array) in
            
            var codeArray:[String] = [String]()
            var titleArray:[String] = [String]()
            for model in array {
                
                codeArray.append(model.ModuleCode)
                titleArray.append(model.ModuleName)
            }
            let info = UserDefaults.standard
            info.set(codeArray, forKey: "code3Array")
            info.set(titleArray, forKey: "title3Array")
            info.synchronize()
        }) { (error) in
        }
    }
    func GetApp4Module () {
        HomeNetWorkTool.GetAppModule(parentId: FinanceModuleID, Success: { (array) in
            
            var codeArray:[String] = [String]()
            var titleArray:[String] = [String]()
            for model in array {
                
                codeArray.append(model.ModuleCode)
                titleArray.append(model.ModuleName)
            }
            let info = UserDefaults.standard
            info.set(codeArray, forKey: "code4Array")
            info.set(titleArray, forKey: "title4Array")
            info.synchronize()
        }) { (error) in
        }
    }
}
