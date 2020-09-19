//
//  FurFriendApp.swift
//  FurFriend
//
//  Created by Sajan Shrestha on 9/18/20.
//

import SwiftUI
import Firebase

@main
struct FurFriendApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            LoginView().onAppear { FirebaseApp.configure() }
        }
    }
}
