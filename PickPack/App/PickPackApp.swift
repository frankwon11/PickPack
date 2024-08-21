//
//  PickPackApp.swift
//  PickPack
//
//  Created by sseungwonnn on 7/5/24.
//

import SwiftUI

@main
struct PickPackApp: App {
    // 사용자 Auth 관리
    @StateObject var authManager: AppleAuthManager = AppleAuthManager()
    
    @StateObject var router: RouterManager = RouterManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
                .environmentObject(router)
        }
    }
}
