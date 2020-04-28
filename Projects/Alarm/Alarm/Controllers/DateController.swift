//
//  DateController.swift
//  Alarm
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

class Time {
    var time: String
    var hr: String
    
    init(time: String, hr: String){
        self.time = time
        self.hr = hr
    }
}

class DateController {
    static func time(date: Date) -> Time {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let time = formatter.string(from: date)
        formatter.dateFormat = "a"
        let hr = formatter.string(from: date)
        return Time(time: time, hr: hr)
    }
}
