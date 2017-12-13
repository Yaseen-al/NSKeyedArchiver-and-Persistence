//
//  FavouriteImageViewController.swift
//  2017_12_12 NSKeyedArchiver and Persistence
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class FavouriteImageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var savedImageTableView: UITableView!
    
    var savedImages = [Image](){
        didSet{
           savedImageTableView.reloadData()
            print("it is reloding\(savedImages.count)")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageSetup = savedImages[indexPath.row]
        guard let cell: UITableViewCell = savedImageTableView.dequeueReusableCell(withIdentifier: "myCell") else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = imageSetup.user
            return defaultCell
        }
        cell.textLabel?.text = imageSetup.user
        cell.imageView?.image = nil
        ImageFromURLAPIClient.manager.getImage(from: imageSetup.previewURL, completionHandler: {cell.imageView?.image = $0; cell.setNeedsLayout()}, errorHandler: {print($0)})
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.savedImageTableView.delegate = self
        self.savedImageTableView.dataSource = self
        print(DataModel.shared.loadImageFavoriteList())
        print(DataModel.shared.getImageFavoriteList())
        self.savedImages = DataModel.shared.getImageFavoriteList()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.savedImages = DataModel.shared.getImageFavoriteList()
//        self.savedImages = DataModel.shared.getImageFavoriteList()
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
