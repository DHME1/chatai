//
//  MessageDataService.swift
//  CAFGPT (iOS)
//
//  Created by CAF , twitter @ivd_2 CAF , twitter @ivd_2.
//

import Foundation

struct MessageDataService: DataService {
    private let fileName = "messages"
    
    var dataURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentURL = paths[0]
        documentURL.appendPathComponent(fileName)
        return documentURL
    }
}
