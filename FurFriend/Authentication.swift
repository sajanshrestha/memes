//
//  Authentication.swift
//  FurFriend
//
//  Created by Sajan Shrestha on 9/19/20.
//

import Foundation
import FirebaseAuth

struct Authentication {
    
    static func signIn(email: String, password: String, completion: @escaping (Bool) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
                completion(false)
            }
            
            else {
                completion(true)
            }
        }
    }
    
    static func signUp(email: String, password: String, completion: @escaping (Bool) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
                completion(false)
            }
            else {
                
                completion(true)
            }
        }
        
    }
}
