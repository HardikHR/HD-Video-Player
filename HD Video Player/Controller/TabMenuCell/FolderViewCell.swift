//
//  FolderViewCell.swift
//  HD Video Player
//
//  Created by macOS on 29/10/21.
//

import UIKit

class FolderViewCell: UITableViewCell {

    @IBOutlet weak var folderImg: UIImageView!
    @IBOutlet weak var folderNamelbl: UILabel!
    @IBOutlet weak var videoCountlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}