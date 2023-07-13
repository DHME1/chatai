//
//  CAFGPTMac.swift
//  CAFGPT (macOS)
//
//  Created by CAF , twitter @ivd_2 CAF , twitter @ivd_2.
//

import SwiftUI

@main
struct ChatGPTMac: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView()
                .frame(width: 0.1, height: 0.1)
                .hidden()
        }
    }
}


