//
//  AddSketch.swift
//  SketchGallery
//
//  Created by Diego Rodriguez on 11/9/24.
//
import SwiftUI
import PhotosUI

struct EditSketchView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var sketch: Sketch
    var isEditMode: Bool
    @State private var sketchName: String = ""
    @State private var sketchDesc: String = ""
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    ZStack {
                        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        }

                        PhotosPicker(selection: $selectedImage, matching: .images) {
                            Text("Select Image")
                        }
                        .onChange(of: selectedImage) { previousItem, newItem in
                            Task {
                                await loadImage(from: newItem)
                            }
                        }
                    }
                }
                Spacer()
                
                
                Text(isEditMode ? "Edit Sketch" : "New Sketch")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                TextField("Title", text: $sketchName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                TextField("Description", text: $sketchDesc, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack {
                    Button(isEditMode ? "Save" : "Add") {
                        // Guarda la imagen localmente y obtén su nombre
                        guard let imageData = imageData else { return }
                        let imageName = UUID().uuidString
                        
                        // LLamar a ImageHelper para almacenar la imagen reescalada
                        ImageHelper.saveImage(imageData, withName: imageName)
                        
                        sketch.imageName = imageName
                        sketch.title = sketchName
                        sketch.desc = sketchDesc
                        
                        if !isEditMode {
                            withAnimation {
                                context.insert(sketch)
                            }
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(sketchName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    
                    if isEditMode {
                        Button("Delete") {
                            showConfirmation.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .confirmationDialog("Are you sure you want to delete this sketch?", isPresented: $showConfirmation) {
            Button("Delete", role: .destructive) {
                withAnimation {
                    context.delete(sketch)
                }
                dismiss()
            }
        }
        .onAppear {
            sketchName = sketch.title
            sketchDesc = sketch.desc
        }
    }
    
    func loadImage(from newItem: PhotosPickerItem?) async {
        guard let newItem = newItem else { return }
        if let data = try? await newItem.loadTransferable(type: Data.self) {
            DispatchQueue.main.async {
                imageData = data
            }
        }
    }
}
