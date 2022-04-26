//
//  ViewController.swift
//  Project02 CustomFonts
//
//  Created by ByteDance on 2022/4/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // TODO: 返回列表的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // TODO: 返回列表的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    // TODO: 设置Cell的样式和布局
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellStr = "fontCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellStr)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellStr)
            cell?.backgroundColor = UIColor.clear
        }
        cell?.textLabel?.font = UIFont(name: fontNames[fontRowIndex], size: 15)
        cell?.textLabel?.text = (data[indexPath.row])
        return cell!
    }
    
    // TODO: 返回组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
        
    var data = ["30 Days Swift", "「奋斗」和「理想」",
                "谢谢「造字工房」", "劲黑体，致黑体，童心体",
                "呵呵，再见🤗", "@@@YIYIYIYI",
                "测试测试测试测试测试测试", "123", "Alex", "@@@@@@"]
    
    var fontNames = ["MFTongXin_Noncommercial-Regular",
                     "MFJinHei_Noncommercial-Regular",
                     "MFZhiHei_Noncommercial-Regular",
                     "Zapfino",
                     "Gaspar Regular"]
    
    var fontRowIndex = 0
 
    var fontTableView: UITableView!
    var changeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fontTableView = UITableView.init(frame: self.view.frame, style: .plain)
        fontTableView.dataSource = self
        fontTableView.delegate = self
        fontTableView.backgroundColor = UIColor.clear
        
        self.view.addSubview(fontTableView)
        
        changeBtn = UIButton.init()
        changeBtn.setTitle("Change Font", for: .normal)
        changeBtn.setTitleColor(.blue, for: .normal)
        changeBtn.addTarget(self, action: #selector(changeFont), for: .touchUpInside)
        self.view.addSubview(changeBtn)
        changeBtn.layer.borderColor = UIColor.blue.cgColor
        changeBtn.layer.borderWidth = 1
        changeBtn.layer.cornerRadius = 5
        changeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(500)
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
        }
    }
    
    @objc func changeFont() {
        fontRowIndex = (fontRowIndex + 1) % 5
        print(fontNames[fontRowIndex])
        fontTableView.reloadData()
    }
    
}

