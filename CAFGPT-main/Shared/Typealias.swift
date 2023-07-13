//
//  File.swift
//  CAFGPT
//
//  Created by CAF , twitter @ivd_2 CAF , twitter @ivd_2.
//

import SwiftUI

#if os(macOS)
import AppKit
#else
import UIKit
#endif

#if os(macOS)
public typealias kImage = NSImage
public typealias KColor = NSColor
#else
public typealias kImage = UIImage
public typealias KColor = UIColor
#endif


#if os(macOS)
extension kImage {
    func toImage() -> Image {
        Image(nsImage: self)
    }
}
#else
extension kImage {
    func toImage() -> Image {
        Image(uiImage: self)
    }
}
#endif
