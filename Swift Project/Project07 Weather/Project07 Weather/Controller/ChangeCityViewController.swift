//
//  ChangeCityViewController.swift
//  Project07 Weather
//
//  Created by ByteDance on 2022/6/22.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate: ChangeCityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!

    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        //1 通过Text Field得到城市名称
        let cityName = changeCityTextField.text!
        
        //2 如果有一个delegate设置，则调用userEnteredANewCityName()方法
        delegate?.userEnteredANewCityName(city: cityName)
        
        //3 销毁CityViewController并返回到WeatherViewController
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
