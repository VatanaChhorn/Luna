//
//  SceneDelegate.swift
//  Luna
//
//  Created by Chhorn Vatana on 7/26/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import UIKit
import SwiftUI
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let model = Model()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("sceneDidDisconnect")
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("sceneDidBecomeActive")
        
        UserDefaults.standard.set(false, forKey: self.model.processingBool)
        UserDefaults.standard.set(false, forKey: self.model.extremeMode)
             print("ProcessBool when app become Active : \(UserDefaults.standard.bool(forKey: self.model.processingBool))")
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("sceneWillResignActive")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("sceneWillEnterForeground")
        
        //MARK: - Ask for notification authorization when the app launch
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (sucess, error) in
            if sucess {
                print("The user granded the permission!")
            } else   {
                print("The user denies the request.")
            }
            if error != nil {
                print(error!)
            }
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("SceneDidEnterBackground")
        
        let name = UserDefaults.standard.string(forKey: "AnimationImage")
        
        //MARK: - Push the local notification if user leaves the app.
        
        let defaults = UserDefaults.standard
        
        //Modify the notification view
        let content = UNMutableNotificationContent()
        content.title = "Luna - Stay Focus"
        content.subtitle = "Come back to the app 🌖."
        if name == "Work" {
            content.body = "You're not supposed to get distracted during working."
        } else if name == "Study" {
               content.body = "You're not supposed to get distracted during studying."
        } else if name == "Meditate" {
               content.body = "You're not supposed to get distracted during meditating."
        }    else {
            content.body = "Your're not supposed to get distracted."
        }
        
        content.sound = UNNotificationSound.default
        
        // set the time inverval to trigger the notification // 2 seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        // A request to schedule a local notification, which includes the content of the notification and the trigger conditions for delivery.
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        //print ProcessBool when app running in background.
        print("ProcessBool in background : \(defaults.bool(forKey: self.model.processingBool))")
        if defaults.bool(forKey: self.model.processingBool ) {
            UNUserNotificationCenter.current().add(request) { (error) in
                if error != nil {
                    print(error!)
                }
            }
        } else {
            print("User haven't started the timer.")
        }
        
        //MARK: - Check Extreme Mode
        
        if defaults.bool(forKey: self.model.extremeMode) {
            exit(-1)
        }
        
    }
    
    
}

