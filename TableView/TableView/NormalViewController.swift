//
//  NormalViewController.swift
//  TableView
//
//  Created by ByteDance on 2022/4/21.
//

import UIKit

class NormalViewController: UIViewController {

    @IBOutlet weak var normalLable: UILabel!
    
    @IBAction func popBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    var normalText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        normalLable.text = normalText
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
