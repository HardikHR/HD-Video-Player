//
//  VideoViewCell.swift
//  HD Video Player
//
//  Created by macOS on 29/10/21.
//

import UIKit
import AVFoundation
class VideoViewCell: UITableViewCell ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var lblVideoSize: UILabel!
    @IBOutlet weak var lblVideoName: UILabel!
    @IBOutlet weak var lblVideoDuration: UILabel!
    @IBOutlet weak var lblVideoDate: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var imgVideo: UIImageView!
    
    let imagePickerController = UIImagePickerController()

    var videoURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblVideoDuration.textColor = .white
    }

    @IBAction func btnMoreOption(_ sender: UIButton) {
        let Rename = UIAction(title: "Rename") { _ in
            print("Rename")}
        let Hide = UIAction(title: "Hide") { _ in
            print("Hide")}
        let Delete = UIAction(title: "Delete") { _ in
            print("Delete")}
        let Shate = UIAction(title: "Shate") { _ in
            print("Shate")}
        let Details = UIAction(title: "Details") { _ in
            print("Details")}
        let menu = UIMenu(title: "More", children: [Rename,Hide,Delete,Shate,Details])
        sender.showsMenuAsPrimaryAction = true
        sender.menu = menu
    }
}
