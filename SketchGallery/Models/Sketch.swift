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
    var imageName: String = ""
    
    init() {
        id = UUID().uuidString
    }
    
    init(title: String, desc: String, date: Date, imageName: String) {
        self.id = UUID().uuidString
        self.title = title
        self.desc = desc
        self.date = Date()
        self.imageName = imageName
    }
}
