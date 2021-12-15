//
//  Model.swift
//  HD Video Player
//
//  Created by macOS on 08/12/21.
//

import UIKit

struct items {
    static var itemImage = [UIImage.init(systemName: "video.fill"),UIImage.init(systemName: "folder.fill"),UIImage.init(systemName: "timer"), UIImage.init(named: "hide_Video"), UIImage.init(systemName: "star.fill"), UIImage.init(named: "share"), UIImage.init(named: "about_us")]
    static var itemText = ["Videos", "Folder", "Recent", "Hide Video", "Rate us", "Share", "About us"]
}

extension Int {
    func secondsToTime() -> String {
        let (h,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        return "\(h_string):\(m_string):\(s_string)"
    }
}
