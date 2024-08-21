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
    // 사용자 Auth 관리
    @StateObject var authManager: AppleAuthManager = AppleAuthManager()
    
    @StateObject var router: RouterManager = RouterManager()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path){
                MainView()
                    .navigationDestination(for: PickPackView.self){ pickPackView in
                        router.view(for: pickPackView)
                    }
            }
            .tint(.black)
            .environmentObject(authManager)
            .environmentObject(router)
//            FirebaseLoginTest()
//                .environmentObject(authManager)
            
            
        }
    }
}
