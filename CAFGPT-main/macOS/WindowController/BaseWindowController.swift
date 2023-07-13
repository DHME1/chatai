//
//  BaseWindowController.swift.swift
//  CAFGPT (macOS)
//
//  Created by CAF , twitter @ivd_2 dhme 2023/2/21.
//

import SwiftUI


class BaseWindowController: NSWindowController, NSWindowDelegate {
    
    var onWindowClose: (() -> Void)?
    
    class func Create<T: ObservableObject>(viewModel: T) -> NSWindowController {
        fatalError("Must be implement by sub class")
    }

    override func showWindow(_ sender: Any?) {
        super.showWindow(sender)
        
        NSApp.activate(ignoringOtherApps: true)
        
        window?.center()
        window?.makeKeyAndOrderFront(self)
        window?.delegate = self
    }
    
    func windowWillClose(_ notification: Notification) {
        onWindowClose?()
    }
}

