//
//  CAFGPTApp.swift
//  Shared
//
//  Created by CAF , twitter @ivd_2 dhme 2023/2/17.
//

import SwiftUI

@main
struct ChatGPTApp: App {
    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
        }
    }
}
