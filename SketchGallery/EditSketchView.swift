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
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Text(isEditMode ? "Edit Sketch" : "New Sketch")
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                        .bold()
                    
                    Spacer()
                    
                    if isEditMode {
                        
                        Button(action: {
                            showConfirmation.toggle()
                        }, label: {
                            Image("delete")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundStyle(.red)
                        })
                    }
                }
                
                HStack {
                    Spacer()
                    
                    ZStack {
                        
                        PhotosPicker(selection: $selectedImage, matching: .images) {
                            if(imageData == nil) {
                                Label("Select Image", systemImage: "photo")
                                    .labelStyle(.iconOnly)
                                    .foregroundStyle(.white)
                                    .frame(width: 200, height: 200)
                                    .background(Color.blue.opacity(0.8))
                                    .cornerRadius(10)
                            }else {
                                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .clipped()
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .onChange(of: selectedImage) { previousItem, newItem in
                            Task {
                                await loadImage(from: newItem)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 20)
                
                
                VStack {
                    TextField("Title", text: $sketchName)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: sketchName) { oldValue, newValue in
                            sketchName = TextHelper.limitChars(input: sketchName, limit: 30)
                        }
                    
                    
                    TextField("Description", text: $sketchDesc, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: sketchDesc) { oldValue, newValue in
                            sketchDesc = TextHelper.limitChars(input: sketchDesc, limit: 300)
                        }
                }
                
                Button{
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
                } label: {
                    Text(isEditMode ? "Save" : "Add")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 400, height: 44)
                        .background(.blue)
                        .cornerRadius(8)
                }
                .disabled(sketchName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || imageData == nil)
                
                Spacer()
            }
            .padding()
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
            if let uiImage = ImageHelper.loadImage(named: sketch.imageName) {
                imageData = uiImage.jpegData(compressionQuality: 1.0)
            }
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
