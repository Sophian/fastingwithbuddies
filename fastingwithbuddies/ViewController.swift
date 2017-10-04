//
//  ViewController.swift
//  fastingwithbuddies
//
//  Created by Sophian Bensaou on 10/1/17.
//  Copyright © 2017 Sophian Bensaou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timerStartLabel = "00:00:00"
    var startTime = TimeInterval()
    var timer = Timer()
    var isPlaying = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timerLabel.text = String(describing: timerStartLabel)
        // TODO: Add startTimeLabel and stopTimeLabel
        
        stopButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var goalTimeLabel: UILabel!
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
        
        UpdateStartAndEndTimeLabels()
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
        timerLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
    }
    
    func UpdateStartAndEndTimeLabels() {
        // Calculate goalTime
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHours = calendar.component(.hour, from: currentDate)
        let currentMinutes = calendar.component(.minute, from: currentDate)
        let goalDate = currentDate.addingTimeInterval(16.0 * 3600.0)
        let goalHours = calendar.component(.hour, from: goalDate)
        
        // Update labels
        startTimeLabel.text = "\(currentHours):\(currentMinutes)"
        goalTimeLabel.text = "\(goalHours):\(currentMinutes)" // Minutes won't change if fasting time is defaulted to 16hrs
    }
}

