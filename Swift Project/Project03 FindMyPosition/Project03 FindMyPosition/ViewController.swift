//
//  ViewController.swift
//  Project03 FindMyPosition
//
//  Created by ByteDance on 2022/5/16.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    // 定位 获取经纬度
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    let locationLabel = UILabel()
    let locationStrLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bgImageView = UIImageView.init()
        bgImageView.frame = self.view.frame
        bgImageView.image = UIImage.init(named: "Background")
        self.view.addSubview(bgImageView)
        
        // 设置毛玻璃效果
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.view.frame
        self.view.addSubview(blurView)
        
        locationManager.delegate = self
                
        locationLabel.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 100)
        locationLabel.textAlignment = .center
        locationLabel.textColor = UIColor.black
        self.view.addSubview(locationLabel)
        
        locationStrLabel.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 50)
        locationStrLabel.textAlignment = .center
        locationStrLabel.textColor = UIColor.gray
        self.view.addSubview(locationStrLabel)
        
        let findMyLocationBtn = UIButton(type: .system)
        findMyLocationBtn.frame = CGRect(x: 50, y: self.view.frame.height - 80, width: self.view.frame.width - 100, height: 50)
        findMyLocationBtn.setTitle("Find My Position", for: UIControl.State.normal)
        findMyLocationBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        findMyLocationBtn.addTarget(self, action: #selector(findMyLocation), for: UIControl.Event.touchUpInside)
        self.view.addSubview(findMyLocationBtn)
    }

    @objc func findMyLocation() {
        // 请求总是访问权限
        locationManager.requestAlwaysAuthorization()
        // 请求使用期间访问权限
        locationManager.requestWhenInUseAuthorization()
        // 开始进行连续定位
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations : NSArray = locations as NSArray
        let currentLocation = locations.lastObject as! CLLocation
        let locationStr = "lat:\(currentLocation.coordinate.latitude) lng:\(currentLocation.coordinate.longitude)"
        locationLabel.text = locationStr
        reverseGeocode(location: currentLocation)
        locationManager.stopUpdatingLocation()
    }

    // 将经纬度转换为城市名
    func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
            if error == nil {
                if placemarksArray!.count > 0 {
                    let placemark = placemarksArray?[0]
                    let address = "\(placemark?.locality ?? ""), \(placemark?.country ?? "")"
                    self.locationStrLabel.text = address
                }
            }
        }
    }
}
