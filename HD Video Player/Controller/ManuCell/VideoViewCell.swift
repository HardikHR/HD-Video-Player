//
//  VideoViewCell.swift
//  HD Video Player
//
//  Created by macOS on 29/10/21.
//

import UIKit
import AVFoundation
class VideoViewCell: UITableViewCell ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var lblVideoSize: UILabel!
    @IBOutlet weak var lblVideoName: UILabel!
    @IBOutlet weak var lblVideoDate: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var imgVideo: UIImageView!
    
    let imagePickerController = UIImagePickerController()

    var videoURL: URL?

    override func awakeFromNib() {
        super.awakeFromNib()
    
//        self.getThumbnailImageFromVideoUrl(url: videoURL!) {(thumbimage) in
//            self.imgVideo.image = thumbimage
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        videoURL = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerReferenceURL")] as? URL
//        imagePickerController.dismiss(animated: true, completion: nil)
//    }
    
//    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
//        DispatchQueue.global().async { //1
//            let asset = AVAsset(url: url) //2
//            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
//            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
//            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
//            do {
//                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
//                let thumbImage = UIImage(cgImage: cgThumbImage) //7
//                DispatchQueue.main.async { //8
//                    completion(thumbImage) //9
//                }
//            } catch {
//                print(error.localizedDescription) //10
//                DispatchQueue.main.async {
//                    completion(nil) //11
//                }
//            }
//        }
//    }
    
    @IBAction func btnMoreOption(_ sender: UIButton) {
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
