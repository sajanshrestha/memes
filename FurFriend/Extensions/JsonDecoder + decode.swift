//
//  JsonDecoder + decode.swift
//  Dog Images
//
//  Created by Sajan Shrestha on 7/10/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let response = try decoder.decode(T.self, from: data)
            
            return response
                            
        }
        catch {
            print(error.localizedDescription)
            return nil
            
        }
    }
    
}
