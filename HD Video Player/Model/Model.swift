//
//  Model.swift
//  HD Video Player
//
//  Created by macOS on 08/12/21.
//

import UIKit
import Photos

struct SideMenuImage {
    static var itemImage = [UIImage.init(systemName: "video.fill"),
                            UIImage.init(systemName: "folder.fill"),
                            UIImage.init(systemName: "timer"),
                            UIImage.init(named: "hide_Video"),
                            UIImage.init(systemName: "star.fill"),
                            UIImage.init(named: "share"),
                            UIImage.init(named: "about_us")]
    static var itemName = ["Videos", "Folder", "Recent", "Hide Video", "Rate us", "Share", "About us"]
    static var date = ["10/11/2021", "10/11/2021", "10/11/2021", "10/11/2021", "10/11/2021", "10/11/2021", "10/11/2021"]
    static var size = ["20MB", "20MB", "20MB", "20MB", "20MB", "20MB", "20MB"]
}
struct VideoModel {
    var Video_id : String = ""
    var Video_URL : String = ""
    var Video_name : String = ""
    var Video_size : Double = 0.0
    var Video_date : AVMetadataItem? = AVMetadataItem()
    var Video_duration : CMTime = CMTime()
    var Video_resolution : String = ""
    var Video_ModifyDate : Date? = Date()

    
    var assetID : String = ""
}
