//
//  Date + DateFormatter.swift
//  FurFriend
//
//  Created by Sajan Shrestha on 9/19/20.
//

import Foundation

extension Date {
    
    var getMediumFormat: String {
    
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: self)
    }
}


extension String {
    
    func getDate() -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.date(from: self) ?? Date()
    }
}
