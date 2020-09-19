//
//  MainView.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    let memeModel = MemeModel()
    
    var body: some View {
        
        TabView {
            
            MemesView(memeModel: memeModel)
            .tabItem({
                Image(systemName: "house")
                Text("Home")
            })
            
            CreateView(memeModel: memeModel)
                .tabItem({
                    Image(systemName: "plus.square.fill")
                    Text("Create")
                })
        }
    }
}
