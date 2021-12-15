//
//  VideoPlay.swift
//  HD Video Player
//
//  Created by macOS on 15/12/21.
//

import UIKit
import VersaPlayer
class VideoPlay: UIViewController {

    @IBOutlet weak var playerView: VersaPlayerView!
    @IBOutlet weak var controls: VersaPlayerControls!
    var url : URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        playerView.use(controls: controls)
        let item = VersaPlayerItem(url: url)
        playerView.set(item: item)
    }
    
  
}
