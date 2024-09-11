//
//  GalleryDetailView.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//

import SwiftUI

struct GalleryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var showConfirmation: Bool = false
    
    var sketch: Sketch
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if let imagePath = ImageHelper.getFullPathForImage(sketch.imageName),
                   let uiImage = UIImage(contentsOfFile: imagePath.path) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .ignoresSafeArea()
                } else {
                    Image("default")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .ignoresSafeArea()
                }
                
                VStack {
                    
                    Spacer()
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(LinearGradient(colors: [Color(.black).opacity(0), Color(.black)], startPoint: .top, endPoint: .bottom))
                            .frame(width: geo.size.width, height: geo.size.height/3)
                            .opacity(0.8)
                        
                        VStack(alignment:.leading ,spacing: 10) {
                            Text(sketch.title)
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .bold()
                            
                            
                            Text(sketch.desc)
                                .font(.body)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal)
                    }
                }
                
            }
        }
        .toolbar(content: {
            Button {
                showConfirmation.toggle()
            } label: {
                Image("delete")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
            }
        })
        .confirmationDialog("Are you sure you want to delete this sketch?", isPresented: $showConfirmation) {
            Button("Delete", role: .destructive) {
                withAnimation {
                    context.delete(sketch)
                }
                dismiss()
            }
        }
        .ignoresSafeArea()
    }
}
