//
//  ImageFromURL APIClient.swift
//  2017_12_12 NSKeyedArchiver and Persistence
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
import UIKit
struct ImageFromURLAPIClient {
    private init() {}
    static let manager = ImageFromURLAPIClient()
    func getImage(from urlStr: String, completionHandler: @escaping (UIImage)->Void, errorHandler: @escaping (Error)->Void){
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badURL)
            return
        }
        let completionHandler: (Data)->Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {
                errorHandler(AppError.notAnImage)
                return
            }
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completionHandler, errorHandler: {print($0)})
    }
}
