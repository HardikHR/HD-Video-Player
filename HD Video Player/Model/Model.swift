//
//  Model.swift
//  HD Video Player
//
//  Created by macOS on 08/12/21.
//

import UIKit

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
