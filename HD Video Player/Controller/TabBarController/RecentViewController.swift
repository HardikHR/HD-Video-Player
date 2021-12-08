//
//  RecentViewController.swift
//  HD Video Player
//
//  Created by macOS on 29/10/21.
//

import UIKit

class RecentViewController: UITableViewController {

    @IBOutlet var collectionView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navControl()
        let searchButton = UIBarButtonItem(image: UIImage.init(named: "refresh"),  style: .plain, target: self, action: nil)
        let editButton = UIBarButtonItem(image: UIImage.init(named: "search"),  style: .plain, target: self, action: nil)
        let morebtn = UIBarButtonItem(image: UIImage(named: "more")!,  style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [searchButton, editButton ,morebtn]
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
}
