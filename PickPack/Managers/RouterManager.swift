//
//  RouterManager.swift
//  PickPack
//
//  Created by sseungwonnn on 8/21/24.
//

import SwiftUI

class RouterManager: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder func view(for route: PickPackView) -> some View {
        switch route {
        case .mainView:
            MainView()
            
        case .roomView:
            RoomView()
            
        case .historyView:
            HistoryView()
            
        case .settingView:
            SettingView()
        case .roomSettingView:
            RoomSettingView()
        case .faqView:
            FAQView()
        case .readyRoomView:
            ReadyRoomView()
        case .createRoomView:
            CreateRoomView()
        }
    }
    
    func push(view: PickPackView) {
        path.append(view)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func backToRoom() {
        self.path = NavigationPath()
        path.append(PickPackView.roomView)
    }
    
    func backToMain() {
        self.path = NavigationPath()
        path.append(PickPackView.mainView)
    }
}

enum PickPackView: Hashable {
    case mainView
    
    case roomView
    
    case historyView
    
    case settingView
    
    case roomSettingView
    
    case faqView
    
    case readyRoomView
    
    case createRoomView
}
