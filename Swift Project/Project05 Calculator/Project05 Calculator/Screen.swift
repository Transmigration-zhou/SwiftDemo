//
//  Screen.swift
//  Project05 Calculator
//
//  Created by ByteDance on 2022/5/17.
//

import UIKit

class Screen: UIView {
    
    //用于显示用户输入信息
    var inputLabel: UILabel?
    //用于显示历史记录信息
    var historyLabel: UILabel?
    //用户输入表达式或者计算结果字符串
    var inputString = ""
    //历史表达式字符串
    var historyString = ""
    //所有数字字符 用于进行检测匹配
    let figureArray: Array<Character> = ["0","1","2","3","4","5","6","7", "8","9","."]
    //所有运算功能字符 用于进行检测匹配
    let funcArray = ["+","-","*","/","%","^"]
    
    //默认的构造方法
    init() {
        inputLabel = UILabel()
        historyLabel = UILabel()
        super.init(frame: CGRect.zero)
        installUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //进行界面的设计
    func installUI() {
        //设置文字的对齐方式为右对齐
        inputLabel?.textAlignment = .right
        historyLabel?.textAlignment = .right
        //设置字体
        inputLabel?.font = UIFont.systemFont(ofSize: 34)
        historyLabel?.font = UIFont.systemFont(ofSize: 30)
        //设置文字颜色
        inputLabel?.textColor = UIColor.orange
        historyLabel?.textColor = UIColor.black
        //设置文字大小可以根据字数进行适配
        inputLabel?.adjustsFontSizeToFitWidth = true
        inputLabel?.minimumScaleFactor = 0.5
        historyLabel?.adjustsFontSizeToFitWidth = true
        historyLabel?.minimumScaleFactor = 0.5
        //设置文字的截断方式
        inputLabel?.lineBreakMode = .byTruncatingHead
        historyLabel?.lineBreakMode = .byTruncatingHead
        //设置文字的行数
        inputLabel?.numberOfLines = 0
        historyLabel?.numberOfLines = 0
        
        self.addSubview(inputLabel!)
        self.addSubview(historyLabel!)
        //进行自动布局
        inputLabel?.snp.makeConstraints({ (maker) in
            maker.left.equalTo(10)
            maker.right.equalTo(-10)
            maker.bottom.equalTo(-10)
            maker.height.equalTo(inputLabel!.superview!.snp.height).multipliedBy(0.5).offset(-10)
        })
        historyLabel?.snp.makeConstraints({ (maker) in
            maker.left.equalTo(10)
            maker.right.equalTo(-10)
            maker.top.equalTo(10)
            maker.height.equalTo(inputLabel!.superview!.snp.height).multipliedBy(0.5).offset(-10)
        })
    }
    
    //提供一个输入信息的接口
    func inputContent(content: String) {
        //如果不是数字也不是运算符 则不处理
        if !figureArray.contains(content.last!) && !funcArray.contains(content) {
            return
        }
        //如果不是首次输入字符
        if inputString.count>0 {
            //数字后面可以任意输入
            if figureArray.contains(inputString.last!) {
                inputString.append(content)
                inputLabel?.text = inputString
            } else{
                //运算符后面只能输入数字
                if figureArray.contains(content.last!) {
                    inputString.append(content)
                    inputLabel?.text = inputString
                }
            }
        } else{
            //只有数字可以作为首个字符
            if figureArray.contains(content.last!){
                inputString.append(content)
                inputLabel?.text = inputString
            }
        }
    }
    
    //提供一个刷新历史记录的方法
    func refreshHistory() {
        historyString = inputString
        historyLabel?.text = historyString
    }
    
    //清空显示屏中当前输入的信息
    func clearContent()  {
        inputString = ""
    }
    
    //删除显示屏中上次输入的字符
    func deleteInput() {
        if inputString.count>0 {
            inputString.remove(at: inputString.index(before: inputString.endIndex))
            inputLabel?.text = inputString
        }
    }
}
