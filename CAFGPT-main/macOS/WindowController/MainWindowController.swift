//
//  MainWindowController.swift
//  CAFGPT (macOS)
//
//  Created by CAF , twitter @ivd_2 CAF , twitter @ivd_2.
//

import SwiftUI

class MainWindowController: BaseWindowController {
    
    override class func Create<T: ObservableObject>(viewModel: T) -> MainWindowController {
        let window = NSWindow()
        window.center()
        window.styleMask = [.titled, .closable, .miniaturizable, .resizable]
        window.title = "ChatGPT"

        let vc = MainWindowController(window: window)

        let rootView = MainView()
            .frame(minWidth: 900,
                   maxWidth: .infinity,
                   minHeight: 600,
                   maxHeight: .infinity)
            .environmentObject(viewModel)
        
        vc.contentViewController = NSHostingController(rootView: rootView)
        return vc
    }
}
