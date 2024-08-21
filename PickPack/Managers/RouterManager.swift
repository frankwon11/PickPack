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
        }
    }
    
    func push(view: PickPackView){
        path.append(view)
    }
    
    func pop(){
        path.removeLast()
    }
    
    func backToMap(){
        self.path = NavigationPath()
        path.append(PickPackView.mainView)
    }
}

enum PickPackView: Hashable {
    case mainView
    
}
