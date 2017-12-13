//
//  DetailedImageViewController.swift
//  2017_12_12 NSKeyedArchiver and Persistence
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class DetailedImageViewController: UIViewController {

    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var likes: UILabel!
    
    var image: Image?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image{
            userName.text = image.user
            ImageFromURLAPIClient.manager.getImage(from: image.webformatURL, completionHandler: {self.selectedImage.image = $0}, errorHandler: {print($0)})
        }
    }

    @IBAction func saveImageButton(_ sender: UIButton) {
        guard let image = image else {return}
        DataModel.shared.addImageToFavoriteList(imageItem: image)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
