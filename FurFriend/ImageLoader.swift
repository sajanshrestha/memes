//
//  ImageLoader.swift
//  FurFriend
//
//  Created by Sajan Shrestha on 9/18/20.
//

import UIKit


class ImageLoader: ObservableObject {
    
    @Published private(set) var displayedImage: UIImage?

    init() {
        setRandomImage()
    }
    
    func setRandomImage(for breed: String = "random") {
        
        Service.getRandomDogImage(for: breed) { image in
            self.displayedImage = image
        }
    }
}
