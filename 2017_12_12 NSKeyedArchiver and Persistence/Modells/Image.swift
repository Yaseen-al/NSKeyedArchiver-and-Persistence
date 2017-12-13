//
//  Image.swift
//  2017_12_12 NSKeyedArchiver and Persistence
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct totalResults: Codable {
    let hits: [Image]
}
struct Image: Codable {
    let webformatURL: String
    let previewURL: String
    let user: String
    let likes: Int
}
