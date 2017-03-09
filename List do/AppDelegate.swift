//
//  AppDelegate.swift
//  List do
//
//  Created by Doãn Tuấn on 1/23/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var lists: [CheckList]!
    var titleRemind:String!
    var messRemind:String!
    // allow notification
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        FIRApp.configure()
        return true
    }

    func scheduleNotification(at date: Date, title: String, remindContent: String) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        // conten Nofitication
        titleRemind = title
        messRemind = remindContent
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = remindContent
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "myCategory"
        
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
       
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    
    func showNoticationView(){
        let window = UIApplication.shared.keyWindow!
        let view = showNotification(frame: CGRect(x: 20, y: 0, width: 330, height: 110))
        
        view.customView(titleLabel: titleRemind, mess: messRemind)
        window.addSubview(view)
        view.hiddenView()
    }
    
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("Notification in app")
        showNoticationView()
    }
}
//extension AppDelegate: UNUserNotificationCenterDelegate {
//        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//            
//            if response.actionIdentifier == "remindLater" {
//                let newDate = Date(timeInterval: 900, since: Date())
//                let title = "Remind"
//                let remindContent = "content"
//                scheduleNotification(at: newDate, title: title, remindContent: remindContent)
//            }
//        }
//    }


