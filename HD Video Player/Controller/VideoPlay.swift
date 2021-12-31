//
//  VideoPlay.swift
//  HD Video Player
//
//  Created by macOS on 15/12/21.
//

import UIKit
import VersaPlayer
import SwiftyContextMenu

class VideoPlay: UIViewController {

    @IBOutlet weak var playerView: VersaPlayerView!
    @IBOutlet weak var controls: VersaPlayerControls!
    var url : URL!
    var titlename:String!
    var selectedIndex = 0
    var Model = [VideoModel]()

    override func viewDidLoad() {
        title = titlename
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        playerView.use(controls: controls)
        let item = VersaPlayerItem(url: url)
        playerView.set(item: item)
        

    }
    @IBAction func btnPrev(sender: UIButton) {
        if selectedIndex > 0 {
            selectedIndex -= 1
            url = URL(fileURLWithPath: Model[selectedIndex].Video_URL)
            playerView.use(controls: controls)
            let item = VersaPlayerItem(url: url)
            playerView.set(item: item)
        }
    }
    
    @IBAction func btnForw(sender: UIButton) {
        if selectedIndex < Model.count {
            selectedIndex += 1
            url = URL(fileURLWithPath: Model[selectedIndex].Video_URL)
            playerView.use(controls: controls)
            let item = VersaPlayerItem(url: url)
            playerView.set(item: item)
        }
    }
}
