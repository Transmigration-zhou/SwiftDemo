//
//  ViewController.swift
//  TableView
//
//  Created by ByteDance on 2022/4/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = ["😊 Human", "🐱 Neko", "🐶 Doge", "🌲 Tree", "🎁 Gift"]
    
    var normalText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalCell", for: indexPath)
        
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        
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
