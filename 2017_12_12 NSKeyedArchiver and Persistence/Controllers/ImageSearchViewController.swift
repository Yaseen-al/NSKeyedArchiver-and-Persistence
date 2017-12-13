//
//  ImageSearchViewController.swift
//  2017_12_12 NSKeyedArchiver and Persistence
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class ImageSearchViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var imagesSearchBar: UISearchBar!
    @IBOutlet weak var imagesTableView: UITableView!
    
    var images = [Image](){
        didSet{
            imagesTableView.reloadData()
        }
    }
    
    var searchTerm: String?{
        didSet{
            loadImages()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageSetup = images[indexPath.row]
        guard let cell: UITableViewCell = imagesTableView.dequeueReusableCell(withIdentifier: "myCell") else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = imageSetup.user
            return defaultCell
        }
        cell.textLabel?.text = imageSetup.user
        cell.imageView?.image = nil
        ImageFromURLAPIClient.manager.getImage(from: imageSetup.previewURL, completionHandler: {cell.imageView?.image = $0; cell.setNeedsLayout()}, errorHandler: {print($0)})
        return cell
    }
    
    
    func loadImages(){
        guard let serchTerm = searchTerm else{return}
        ImageAPIClient.manager.getImages(for: serchTerm, completionHandler: {self.images = $0}, errorHandler: {print($0)})
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagesTableView.delegate = self
        self.imagesTableView.dataSource = self
        self.imagesSearchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination  as? DetailedImageViewController{
            let imageSetup = images[(imagesTableView.indexPathForSelectedRow?.row)!]
            destination.image = imageSetup
        }
        
    }
    

}
