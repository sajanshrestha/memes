//
//  Response.swift
//  Cat Images
//
//  Created by Sajan Shrestha on 7/8/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit

struct Response: Codable {
    var message: String
    var status: String
}


struct ListResponse: Codable {
    var message: [String: [String]]
    var status: String
}
