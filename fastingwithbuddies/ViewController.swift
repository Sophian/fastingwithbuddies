//
//  ViewController.swift
//  fastingwithbuddies
//
//  Created by Sophian Bensaou on 10/1/17.
//  Copyright © 2017 Sophian Bensaou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var startTimeLabel = "00:00:00"
    var startTime = TimeInterval()
    var timer = Timer()
    var isPlaying = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timeLabel.text = String(startTimeLabel)
        // TODO: Add startTimeLabel and stopTimeLabel
        
        stopButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    // TODO: Add Save button
    
    @IBAction func startTimer(_ sender: AnyObject) {
        if (isPlaying) {
            return
        }
        
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
        
        startTime = Date.timeIntervalSinceReferenceDate
    }
    
    @IBAction func stopTimer(_ sender: AnyObject) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
    }
    
    @objc func UpdateTimer() {

        let currentTime = Date.timeIntervalSinceReferenceDate
        
        // Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime
        
        // Calculate the hours in elapsed time.
        let hours = UInt8(elapsedTime / 3600.0)
        elapsedTime -= (TimeInterval(hours) * 3600)
        
        // Calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        // Calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        // Add the leading zero for hours, minutes and seconds and store them as string constants
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        // Concatenate hours, minutes and seconds and assign it
        timeLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
    }
}

