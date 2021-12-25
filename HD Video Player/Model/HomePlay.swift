//
//  HomePlay.swift
//  HD Video Player
//
//  Created by macOS on 21/12/21.
//

import UIKit
import VersaPlayer
import SwiftyContextMenu

class HomePlay: UIViewController {
    
    @IBOutlet weak var playerView: VersaPlayerView!
    @IBOutlet weak var controls: VersaPlayerControls!
    
    var url : URL!
    var titlename:String!
    
    override func viewDidLoad() {
        title = titlename
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        playerView.use(controls: controls)
        let item = VersaPlayerItem(url: url)
        playerView.set(item: item)
    }
    
}
