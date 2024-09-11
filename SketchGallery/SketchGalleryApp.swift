//
//  SketchGalleryApp.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//

import SwiftUI

@main
struct SketchGalleryApp: App {
    
    @AppStorage("onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            GalleryView()
                .modelContainer(for: Sketch.self)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    // on dismiss
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                }
        }
    }
}
