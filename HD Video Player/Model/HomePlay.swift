//
//  HomePlay.swift
//  HD Video Player
//
//  Created by macOS on 21/12/21.
//

import UIKit
import VersaPlayer
import SwiftyContextMenu
import AVKit

class HomePlay: UIViewController,AVAudioPlayerDelegate {
    
    @IBOutlet weak var playerView: VersaPlayerView!
    @IBOutlet weak var controls: VersaPlayerControls!
    
    var url : URL!
    var titlename:String!

    var selectedIndex = 0
    var Model = [VideoModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titlename
        
        //controls.forwardButton?.addTarget(self, action: #selector(playNext), for: .touchUpInside)
        //controls.rewindButton?.addTarget(self, action: #selector(playPrev), for: .touchUpInside)
        
        self.tabBarController?.tabBar.isHidden = true
        playerView.use(controls: controls)
        let item = VersaPlayerItem(url: url)
        playerView.set(item: item)
    }
    
    @objc func playNext() {
        if selectedIndex < Model.count {
            selectedIndex += 1
            url = URL(fileURLWithPath: Model[selectedIndex].Video_URL)
            playerView.use(controls: controls)
            let item = VersaPlayerItem(url: url)
            playerView.set(item: item)
        }
    }

    @objc func playPrev() {
        if selectedIndex < Model.count {
            selectedIndex -= 1
            url = URL(fileURLWithPath: Model[selectedIndex].Video_URL)
            playerView.use(controls: controls)
            let item = VersaPlayerItem(url: url)
            playerView.set(item: item)
        }
    }
}
