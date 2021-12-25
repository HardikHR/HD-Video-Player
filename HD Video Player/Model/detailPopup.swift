//
//  detailPopup.swift
//  HD Video Player
//
//  Created by macOS on 24/12/21.
//

import UIKit
import Photos

class detailPopup: UIViewController {

    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var video_Name: UILabel!
    @IBOutlet weak var video_Durn: UILabel!
    @IBOutlet weak var video_Size: UILabel!
    @IBOutlet weak var video_path: UILabel!
    @IBOutlet weak var video_Res: UILabel!
    @IBOutlet weak var video_Modi: UILabel!
 
    var VideoName:String!
    var VideoDuration:String!
    var VideoSize:String = ""
    var VideoPath : URL!
    var VideoResolution:String!
    var VideoModify_date:Date? = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.layer.cornerRadius = 8
        video_Name.text = VideoName
        video_Durn.text = VideoDuration
        video_path.text = VideoPath.absoluteString
        video_Size.text = VideoSize
        video_Res.text = VideoResolution
        video_Modi.text = VideoModify_date?.debugDescription
        
    }

}
