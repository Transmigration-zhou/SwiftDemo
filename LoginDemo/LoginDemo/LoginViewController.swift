//
//  LoginViewController.swift
//  LoginDemo
//
//  Created by ByteDance on 2022/5/9.
//

import UIKit

class LoginViewController: UIViewController {

    var AccountTextField: UITextField?
    var passWTextField: UITextField?
    var timer: Timer?
    var underView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setNavition()
        self.makeLoginUI()
    }

    // TODO : 设置导航
    func setNavition() {
        self.navigationItem.title = "登录"
    }

    // TODO : 登录页面的布局
    func makeLoginUI() {
        /**
         设置背景
         */
        let bGImageView = UIImageView.init(frame: self.view.frame)
        bGImageView.contentMode = UIView.ContentMode.scaleAspectFill
        bGImageView.image = UIImage.init(named: "BackgroundImage")
        bGImageView.isUserInteractionEnabled = true
        self.view.addSubview(bGImageView)
        
        /**
         Heard ImageView
         */
        let heardImageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 80))
        heardImageV.center = CGPoint.init(x: self.view.center.x, y: 160)
        heardImageV.layer.masksToBounds = true
        heardImageV.image = UIImage.init(named: "HeaderImage")
        heardImageV.layer.borderWidth = 6
        heardImageV.layer.backgroundColor = UIColor.cyan.cgColor
        heardImageV.layer.cornerRadius = heardImageV.bounds.width * 0.5
        heardImageV.contentMode = .scaleAspectFill
        bGImageView.addSubview(heardImageV)
        
        /**
         账号
         */
        let AccountLable = UILabel.init(frame: CGRect.init(x: 40, y: heardImageV.frame.maxY + 30
    , width: 40, height: 30))
        AccountLable.text = "账户:"
        bGImageView.addSubview(AccountLable)
        
        AccountTextField = UITextField.init(frame: CGRect.init(x: AccountLable.frame.maxX+10, y: heardImageV.frame.maxY + 32, width: bGImageView.frame.width - 90 - AccountLable.frame.width, height: 30))
        AccountTextField?.placeholder = "请输入您的账户"
        bGImageView.addSubview(AccountTextField!)
        
        let line = UIView.init(frame: CGRect.init(x: 40, y: AccountLable.frame.maxY, width: bGImageView.frame.width - 80, height: 1))
        line.backgroundColor = UIColor.gray
        bGImageView.addSubview(line)
        
        /**
         密码
         */
        let passWLable = UILabel.init(frame: CGRect.init(x: 40, y: line.frame.maxY + 40, width: 40, height: 30))
        passWLable.text = "密码:"
        bGImageView.addSubview(passWLable)
        
        passWTextField = UITextField.init(frame: CGRect.init(x: passWLable.frame.maxX+10, y: line.frame.maxY + 42, width: bGImageView.frame.width - passWLable.frame.width - 90, height: 30))
        passWTextField?.placeholder = "请输入密码"
        passWTextField?.isSecureTextEntry = true
        bGImageView.addSubview(passWTextField!)
        
        let lineV = UIView .init(frame: CGRect.init(x: 40, y: passWLable.frame.maxY, width: bGImageView.frame.width - 80, height: 1))
        lineV.backgroundColor = UIColor.gray
        bGImageView.addSubview(lineV)

        /**
         点击按钮
         */
        let loginBtn = UIButton.init(frame: CGRect.init(x: 40, y: lineV.frame.maxY + 50, width: bGImageView.frame.width - 80, height: 40))
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.black, for: .normal)
        loginBtn.layer.cornerRadius = 6
        loginBtn.addTarget(self, action:#selector(click(_:)), for:.touchUpInside)
        loginBtn.layer.borderColor = UIColor.gray.cgColor
        loginBtn.layer.borderWidth = 1
        bGImageView.addSubview(loginBtn)
    }


    // TODO : 登录事件的触发
    @objc func click(_ btn:UIButton) {
        if (AccountTextField != nil) && (AccountTextField?.text?.count != 0) {
            if self.passWTextField != nil && passWTextField?.text?.count != 0 {
                self.loadData()
            }else{
                self.autoAlertView(message: "请填写密码")
            }
        }else{
            self.autoAlertView(message: "请填写账户")
        }
    }

    // TODO : 简短提示
    func autoAlertView(message:String) -> Void {
        let autoAlert = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        self.present(autoAlert, animated: true) {
            self.timer = Timer.init(timeInterval: 10, repeats: false, block: { (time) in
                autoAlert.dismiss(animated: true, completion:{
                   self.timer?.invalidate()
                })
            })
            self.timer?.fire()
        }
    }

    // TODO : 活动指示器的提示
    func activityIndicator(isFinsh: Bool) {
        if isFinsh {
            underView?.removeFromSuperview()
            return;
        }
        underView = UIView.init(frame: self.view.frame)
        underView?.backgroundColor = UIColor.clear
        self.view.addSubview(underView!)
        
        let activitV = UIActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 80))
        activitV.center = CGPoint.init(x: underView!.center.x, y: underView!.center.y)
        activitV.backgroundColor = UIColor.gray
        activitV.style = UIActivityIndicatorView.Style.large
        activitV.layer.cornerRadius = 6
        underView?.addSubview(activitV)
        activitV.startAnimating()
    }


    func loadData() {
        self.activityIndicator(isFinsh: false)
        let url = URL.init(string: "http://api.3g.ifeng.com/clientShortNews?type=beauty")
        let request = URLRequest.init(url: url!)
        let DataTask = URLSession.shared.dataTask(with: request) { (data, resp, error) in
            self.activityIndicator(isFinsh: true)
            if data != nil && error == nil {
                let dict = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                DispatchQueue.main.async(execute: {
                     let  Vc = HomeViewController.init()
                     Vc.dataDictionary = (dict as! NSDictionary)
                     let NavVc = UINavigationController.init(rootViewController: Vc)
                     self.present(NavVc, animated: true, completion: nil)
                })
            }
        }
        DataTask.resume()
    }
    
}

