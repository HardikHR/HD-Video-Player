//
//  RecentViewController.swift
//  HD Video Player
//
//  Created by macOS on 23/12/21.
//

import UIKit
import Photos
import AVKit
import VersaPlayer

class RecentViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   

    @IBOutlet weak var recenetCollection: UICollectionView!
    @IBOutlet weak var sideMemu: UIBarButtonItem!
    var selectedIndex = 0
    var model = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navControl()
        fetchAllVideos()
        navigationController?.navigationBar.tintColor = .white
        sideMemu.target = revealViewController()
        sideMemu.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    @IBAction func sideMenu(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func moreItem(_ sender: UIBarButtonItem) {
    }
    @IBAction func refresh(_ sender: UIBarButtonItem) {
    }
    @IBAction func search(_ sender: UIBarButtonItem) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func fetchAllVideos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@")
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d ", PHAssetMediaType.video.rawValue )
        let allVideo = PHAsset.fetchAssets(with: .video, options: fetchOptions)
        allVideo.enumerateObjects { (asset, index, bool) in
            let imageManager = PHCachingImageManager()
            imageManager.requestAVAsset(forVideo: asset, options: nil, resultHandler: { (asset, audioMix, info) in
                DispatchQueue.main.async {
                    if asset != nil {
                        let avasset = asset as! AVURLAsset
                        let urlVideo = avasset.url
                        var videoObject = VideoModel()
                        videoObject.Video_id = UUID().uuidString
                        videoObject.Video_URL = urlVideo.path
                        videoObject.Video_date = asset?.creationDate
                        videoObject.Video_duration = asset!.duration
                        videoObject.Video_name = urlVideo.lastPathComponent
                        self.model.append(videoObject)
                    }
                }
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.recenetCollection.reloadData()
        })
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func navControl() {
        if self.navigationController == nil {
            return
        }
        let navView = UIView()
        let label = UILabel()
        label.text = "HD Video Player"
        label.textColor = UIColor.white
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        let image = UIImageView()
        image.image = UIImage(named: "LaunchScreen")
        let imageAspect = image.image!.size.width/image.image!.size.height
        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        navView.addSubview(label)
        navView.addSubview(image)
        self.navigationItem.titleView = navView
        navView.sizeToFit()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCell", for: indexPath) as! RecentViewCell
        let modelobj = model[indexPath.row]
        cell.videoImg.image = getThumbnailImage(forUrl: URL(fileURLWithPath: modelobj.Video_URL)) //allUrls[indexPath.row]
        cell.videoDate.text = modelobj.Video_date?.dateValue?.description //videoDate[indexPath.row]?.dateValue?.debugDescription
        cell.videoTime .text = self.geTimefromSecond(second: Int(modelobj.Video_duration.seconds))
        cell.videoName.text = modelobj.Video_name //allUrls[indexPath.row].lastPathComponent
        cell.videoSize.text = fileSize(fromPath: modelobj.Video_URL) //fileSize(fromPath: allUrls[indexPath.row].path)
        cell.btnMore.tag = indexPath.row
        cell.btnMore.addTarget(self, action: #selector(renameAlert(sender:)), for: .touchUpInside)
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 105)
    }
    
    @objc func renameAlert(sender: UIButton) {
        let Rename = UIAction(title: "Rename") { _ in
            var text = UITextField()
            let alertController = UIAlertController(title: "Rename", message: "", preferredStyle: .alert)
            alertController.addTextField { (textfield) in
                text = textfield
                textfield.returnKeyType = .continue
                textfield.text = self.model[sender.tag].Video_name
            }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Rename", style: .default, handler: { (alert) in
                guard let textfield = alertController.textFields else {
                    return
                }
                if let value = textfield[0].text {
                    text.becomeFirstResponder()
                    self.model[sender.tag].Video_name = value
                    self.recenetCollection.reloadData()
                }
            }))
            self.present(alertController, animated: true, completion: nil)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedIndex = indexPath.row
       // self.performSegue(withIdentifier: "SeguaHome", sender: self)
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SeguaHome"{
//            let vc = segue.destination as! HomePlay
//            vc.url = URL(fileURLWithPath: model[selectedIndex].Video_URL) //allUrls[selectedIndex]
//            vc.titlename = model[selectedIndex].Video_name
//        }
//    }
    
    func geTimefromSecond(second:Int) -> String{
        let (h,m,s) = (second / 3600, (second % 3600) / 60, (second % 3600) % 60)
        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        return "\(h_string):\(m_string):\(s_string)"
    }
    
    func fileSize(fromPath path: String) -> String? {
        guard let size = try? FileManager.default.attributesOfItem(atPath: path)[FileAttributeKey.size],
              let fileSize = size as? UInt64 else {
            return nil
        }// bytes
        if fileSize < 1023 {
            return String(format: "%lu bytes", CUnsignedLong(fileSize))
        }// KB
        var floatSize = Float(fileSize / 1024)
        if floatSize < 1023 {
            return String(format: "%.1f KB", floatSize)
        }// MB
        floatSize = floatSize / 1024
        if floatSize < 1023 {
            return String(format: "%.1f MB", floatSize)
        }// GB
        floatSize = floatSize / 1024
        return String(format: "%.1f GB", floatSize)
    }
}
