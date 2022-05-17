//
//  ViewController.swift
//  Project04 LimitedInputTextField
//
//  Created by ByteDance on 2022/5/17.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    var limitedTextView: UITextView = UITextView()
    var allowInputNumberLabel: UILabel = UILabel()
    let limit = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initNavigationBar()
        self.initInputField()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func initNavigationBar() {
        let leftItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem(title: "发表", style: .plain, target: self, action: nil)
        rightItem.tintColor = UIColor.red
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func initInputField() {
        let naviFrame = self.navigationController?.navigationBar.frame
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let avatarImgView = UIImageView(frame: CGRect(x: 0, y: (naviFrame?.height ?? 0) + statusBarFrame.height + 10, width: 70, height: 70))
        avatarImgView.image = UIImage.init(named: "avatar")
        self.view.addSubview(avatarImgView)

        limitedTextView = UITextView(frame: CGRect(x: 80, y: avatarImgView.frame.height, width: self.view.frame.width - 90, height: 300))
        self.view.addSubview(limitedTextView)
        limitedTextView.delegate = self
        limitedTextView.font = UIFont.systemFont(ofSize: 20)

        allowInputNumberLabel = UILabel(frame: CGRect(x: self.view.frame.width - 50, y: self.view.frame.height - 40, width: 50, height: 40))
        self.view.addSubview(allowInputNumberLabel)
        allowInputNumberLabel.text = String(limit)
        allowInputNumberLabel.textAlignment = .right
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentCharactorCount = textView.text.count
        if  currentCharactorCount >= limit {
            limitedTextView.resignFirstResponder()
        }
        allowInputNumberLabel.text = "\(limit - currentCharactorCount)"
    }
    
    @objc func keyboardWillChangeFrame(note: Notification) {
        // 1.获取动画执行的时间
        let duration = note.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 2.获取键盘最终Y值
        let endFrame = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        
        // 3.计算工具栏距离底部的间距
        let margin = UIScreen.main.bounds.height - y
        
        // 4.执行动画
        UIView.animate(withDuration: duration) {
            // 键盘弹出
            if margin > 0 {
                self.allowInputNumberLabel.frame.origin.y = self.view.frame.height - 40 - margin
            }
            // 键盘收起
            else {
                self.allowInputNumberLabel.frame.origin.y = self.view.frame.height - 40
            }
        }
    }
}

