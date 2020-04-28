//
//  AlarmController.swift
//  Alarm
//
//  Created by Cameron Ingham on 7/9/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import UserNotifications

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
    func snoozed(alarm: Alarm)
}

extension AlarmScheduler {
    
    func setCategories(){
        let snoozeAction = UNNotificationAction(
            identifier: "snooze",
            title: "Snooze 5 Minutes",
            options: []
        )
        let noAction = UNNotificationAction(
            identifier: "dismiss",
            title: "Dismiss",
            options: []
        )
        let alarmCategory = UNNotificationCategory(
            identifier: "alarm.category",
            actions: [snoozeAction, noAction],
            intentIdentifiers: [],
            options: [])
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }
    
    func scheduleUserNotifications(for alarm: Alarm){
        setCategories()
        let content = UNMutableNotificationContent()
        content.title = alarm.name
        content.sound = UNNotificationSound(named: "clip.caf")
        content.categoryIdentifier = "alarm.category"
        let calendar = NSCalendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: alarm.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    func snoozed(alarm: Alarm){
        setCategories()
        let content = UNMutableNotificationContent()
        content.title = alarm.name
        content.sound = UNNotificationSound(named: "clip.caf")
        content.categoryIdentifier = "alarm.category"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5 * 60, repeats: false)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

class AlarmController: AlarmScheduler {
    static let shared = AlarmController()
    var alarms: [Alarm] = []
    
    func addAlarm(name: String, date: Date){
        let newAlarm = Alarm(name: name, date: date)
        alarms.append(newAlarm)
        scheduleUserNotifications(for: newAlarm)
        saveAlarms()
    }
    
    func deleteAlarm(alarm: Alarm){
        guard let alarmIndex = alarms.index(of: alarm) else { return }
        alarms.remove(at: alarmIndex)
        cancelUserNotifications(for: alarm)
        saveAlarms()
    }
    
    func update(alarm: Alarm, name: String, date: Date, toggle: Bool){
        alarm.name = name
        alarm.date = date
        alarm.toggle = toggle
        cancelUserNotifications(for: alarm)
        scheduleUserNotifications(for: alarm)
        saveAlarms()
    }
    
    func alarm(from uuid: String) -> Alarm?{
        guard let alarm = AlarmController.shared.alarms.first(where: { $0.uuid == uuid }) else {return nil}
        return alarm
    }
    
    func changeToggle(alarm: Alarm){
        if(alarm.toggle){
            alarm.toggle = false
            cancelUserNotifications(for: alarm)
        } else {
            alarm.toggle = true
            scheduleUserNotifications(for: alarm)
        }
        saveAlarms()
    }
    
    private func fileURL() -> URL{
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentDirectory.appendingPathComponent("alarms.json")
    }
    
    func saveAlarms(){
        let je = JSONEncoder()
        do {
            let data = try je.encode(alarms)
            try data.write(to: fileURL())
        } catch let e{
            print("Error saving alarms. \(e.localizedDescription)")
        }
    }
    
    func loadAlarms(){
        let jd = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let alarms = try jd.decode([Alarm].self, from: data)
            self.alarms = alarms
        } catch let e{
            print("Error loading alarms. \(e.localizedDescription)")
        }
    }
}
