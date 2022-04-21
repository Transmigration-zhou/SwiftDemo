//
//  ViewController.swift
//  TableView
//
//  Created by ByteDance on 2022/4/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func clear(_ sender: Any) {
        print("Do Clear")
        
        data.removeAll()
        
        tableView.reloadData()
    }
    var data = [
        Post(avatar: "flamingo", image: "Card", nickname: "Flamingo", username: "熠丶", content: "熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠熠", created_at: "22 days ago"),
        Post(avatar: "flamingo", image: "Book", nickname: "Flamingo", username: "熠丶", content: "xhgybbybz", created_at: "3 years ago"),
        Post(avatar: "flamingo", image: "ipad", nickname: "Flamingo", username: "熠丶", content: "/日月星辰 梦想成真", created_at: "4 years ago")
    ]
        
    
    var normalText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "主页"
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalCell", for: indexPath) as! PostCell
        
        let post = data[indexPath.row]
        
        cell.avatarImageView.image = UIImage(named: post.avatar)
        cell.postImageView.image = UIImage(named: post.image)
        cell.nicknameLabel.text = post.nickname
        cell.usernameLabel.text = post.username
        cell.contentLabel.text = post.content
        cell.timeLabel.text = post.created_at
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        normalText = cell?.textLabel?.text
        
        performSegue(withIdentifier: "showNormalViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNormalViewController" {
            let viewController = segue.destination as! NormalViewController
            
            viewController.normalText = normalText
        }
    }
}
