//
//  TextHelper.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//

import Foundation

struct TextHelper {
    
    static func limitChars(input: String, limit: Int) -> String {
        if input.count > limit {
            return String(input.prefix(limit))
        }
        return input
    }
}
