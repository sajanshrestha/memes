//
//  Service.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit
import Combine

struct Service {
    
    static let session = URLSession.shared
    
    static var responseCancellable: AnyCancellable?
    static var imageCancellable: AnyCancellable?
    static var breedListCancellable: AnyCancellable?
    
        
    enum EndPoint {
        
        case randomDogImage
        case randomBreedImage(breed: String)
        case breedList
        
        var url: URL {
            
            switch self {
                
            case .randomDogImage:
                return URL(string: "https://dog.ceo/api/breeds/image/random")!
                
            case .randomBreedImage(let breed):
                return URL(string: "https://dog.ceo/api/breed/\(breed)/images/random")!
                
            case .breedList:
                return URL(string: "https://dog.ceo/api/breeds/list/all")!
            }
        }
    }
        
    static func getRandomDogImage(for breed: String, completion: @escaping (UIImage) -> Void) {
        
        if breed == "random" {
            
            getImage(with: EndPoint.randomDogImage.url) { image in
                completion(image)
            }
        }
            
        else {
            
            getImage(with: EndPoint.randomBreedImage(breed: breed).url) { image in
                completion(image)
            }
        }
    }
    
    static func getImage(with url: URL, completion: @escaping (UIImage) -> Void) {
        
        getResponse(with: url) { response in
            
            guard let imageUrl = URL(string: response.message) else { return }
            
            imageCancellable = session
                .dataTaskPublisher(for: imageUrl)
                .map { data, response in
                    UIImage(data: data)}
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { image in
                    completion(image!)
                })
        }
    }
    
    static private func getResponse(with url: URL, completion: @escaping (Response) -> Void) {
        
        responseCancellable = session
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .replaceError(with: Response(message: "Error", status: "Error occured"))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { response in
                completion(response)
            })
        
    }
    
    static func getBreedList(completion: @escaping ([String]) -> Void) {
        
        breedListCancellable = session.dataTaskPublisher(for: EndPoint.breedList.url)
            .map(\.data)
            .decode(type: ListResponse.self, decoder: JSONDecoder())
            .map { $0.message }
            .replaceError(with: [:])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { message in
                let breeds = message.map { $0.key }
                completion(breeds)
            })
    }
}
