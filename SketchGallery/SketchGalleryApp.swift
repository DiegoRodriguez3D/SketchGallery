//
//  SketchGalleryApp.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//

import SwiftUI

@main
struct SketchGalleryApp: App {
    
    var body: some Scene {
        WindowGroup {
            GalleryView()
                .modelContainer(for: Sketch.self)
        }
    }
}
