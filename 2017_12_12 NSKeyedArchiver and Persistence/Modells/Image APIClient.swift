//
//  Image APIClient.swift
//  2017_12_12 NSKeyedArchiver and Persistence
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
enum HTTPVerb: String {
    case GET
    case POST
}
import Foundation
struct ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImages(for searchTerm: String, completionHandler: @escaping ([Image]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        let apiKey =  "7290269-87746c9ade9d3696fd00edbce"
        let urlStr = "https://pixabay.com/api/?key=\(apiKey)&q=\(searchTerm)&image_type=photo"
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let results = try JSONDecoder().decode(totalResults.self, from: data)
                completionHandler(results.hits)
            }
            catch {
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}

