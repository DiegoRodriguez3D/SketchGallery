//
//  ImageHelper.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//

import Foundation
import UIKit

struct ImageHelper {
    
    
    static func saveImageToDisk(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 1.0) ?? image.pngData() else {
            return nil
        }
        
        let fileManager = FileManager.default
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filename = "\(UUID().uuidString).jpg"
        let fileURL = docDirectory.appendingPathComponent(filename)
        
        do {
            try data.write(to: fileURL)
            return filename
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
}
