//
//  VideoViewController.swift
//  HD Video Player
//
//  Created by macOS on 29/10/21.
//

import UIKit

class VideoViewController: UITableViewController {
    
    @IBOutlet var collectionview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:50.0, height:50.0))
        imageView.image = UIImage(named: "LaunchScreen")
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        let morebtn = UIBarButtonItem(image: UIImage(named: "more")!,  style: .plain, target: self, action: nil)
        let searchButton = UIBarButtonItem(image: UIImage(systemName:"repeat.circle")!,  style: .plain, target: self, action: nil)
        let editButton = UIBarButtonItem(image: UIImage(systemName:"magnifyingglass")!,  style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [editButton, searchButton,morebtn]
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoViewCell", for: indexPath) as! VideoViewCell
        return cell
    }
}
