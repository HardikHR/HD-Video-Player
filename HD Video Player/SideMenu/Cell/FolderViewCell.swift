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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
