//
//  SavedImageObject.swift
//  2017_12_12 NSKeyedArchiver and Persistence
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
enum ImageKeys: String {
    case imageUserNameKey
    case fullSizeImageKey
    case smallSizeImageKey
}

class SavedImageObject: NSObject, NSCoding {
    var imageUserName: String
    var fullSizeImage: String
    var smallSizeImage: String
    init(imageUserName: String, fullsizeImage: String, smallImage: String) {
        self.imageUserName = imageUserName
        self.fullSizeImage = fullsizeImage
        self.smallSizeImage = smallImage
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let userName = aDecoder.decodeObject(forKey: ImageKeys.imageUserNameKey.rawValue) as? String else{
            return nil
        }
        guard let fullSizeImage =  aDecoder.decodeObject(forKey: ImageKeys.fullSizeImageKey.rawValue) as? String else {
            return nil
        }
        guard let smallSizeImage =  aDecoder.decodeObject(forKey: ImageKeys.smallSizeImageKey.rawValue) as? String else {
            return nil
        }
    self.init(imageUserName: userName, fullsizeImage: fullSizeImage, smallImage: smallSizeImage)
        
    }
    //the following function is used to encode the title and the descreption
    func encode(with aCoder: NSCoder) {
        aCoder.encode(imageUserName, forKey: ImageKeys.imageUserNameKey.rawValue)
        aCoder.encode(fullSizeImage, forKey: ImageKeys.smallSizeImageKey.rawValue)
        aCoder.encode(smallSizeImage, forKey: ImageKeys.smallSizeImageKey.rawValue)


    }
    
}
