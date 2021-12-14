//
//  AppDelegate.swift
//  HD Video Player
//
//  Created by macOS on 28/10/21.
//

import UIKit
import AVFoundation
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    //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
    //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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 2.0)
        let audioSession = AVAudioSession.sharedInstance()
           do {
               try audioSession.setCategory(.playback, mode: .moviePlayback)
           }
           catch {
               print("Setting category to AVAudioSessionCategoryPlayback failed.")
           }
           return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

