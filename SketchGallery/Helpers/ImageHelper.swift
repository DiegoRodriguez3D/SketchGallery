//
//  ImageHelper.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//

import Foundation
import SwiftUI

struct ImageHelper {
    
    static func loadImage(named name: String) -> UIImage? {
        // Get image from local storage
        if let localImage = loadLocalImage(named: name) {
            return localImage
        }
        
        // If it's not found, tries to get it from assets
        return UIImage(named: name)
    }
    
    static func saveImage(_ imageData: Data, withName name: String, resizeTo size: CGSize? = nil) {
        var finalData = imageData

        // Resize image if needed
        if let size = size, let image = UIImage(data: imageData) {
            if let resizedImage = image.resize(to: size) {
                finalData = resizedImage.jpegData(compressionQuality: 0.8) ?? imageData
            }
        }

        let fileURL = getDocumentsDirectory().appendingPathComponent(name)
        try? finalData.write(to: fileURL)
    }
    
    static func loadLocalImage(named name: String) -> UIImage? {
        // Gets full path to local storage
        if let imagePath = getFullPathForImage(name)?.path {
            return UIImage(contentsOfFile: imagePath)
        }
        return nil
    }
    
    static func getFullPathForImage(_ imageName: String) -> URL? {
        let fileManager = FileManager.default
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(imageName)
    }
    
    private static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
