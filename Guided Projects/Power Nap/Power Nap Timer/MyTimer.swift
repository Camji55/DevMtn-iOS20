//
//  TimerController.swift
//  Power Nap Timer
//
//  Created by Cameron Ingham on 7/10/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

protocol MyTimerDelegate: class {
    func timerDidComplete()
    func timerDidStop()
    func timerDidTick()
}

class MyTimer {
    
    private var timer: Timer?
    var timeLeft: TimeInterval?
    var isOn: Bool {
        return timeLeft == nil ? false : true
    }
    
    weak var delegate: MyTimerDelegate?
    
    func start(_ time: TimeInterval) {
        if isOn == false {
            timeLeft = time
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                self.secondTick()
            })
        }
    }
        
    func stop() {
        if isOn {
            timeLeft = nil
            timer?.invalidate()
            delegate?.timerDidStop()
        }
    }
    
    func timeLeftAsString() -> String {
        let timeRemaining = Int(self.timeLeft ?? 20*60)
        let minutesLeft = timeRemaining/60
        let secondsLeft = timeRemaining - (minutesLeft * 60)
        
        return String(format: "%02d : %02d", arguments: [minutesLeft, secondsLeft])
    }
    
    private func secondTick() {
        guard let timeLeft = timeLeft else {
            return
        }
        
        if timeLeft > 0 {
            self.timeLeft = timeLeft - 1
            delegate?.timerDidTick()
        } else {
            self.timeLeft = nil
            self.timer?.invalidate()
            delegate?.timerDidComplete()
        }
    }
    
}
