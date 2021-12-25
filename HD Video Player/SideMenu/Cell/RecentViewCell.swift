//
//  RecentViewCell.swift
//  HD Video Player
//
//  Created by macOS on 23/12/21.
//

import UIKit

class RecentViewCell: UICollectionViewCell {

    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoDate: UILabel!
    @IBOutlet weak var videoSize: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var videoTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func moreVideoOption(_ sender: UIButton) {
        
    }
    
}
