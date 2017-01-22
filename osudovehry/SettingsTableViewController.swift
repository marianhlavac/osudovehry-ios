//
//  SettingsTableViewController.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 21/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsTableViewController: UITableViewController {
    
    let notificationsSwitch = UISwitch()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // Create tabBarItem
        tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)
        
        notificationsSwitch.addTarget(self, action: #selector(SettingsTableViewController.changeNotificationSettings), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        
        notificationsSwitch.isOn = UserDefaults.standard.bool(forKey: "notifications")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set navigation title
        tabBarController?.navigationItem.title = "Settings"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        switch (indexPath.row) {
        case 0:
            cell.textLabel?.text = "Allow upcoming event notifications"
            cell.accessoryView = notificationsSwitch
        case 1:
            cell.textLabel?.text = "Send example notification"
        case 2:
            cell.textLabel?.text = "Cancel all notifications"
        default:
            cell.textLabel?.text = ""
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 1:
            sendExampleNotification()
        case 2:
            SettingsTableViewController.cancelAllNotifications()
        default:
            break
        }
    }
    
    func sendExampleNotification() {
        let center = UNUserNotificationCenter.current()
        
        UNUserNotificationCenter.current().getNotificationSettings(){ (setttings) in
            
            switch setttings.soundSetting{
            case .disabled:
                let alert = UIAlertController(title: "Notifications are disabled", message: "Allow notifications in Settings to receive upcoming event notifications", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            default:
                let content = UNMutableNotificationContent()
                content.title = "It's happening tomorrow!"
                content.body = "4. Osudové hry event is starting tomorrow at 6:00PM! Don't forget to come!"
                content.sound = UNNotificationSound.default()
                
                let date = Date(timeIntervalSinceNow: 10)
                let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                
                center.add(UNNotificationRequest(identifier: "a-example-010", content: content, trigger: trigger))
                
                let alert = UIAlertController(title: "Notification", message: "Notification will pop up in 10 seconds. Exit the application to see the result.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    static func cancelAllNotifications() {
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
    }
    
    func changeNotificationSettings() {
        UserDefaults.standard.setValue(notificationsSwitch.isOn, forKey: "notifications")
        UserDefaults.standard.synchronize()

        SettingsTableViewController.setupNotifications()
    }
    
    static func setupNotifications() {
        if (UserDefaults.standard.bool(forKey: "notifications")) {
            let center = UNUserNotificationCenter.current()
            
            let events = APIWrapper.service.getUpcomingEvents()
            
            var i = 0
            
            for ev in events {
                let content = UNMutableNotificationContent()
                
                let fmt = DateFormatter()
                fmt.dateStyle = .none
                fmt.timeStyle = .short
                
                content.title = "It's happening tomorrow!"
                content.body = ev.name + " event is starting tomorrow at " + fmt.string(from: ev.startsAt) + "! Don't forget to come!"
                content.sound = UNNotificationSound.default()
                
                var date = ev.startsAt
                date.addTimeInterval(-86400)
                let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                
                center.add(UNNotificationRequest(identifier: "ev-remind-" + String(i), content: content, trigger: trigger))
                i += 1
            }
        }
    }

}
