//
//  FolderViewCell.swift
//  HD Video Player
//
//  Created by macOS on 23/12/21.
//

import UIKit

class FolderViewCell: UITableViewCell {
    
    @IBOutlet weak var folderImg: UIImageView!
    @IBOutlet weak var folderName: UILabel!
    @IBOutlet weak var CountVideo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        folderName.text = "Untitled"
        CountVideo.text = "0 photos"
        folderImg.image = nil
        folderImg.isHidden = true
        folderImg.isHidden = false
    }
    
    func update(title: String?, count: Int) {
        folderName.text = title ?? "Untitled"
        CountVideo.text = "\(count.description) \(count == 1 ? "photo" : "photos")"
    }
}

