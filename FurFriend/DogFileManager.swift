
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

class MemeModel: ObservableObject {
    
    @Published private(set) var dogFiles = [DogFile]()
    @Published private(set) var displayedImage: UIImage?

    
    let dogImageCollectionRef = Firestore.firestore().collection("dogImages")
    
    init() {
        populateDogFiles()
        setDisplayedImage()
    }
    
    func populateDogFiles() {
                
        dogImageCollectionRef.getDocuments { (snapshot, error) in
            
            if let error = error {
                
                print(error)
            }
            else {
                
                for document in snapshot!.documents {
                    
                    let data = document.data()
                    let dogFile = DogFile(data: data)
                    print(data)
                    
                    self.dogFiles.append(dogFile)
                }
            }
        }
    }
    
    private func setDisplayedImage() {
         
         Service.getRandomDogImage(for: "random") { image in
             self.displayedImage = image
         }
     }
     
    
    func save(_ dogFile: DogFile) {
        
        dogFiles.append(dogFile)
        
        var data = dogFile.toDictionary()
        
        data["user"] = Auth.auth().currentUser?.email
        
        dogImageCollectionRef.document(dogFile.id).setData(data)
        
        print(dogFiles)
    }
    
    func delete(_ dogFile: DogFile) {
        
        guard let index = dogFiles.firstIndex(matching: dogFile) else { return }
        dogFiles.remove(at: index)
        
        dogImageCollectionRef.document(dogFile.id).delete()
    }
   
    func setRandomImage(for breed: String) {
        
        Service.getRandomDogImage(for: breed) { image in
            self.displayedImage = image
        }
    }

}

