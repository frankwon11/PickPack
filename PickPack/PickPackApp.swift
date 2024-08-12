//
//  PickPackApp.swift
//  PickPack
//
//  Created by sseungwonnn on 7/5/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct PickPackApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // 사용자 Auth 관리
    @StateObject var authManager: AppleAuthManager = AppleAuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}
