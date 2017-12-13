//
//  DataModel.swift
//  2017_12_12 NSKeyedArchiver and Persistence
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation


class DataModel {
    //step one is to make your file name
    static let kPathName = "ImageFavoriteList.plist"
    //intiate your class as a single tone
    private init(){}
    static let shared = DataModel()
    //create your data storage and saving when you update it
    private var imagelist = [Image]() {
        didSet {
            saveImageFavoriteList()
            print(documentDirectory()) //to print the directory of your file
        }
    }
    //Assign your methods of creating your directory, make the file path, load your data from the file, save your data, get your data storage after it has been loaded
    //returns Documents directory path for the App
    func documentDirectory()->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0] //the 0 is the document folder
    }
    
    //returns supplied path name in documents directory
    private func dataFilePath(pathName: String)->URL {
        return DataModel.shared.documentDirectory().appendingPathComponent(pathName)
    }
    
    //Load you need to load your data in the view didlOad in order to acces the stuff saved on the app if you didn't do that you will have it empty
    //what is happening in loading is just decoding what the list have
    func loadImageFavoriteList(){
        //make your decoder
        let decoder = PropertyListDecoder()
        // make the path
        let path = dataFilePath(pathName: DataModel.kPathName)
        do {
            //try to get the raw data using the path
            let data = try Data.init(contentsOf: path)
            // convert the raw data to a specific type
            imagelist = try decoder.decode([Image].self, from: data)
        } catch {print("decoder error: \(error.localizedDescription)")}
    }
    
    //Save (encode)
    func saveImageFavoriteList(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(imagelist)
            try data.write(to: dataFilePath(pathName: DataModel.kPathName), options: .atomic)
        }
        catch {print("encoder error: \(error.localizedDescription)")}
    }
    
    //Read (get) after it has been loaded at the begining of the programe
    func getImageFavoriteList() -> [Image]{
        return imagelist
    }
    
    
    //Add
    func addImageToFavoriteList(imageItem item: Image) {
        imagelist.append(item)
    }
    //Update
    func updateImageFavoriteList(withUpdatedItem item: Image){
        if let index = imagelist.index(where: {$0.user == item.user}) {
            imagelist[index] = item
        }
    }
    //Delete selected image from Favorite List
    func deleteFromImageFavoriteList(fromIndex index: Int){
        imagelist.remove(at: index)
    }
    
}
