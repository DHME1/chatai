//
//  View+Extension.swift
//  CAFGPT
//
//  Created by CAF , twitter @ivd_2 dhme 2023/2/22.
//

import SwiftUI

extension View {
    
    /// Show alert with destructive style button.
    func destructiveAlert(isPresented: Binding<Bool>, title: String, primaryButtonAction: (() -> Void )?) -> some View {
        
        self.alert(isPresented: isPresented) {
            Alert(title: Text(LocalizedStringKey(title)),
                  primaryButton: .destructive(Text(LocalizedStringKey("Confirm")), action: primaryButtonAction),
                  secondaryButton: .cancel())
        }
    }
}
