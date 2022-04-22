//
//  ViewController.swift
//  Project01 StopWatch
//
//  Created by ByteDance on 2022/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    var timeLabel: UILabel!
    var playBtn : UIButton!
    var pauseBtn : UIButton!
    var resetBtn : UIButton!
    
    var seconds = 0
    var timer = Timer()
    var isPlaying = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .black
        
        timeLabel = UILabel.init(frame: CGRect(x: 120, y: 250, width: 150, height: 20))
        self.view.addSubview(timeLabel)
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont.systemFont(ofSize: 25)
        timeLabel.text = timeString(time: TimeInterval(seconds))

        
        playBtn = UIButton.init(frame: CGRect(x: 30, y: 500, width: 50, height: 20))
        self.view.addSubview(playBtn)
        playBtn.setTitle("start", for: .normal)
        playBtn.addTarget(self, action: #selector(playButtonDidTouch), for: .touchUpInside)

        
        pauseBtn = UIButton.init(frame: CGRect(x: 250, y: 500, width: 50, height: 20))
        self.view.addSubview(pauseBtn)
        pauseBtn.setTitle("stop", for: .normal)
        pauseBtn.addTarget(self, action: #selector(pauseButtonDidTouch), for: .touchUpInside)

        
        resetBtn = UIButton.init(frame: CGRect(x: 140, y: 500, width: 50, height: 20))
        self.view.addSubview(resetBtn)
        resetBtn.setTitle("reset", for: .normal)
        resetBtn.addTarget(self, action: #selector(resetButtonDidTouch), for: .touchUpInside)

    }
 
    
    @objc func playButtonDidTouch(sender: AnyObject) {
        if isPlaying {
            return
        }
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        runTimer()
        isPlaying = true
    }
    
    @objc func pauseButtonDidTouch(sender: AnyObject) {
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        timer.invalidate()
        isPlaying = false
    }
    
    
    @objc func resetButtonDidTouch(sender: AnyObject){
        timer.invalidate()
        isPlaying = false
        seconds = 0
        timeLabel.text = timeString(time: TimeInterval(seconds))
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
    }
    
    @objc func updateTimer() {
        seconds += 1
        timeLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

