//
//  MemesView.swift
//  Dog Images
//
//  Created by Sajan Shrestha on 9/10/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct MemesView: View {
    
    @ObservedObject var memeModel: MemeModel

    var body: some View {
                
        return NavigationView {
            
            List(memeModel.memes) { meme in
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Text(meme.userEmail)
                            .font(.headline)
                            .foregroundColor(.green)
                        Spacer()
                        
                        Divider()
                        Text(meme.sharedDate.getMediumFormat)
                    }
                    
                    ZStack {
                        
                        MemeImageView(meme: meme)
                        
                        NavigationLink(destination: Text("Detail"), label: {
                            EmptyView()
                        })
                    }
                    
                }
            }
            .navigationBarTitle(Text("Memes"))
        }
    }
}





struct MemeImageView: View {
    
    var meme: Meme
    
    var body: some View {
        
        ZStack {
            
            Image(uiImage: UIImage(data: meme.image)!)
                .resizable()
                .frame(height: height)
                .cornerRadius(cornerRadius)
            
            Text(meme.memeTextOne)
                .font(Font.system(size: fontSize, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .padding()
                .offset(y: (-height / 2) + fontSize)
            
            Text(meme.memeTextTwo ?? "No meme")
                .font(Font.system(size: fontSize, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .padding()
                .offset(y: (height / 2) - fontSize)
        }
    }
    
    // MARK:- CONSTANTS
    private let height: CGFloat = 300
    private let cornerRadius: CGFloat = 8
    private let fontSize: CGFloat = 30
}
