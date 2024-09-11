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
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        
        NavigationStack {
            ZStack() {
                VStack(alignment: .leading) {
                    Text("Sketches")
                        .font(.largeTitle)
                        .padding(.top, 70)
                        .bold()
                    
                    if sketches.count > 0 {
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(sketches, id: \.id) { sketch in
                                    Group {
                                        if let imagePath = ImageHelper.getFullPathForImage(sketch.imageName),
                                           let uiImage = UIImage(contentsOfFile: imagePath.path) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: .infinity)
                                                .cornerRadius(10)
                                                .shadow(radius: 10)
                                                .padding()
                                        } else {
                                            Image("default")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: .infinity)
                                                .cornerRadius(10)
                                                .shadow(radius: 10)
                                                .padding()
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
                .padding(.horizontal)
                .ignoresSafeArea()
                
                if sketches.count > 0 {
                    ZStack {
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Button(action: {
                                    //Todo: Add new Sketch
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
            .sheet(item: $newSketch) { sketch in
                let isEdit = sketch.title.trimmingCharacters(in: .whitespacesAndNewlines) != ""
                
                EditSketchView(sketch: sketch, isEditMode: isEdit)
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
