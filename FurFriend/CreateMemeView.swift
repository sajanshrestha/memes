//
//  CreateMemeView.swift
//  Dog Images
//
//  Created by Sajan Shrestha on 9/10/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct CreateMemeView: View {
    
    var image: UIImage
    
    @State private var memeTextOne = ""
    @State private var memeTextTwo = ""

    
    var memeModel: MemeModel
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            ZStack(alignment: .top) {
                
                Image(uiImage: image)
                    .resizable()
                
                TextField("Top Line Meme Text", text: $memeTextOne)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Bottom Line Meme Text", text: $memeTextTwo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(y: 40)
            }
            
            Button("Share Meme") {
                
                guard let userEmail = Auth.auth().currentUser?.email else { return }
                
                let meme = Meme(memeTextOne: self.memeTextOne, memeTextTwo: self.memeTextTwo, image: self.image.pngData()!, userEmail: userEmail)
                self.memeModel.saveMeme(meme: meme)
                
                self.presentation.wrappedValue.dismiss()
            }.rounded(activated: true)
            
            Button("Cancel") {
                
                self.presentation.wrappedValue.dismiss()
            }.rounded(activated: true)
        }
    }
}
