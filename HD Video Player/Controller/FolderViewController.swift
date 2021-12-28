//
//  FolderViewController.swift
//  HD Video Player
//
//  Created by macOS on 29/10/21.
//


import UIKit
import Photos

class FolderViewController: UITableViewController {
    
    @IBOutlet var folderTableview: UITableView!
    @IBOutlet weak var menu: UIBarButtonItem!
    let foldermodel = [folderModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navControl()
        navigationController?.navigationBar.tintColor = .white
        menu.target = self.revealViewController()
        menu.action = #selector(self.revealViewController()?.revealSideMenu)
    }
    
    @IBAction func SideMenu(_ sender: Any) {
    }
    
    @IBAction func SearchBtn(_ sender: Any) {
    }
    
    @IBAction func refreshBtn(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func MoreBtn(_ sender: UIBarButtonItem) {
    }
    
    func navControl() {
       if self.navigationController == nil {
           return
       }
       let navView = UIView()
       let label = UILabel()
       label.text = "HD Video Player"
       label.textColor = UIColor.white
       label.sizeToFit()
       label.center = navView.center
       label.textAlignment = NSTextAlignment.center
       let image = UIImageView()
       image.image = UIImage(named: "LaunchScreen")
       let imageAspect = image.image!.size.width/image.image!.size.height
       image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
       image.contentMode = UIView.ContentMode.scaleAspectFit
       navView.addSubview(label)
       navView.addSubview(image)
       self.navigationItem.titleView = navView
       navView.sizeToFit()
   }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderViewCell", for: indexPath) as! FolderViewCell
        return cell
    }
    
//MARK:- Get Folder -

}

class CustomPhotoAlbum {

    static let albumName = "Flashpod"
    static let sharedInstance = CustomPhotoAlbum()
    var assetCollection: PHAssetCollection!

    init() {
        func fetchAssetCollectionForAlbum() -> PHAssetCollection! {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
            let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            if let firstObject: AnyObject = collection.firstObject {
                print(firstObject)
                return collection.firstObject!
            }
            return nil
        }

        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            return
        }

        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)
        }) { success, _ in
            if success {
                self.assetCollection = fetchAssetCollectionForAlbum()
            }
        }
    }
}

