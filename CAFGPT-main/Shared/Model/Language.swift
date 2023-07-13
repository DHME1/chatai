//
//  Language.swift
//  CAFGPT
//
//  Created by CAF , twitter @ivd_2 CAF , twitter @ivd_2
//

import Foundation

enum Language: CaseIterable, Identifiable {

    case en
    case ar
    
    var id: String {
        self.tag
    }
    
    var name: String {
        switch self {
        case .en:
            return "English"
        case .ar:
            return "العربية"
        }
    }
    
    var tag: String {
        switch self {
        case .en:
            return "en-US"
        case .ar:
            return "ar-SA"
        }
    }
}
