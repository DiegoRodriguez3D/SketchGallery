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
    //@Query private var sketches: [Sketch]
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        
        
        NavigationStack {
            ZStack() {
                VStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(0..<20, id: \.self) { sketch in
                                NavigationLink(destination: Text("Detalle del Boceto")) {
                                    VStack {
                                        Image("image-1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 110, height: 110)
                                            .clipped()
                                            .cornerRadius(10)
                                            .shadow(radius: 3)
                                    }
                                }
                            }
                        }
                        .padding(.top, 80)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .ignoresSafeArea()
                
                ZStack {
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Button(action: {
                                //Todo: Add new Sketch
                                
                            }, label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 70)
                                    
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .foregroundStyle(.white)
                                }
                                .tint(.black)
                            })
                        }
                    }
                    .padding()
                }
                .ignoresSafeArea()
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
