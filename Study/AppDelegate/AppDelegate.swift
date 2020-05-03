//
//  AppDelegate.swift
//  Study
//
//  Created by I on 2/17/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import UserNotifications
import SnapKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    let notificationCenter = UNUserNotificationCenter.current()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        build()
        requestAuthForLocalNotifications()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions.init(arrayLiteral: [.alert, .badge]))
    }

    func requestAuthForLocalNotifications() {
        notificationCenter.delegate = self

        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if error != nil {

            }
        }

        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
    }

    func scheduleNotification() {

        let content = UNMutableNotificationContent() // Содержимое уведомления

        content.title = "time"
        content.body = "цьуола"
        content.sound = UNNotificationSound.default
        content.badge = 1

        let timeFromMemory = StoreManager.shared().notificationTime()
        let date = timeFromMemory.split(separator: ":")
        var dateComponents = DateComponents()
        dateComponents.hour = Int(date[0])
        dateComponents.minute = Int(date[1])

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let identifier = AppKey.AppDelegate.localNotification
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }

}

private extension AppDelegate {

    func build() -> Void {

        buildRoot()
        buildNavigationBar()
        buildBarButtonItem()
        buildIQKeyboardManager()
    }

    func buildRoot() -> Void {

        let rootViewController = StoreManager.shared().token() == nil ?
            AuthorizationViewController(with: .loginWithEmail).inNavigate() : TabBarViewController()

        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = rootViewController
    }

    func buildNavigationBar() -> Void {
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "Arrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "Arrow")
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = AppColor.white.uiColor
        UINavigationBar.appearance().tintColor = AppColor.main.uiColor
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: AppColor.black.uiColor,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
    }

    func buildBarButtonItem() -> Void {

        //bar button item
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear, .font: UIFont.boldSystemFont(ofSize: 17)], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear, .font: UIFont.boldSystemFont(ofSize: 17)], for: .highlighted)

        //search bar cancel button
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColor.main.uiColor], for: .normal)
    }

    func buildIQKeyboardManager() -> Void {

        IQKeyboardManager.shared.toolbarDoneBarButtonItemImage = #imageLiteral(resourceName: "tick")
        IQKeyboardManager.shared.toolbarBarTintColor = AppColor.white.uiColor
        IQKeyboardManager.shared.toolbarTintColor = AppColor.main.uiColor
        IQKeyboardManager.shared.enable = true
    }
}

