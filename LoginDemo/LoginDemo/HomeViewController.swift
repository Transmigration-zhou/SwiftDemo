//
//  HomeViewController.swift
//  LoginDemo
//
//  Created by ByteDance on 2022/5/9.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataDictionary: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "首页"
        let RootTableView = UITableView.init(frame: self.view.frame, style: .plain)
        RootTableView.delegate = self
        RootTableView.dataSource = self
        self.view.addSubview(RootTableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataDictionary?["list"] as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell_login")
        if cell == nil {
             cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell_login")
        }
        let  arrayList = self.dataDictionary?["list"] as! NSArray
        let dict = arrayList[indexPath.row] as! NSDictionary
        cell?.textLabel?.text = (dict["name"] as! String)
        cell?.detailTextLabel?.text = (dict["type"] as! String)
        return cell!
    }
    
}
