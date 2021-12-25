//
//  HomeViewCell.swift
//  HD Video Player
//
//  Created by macOS on 17/12/21.
//

import UIKit

class VideoViewCell: UITableViewCell {
    

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoDatelbl: UILabel!
    @IBOutlet weak var Videotimelbl: UILabel!
    @IBOutlet weak var videoNamelbl: UILabel!
    @IBOutlet weak var videoSizelbl: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    
    
    
    @IBAction func btnMore(_ sender: UIButton) {
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
