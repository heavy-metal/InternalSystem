//
//  ChangePwdViewController.swift
//  InternalSystem
//
//  Created by gail on 2018/2/6.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class ChangePwdViewController: UIViewController {

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
        titleLabel.text = "修改密码"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.textAlignment = .center
        titleLabel.center = CGPoint(x: view.centerX, y: 150)
        return titleLabel
    }()
    lazy var oldPassword : ZJtextField = {
        var oldPassword = ZJtextField(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        oldPassword.center = CGPoint(x: view.centerX, y: 300)
        oldPassword.placeHolderLabel.text = "旧密码"
        oldPassword.textField.tag = 2
        oldPassword.textField.delegate = self
        oldPassword.textField.isSecureTextEntry = true
        return oldPassword
    }()
    lazy var newPassword : ZJtextField = {
        var newPassword = ZJtextField(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        newPassword.center = CGPoint(x: view.centerX, y: oldPassword.centerY+60)
        newPassword.placeHolderLabel.text = "新密码"
        newPassword.textField.tag = 3
        newPassword.textField.delegate = self
        newPassword.textField.isSecureTextEntry = true
        return newPassword
    }()
    lazy var confirmBtn : UIButton = {
        var confirmBtn = UIButton(type: .custom)
        confirmBtn.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        confirmBtn.center = CGPoint(x: view.centerX, y: newPassword.centerY+100)
        confirmBtn.setTitle("确认修改", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        confirmBtn.layer.cornerRadius = 20
        confirmBtn.layer.borderColor = UIColor.white.cgColor
        confirmBtn.backgroundColor = UIColor.clear
        confirmBtn.layer.borderWidth = 2
        confirmBtn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        //        login.isEnabled = false
        return confirmBtn
    }()
    lazy var backBtn:UIButton = {
        var backBtn = UIButton(frame: CGRect(x: 20, y: 20, width: 80, height: 30))
        backBtn.setImage(UIImage(named:"end.png"), for: .normal)
        backBtn.sizeToFit()
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return backBtn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backImageView)
        view.addSubview(titleLabel)
        view.addSubview(oldPassword)
        view.addSubview(newPassword)
        view.addSubview(confirmBtn)
        view.addSubview(backBtn)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
}
extension ChangePwdViewController : UITextFieldDelegate {
    @objc fileprivate func backViewGesture () {
        self.view.endEditing(true)
    }
    @objc fileprivate func backBtnClick () {
        
        self.navigationController?.popViewController(animated: true)
    }
    @objc func confirmBtnClick() {
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.show()
        
        if oldPassword.textField.text=="" || newPassword.textField.text=="" {
            SVProgressHUD.showError(withStatus: "密码不能为空")
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }
        
        self.sendData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        SVProgressHUD.dismiss()
        
        if textField.text == "" {
            SVProgressHUD.showError(withStatus: "密码不能为空")
            SVProgressHUD.dismiss(withDelay: 2)
            return false
        }
        if textField.tag == 2 {
            textField.resignFirstResponder()
            newPassword.textField.becomeFirstResponder()
        }else if textField.tag == 3 {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
extension ChangePwdViewController {
    fileprivate func sendData() {
        
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            
            AlamofireTool.getRequest(URLString: changePwdUrl, params: ["UserId":userInfo["userId"]! ,"OldPassword":BaseTools.md5Hash(oldPassword.textField.text!) ,"NewPassword":BaseTools.md5Hash(newPassword.textField.text!)], success: { (result) in
                
                if result["Code"] as! String == "1" {
                    
                    self.reloginAPP()
                    SVProgressHUD.dismiss()
                }else{
                    SVProgressHUD.showError(withStatus: result["Message"] as! String)
                    SVProgressHUD.dismiss(withDelay: 2)
                }
                
                
            }, Failure: { (error) in
                SVProgressHUD.showError(withStatus: "请求失败，请检查网络")
                SVProgressHUD.dismiss(withDelay: 2)
            })
        }
    }
     //修改成功重新登录app
    private func reloginAPP() {
        let alertVC = UIAlertController(title:nil, message: "密码修改成功!请重新登录app", preferredStyle: .alert)
        let OKActoion = UIAlertAction(title: "OK", style: .default) { (action) in
            
            ZJKeyChain.delete("Login")
            UIApplication.shared.keyWindow?.rootViewController = LoginViewControllor()
        }
        alertVC.addAction(OKActoion)
        self.present(alertVC, animated: true, completion: nil)
    }
}
