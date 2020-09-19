
//
//  FavoriteDogModel.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/9/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


struct Meme: Identifiable {
    
    var memeTextOne: String
    var memeTextTwo: String?
    var image: Data
    var userEmail: String
    var id = UUID().uuidString
    var sharedDate = Date()
    
    func toDictionary() -> [String: Any] {
        
        [
            "id": self.id,
            "image": self.image,
            "userEmail": self.userEmail,
            "memeTextOne": self.memeTextOne,
            "memeTextTwo": self.memeTextTwo ?? "",
            "date": self.sharedDate.getMediumFormat
        ]
    }
    
}

extension Meme {
    
    init(from data: [String: Any]) {
        
        let id = data["id"] as? String ?? ""
        let image = data["image"] as? Data ?? Data()
        let userEmail = data["userEmail"] as? String ?? ""
        let memeTextOne = data["memeTextOne"] as? String ?? ""
        let memeTextTwo = data["memeTextTwo"] as? String ?? ""
        let dateString = data["date"] as? String ?? ""
        
        self.id = id
        self.image = image
        self.userEmail = userEmail
        self.memeTextOne = memeTextOne
        self.memeTextTwo = memeTextTwo
        self.sharedDate = dateString.getDate()
    }
}

class MemeModel: ObservableObject {
    
    @Published private(set) var memes = [Meme]()
    
    let memeCollectionRef = Firestore.firestore().collection("memes")
    
    init() {
        populateMemes()
    }
    
    func populateMemes() {
                
        memeCollectionRef
            .order(by: "date")
            .getDocuments { (snapshot, error) in
            
            if let error = error {
                
                print(error)
            }
            else {
                
                for document in snapshot!.documents {
                    
                    let data = document.data()
                    let meme = Meme(from: data)
                    
                    self.memes.append(meme)
                }
            }
        }
    }
    
    func saveMeme(meme: Meme) {
        
        memes.append(meme)
        
        let memeCollectionRef = Firestore.firestore().collection("memes")

        memeCollectionRef.addDocument(data: meme.toDictionary())
        
    }
    
    func delete(meme: Meme) {
        
    }

}

