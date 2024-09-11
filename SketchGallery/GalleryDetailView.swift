//
//  GalleryDetailView.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//

import SwiftUI

struct GalleryDetailView: View {
    var sketch: Sketch
    
    var body: some View {
        ZStack {
            
            if let imagePath = ImageHelper.getFullPathForImage(sketch.imageName),
               let uiImage = UIImage(contentsOfFile: imagePath.path) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } else {
                Image("default")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }
            
            VStack {
                Spacer()
                
                ZStack (alignment: .center){
                    RoundedRectangle(cornerRadius: 25)
                        .fill(LinearGradient(colors: [Color(.black).opacity(0), Color(.black)], startPoint: .top, endPoint: .bottom))
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .opacity(0.8)
                    
                    VStack {
                        Text(sketch.title)
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Text(sketch.desc)
                            .font(.body)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    GalleryDetailView(sketch: Sketch())
}
