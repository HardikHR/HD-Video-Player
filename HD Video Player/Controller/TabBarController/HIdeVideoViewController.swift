//
//  HIdeVideoViewController.swift
//  HD Video Player
//
//  Created by macOS on 10/12/21.
//

import UIKit
import VersaPlayer

class HIdeVideoViewController: UIViewController {
    
    @IBOutlet weak var playerView: VersaPlayerView!
    @IBOutlet weak var controls: VersaPlayerControls!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.layer.backgroundColor = UIColor.black.cgColor
        playerView.use(controls: controls)
        
        if let url = URL.init(string: "https://svt1-b.akamaized.net/se/svt1/master.m3u8") {
            let item = VersaPlayerItem(url: url)
            playerView.set(item: item)
        }
    }
}

