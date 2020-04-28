//
//  ViewController.swift
//  Power Nap Timer
//
//  Created by Cameron Ingham on 7/10/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    let myTimer = MyTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
        myTimer.delegate = self
    }

    @IBAction func startStopButton(_ sender: Any) {
        if myTimer.isOn {
            myTimer.stop()
        } else {
            myTimer.start(10)
            createLocalNotification(10)
        }
    }
}

extension ViewController: MyTimerDelegate {
    func timerDidComplete() {
        updateTimeLabelAndButton()
        displayAlert()
    }
    
    func timerDidStop() {
        updateTimeLabelAndButton()
        cancelLocalNotification()
    }
    
    func timerDidTick() {
        updateTimeLabelAndButton()
    }
    
    func updateTimeLabelAndButton(){
        var buttonTitle: String
        if myTimer.isOn {
            buttonTitle = "Stop"
        } else {
            buttonTitle = "Start"
        }
        startStopButton.setTitle(buttonTitle, for: .normal)

        timerLabel.text = myTimer.timeLeftAsString()
    }
}

extension ViewController {
    func displayAlert() {
        let alert = UIAlertController(title: "Time to Wake Up!", message: "Or snooze?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Snooze for how many minutes?"
            textField.keyboardType = .numberPad
        }
        
        let okayButton = UIAlertAction(title: "I'm Up", style: .default, handler: nil)
        let snoozeButton = UIAlertAction(title: "Snooze", style: .destructive) { (_) in
            let textField = alert.textFields!.first!
            let timeAsString = textField.text!
            let timeAsDouble = Double(timeAsString)! * 60.0
            self.myTimer.start(timeAsDouble)
            self.createLocalNotification(timeAsDouble)
        }
        
        alert.addAction(okayButton)
        alert.addAction(snoozeButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController {
    func createLocalNotification(_ timeInterval: TimeInterval) {
        
        let content = UNMutableNotificationContent()
        content.title = "Wake Up!"
        content.body = "It's time to get up."
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "PowerNap", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func cancelLocalNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}












