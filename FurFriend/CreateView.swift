//
//  ContentView.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct CreateView: View {
    
    @State private var selectedBreed = 0
    @State private var breeds = ["random"]
    
    @State private var showCreateMemeView = false
    
    @ObservedObject var imageLoader = ImageLoader()
    
    @ObservedObject var memeModel: MemeModel
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                PickerView(breeds: breeds, selectedBreed: $selectedBreed)
                
                Spacer()
                
                if imageLoader.displayedImage != nil {
                    
                    Image(uiImage: imageLoader.displayedImage!)
                        .resizable()
                        .scaledToFit()
                }
                
                else {
                    
                    Image(systemName: "hourglass").imageScale(.large).spinning()
                }
                
                Spacer()
                
            }
            .navigationBarItems(
                
                leading: Button("Create Meme") { self.showCreateMemeView = true },
                trailing: Button(action: { self.nextImage() }, label: { Text("Next")})
            )
            .onAppear {
                self.setBreeds()
                self.nextImage()
                
            }
            .sheet(isPresented: $showCreateMemeView) { CreateMemeView(image: self.imageLoader.displayedImage ?? UIImage(), memeModel: memeModel) }
        }
    }
    
    private func nextImage() {
        
        imageLoader.setRandomImage(for: breeds[selectedBreed])
    }
    
    private func setBreeds() {
        
        Service.getBreedList { breeds in
            self.breeds.append(contentsOf: breeds)
            
        }
    }
    
    private let height: CGFloat = 300
}


struct PickerView: View {
    
    var breeds: [String]
    @Binding var selectedBreed: Int
    
    var body: some View {
        
        Form {
            Picker("Breed", selection: $selectedBreed) {
                ForEach(0..<breeds.count, id: \.self) { index in
                    Text(self.breeds[index])
                }
            }
        }
        .frame(height: 100)
    }
}
