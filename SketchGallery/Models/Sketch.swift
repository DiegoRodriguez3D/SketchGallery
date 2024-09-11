//
//  Sketch.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//

import Foundation
import SwiftData

@Model
class Sketch {
    @Attribute(.unique) var id: String
    var title: String = ""
    var desc: String = ""
    var date = Date()
    var imagePath: String = ""
    
    init() {
        id = UUID().uuidString
    }
}
