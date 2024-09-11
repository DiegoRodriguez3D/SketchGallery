//
//  ContentView.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//

import SwiftUI
import SwiftData

struct GalleryView: View {
    @State private var newSketch: Sketch?
    @State private var selectedSketch: Sketch?
    @Query private var sketches: [Sketch]
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                ZStack() {
                    VStack(alignment: .leading) {
                        Text("Sketches")
                            .font(.largeTitle)
                            .padding(.top, 70)
                            .bold()
                        
                        if sketches.count > 0 {
                            ScrollView(showsIndicators: false) {
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(sketches, id: \.id) { sketch in
                                        Group {
                                            if let imagePath = ImageHelper.getFullPathForImage(sketch.imageName),
                                               let uiImage = UIImage(contentsOfFile: imagePath.path) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 120, height: 120)
                                                    .clipped()
                                                    .cornerRadius(10)
                                            } else {
                                                Image("default")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 120, height: 120)
                                                    .clipped()
                                                    .cornerRadius(10)
                                            }
                                        }
                                        .onTapGesture {
                                            selectedSketch = sketch
                                        }
                                        .onLongPressGesture {
                                            newSketch = sketch
                                        }
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        else {
                            Spacer()
                            
                            HStack {
                                Spacer()
                                Button("Tap to add a new sketch") {
                                    newSketch = Sketch()
                                }
                                .buttonStyle(.bordered)
                                Spacer()
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 10)
                    .ignoresSafeArea()
                    
                    if sketches.count > 0 {
                        ZStack {
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    Button(action: {
                                        newSketch = Sketch()
                                    }, label: {
                                        ZStack {
                                            Circle()
                                                .frame(width: 70)
                                                .opacity(0.7)
                                            
                                            Image(systemName: "plus")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30)
                                                .foregroundStyle(.white)
                                        }
                                        .tint(.blue)
                                    })
                                }
                            }
                            .padding()
                        }
                        .ignoresSafeArea()
                    }
                }
            }
            .navigationDestination(item: $selectedSketch, destination: { sketch in
                GalleryDetailView(sketch: sketch)
            })
            .sheet(item: $newSketch) { sketch in
                let isEdit = sketch.title.trimmingCharacters(in: .whitespacesAndNewlines) != ""
                
                EditSketchView(sketch: sketch, isEditMode: isEdit)
                    .presentationDetents([.fraction(0.8)])
                    .presentationDragIndicator(.visible)
            }
            
            
        }
        .navigationTitle("Sketches")
        .navigationBarTitleDisplayMode(.large)
        .ignoresSafeArea()
    }
}

#Preview {
    GalleryView()
}
