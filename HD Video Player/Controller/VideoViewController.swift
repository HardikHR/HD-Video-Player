






import UIKit
import Photos
import AVKit
import VersaPlayer

class VideoViewController: UITableViewController, UISearchBarDelegate{
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet var VideoCollectionView: UITableView!
    
    var videoduration = [CMTime]()
    var selectedIndex = 0
    var model = [VideoModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navControl()
        fetchAllVideos()
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    @IBAction func Video_searchBar(_ sender: UIBarButtonItem) {
    }
    @IBAction func Video_refresh(_ sender: UIBarButtonItem) {
    }
    @IBAction func Video_moreMenu(_ sender: UIBarButtonItem) {
        let ShortBy = UIAction(title: "Short By") { _ in
            print("Short By")}
        let ViewAs = UIAction(title: "View As") { _ in
            print("View As")}
        let menu = UIMenu(title: "More", children: [ShortBy,ViewAs])
        sender.menu = menu
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
            imageManager.requestAVAsset(forVideo: asset, options: nil, resultHandler: { (asset2, audioMix, info) in
                DispatchQueue.main.async {
                    if asset2 != nil {
                        let avasset = asset2 as! AVURLAsset
                        let urlVideo = avasset.url
                        let VideoReso = "\(asset.pixelHeight)\(asset.pixelWidth)"
                        var videoObject = VideoModel()
                        videoObject.Video_id = UUID().uuidString
                        videoObject.Video_URL = urlVideo.path
                        videoObject.Video_date = asset2?.creationDate
                        videoObject.Video_duration = asset2!.duration
                        videoObject.Video_name = urlVideo.lastPathComponent
                        videoObject.assetID = asset.localIdentifier
                        videoObject.Video_resolution = VideoReso
                        videoObject.Video_ModifyDate = asset.modificationDate
                        self.model.append(videoObject)
                    }
                }
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.VideoCollectionView.reloadData()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoViewCell", for: indexPath) as! VideoViewCell
        let modelobj = model[indexPath.row]
        cell.videoImage.image = getThumbnailImage(forUrl: URL(fileURLWithPath: modelobj.Video_URL)) //allUrls[indexPath.row]
        cell.videoDatelbl.text = modelobj.Video_date?.dateValue?.description //videoDate[indexPath.row]?.dateValue?.debugDescription
        cell.Videotimelbl .text = self.geTimefromSecond(second: Int(modelobj.Video_duration.seconds))
        cell.videoNamelbl.text = modelobj.Video_name //allUrls[indexPath.row].lastPathComponent
        cell.videoSizelbl.text = fileSize(fromPath: modelobj.Video_URL) //fileSize(fromPath: allUrls[indexPath.row].path)
        cell.btnMore.tag = indexPath.row
        cell.btnMore.addTarget(self, action: #selector(moreVidoOption(sender:)), for: .touchUpInside)
        return cell
    }
   
    @objc func moreVidoOption(sender: UIButton) {
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
                    self.VideoCollectionView.reloadData()
                }
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        
        let Hide = UIAction(title: "Hide") { _ in
            print("Hide")}
        
        let Delete = UIAction(title: "Delete") { _ in
            let videoextension = URL(fileURLWithPath: self.model[sender.tag].Video_URL).pathExtension
            let assetURLStr = URL(string: "assets-library://asset/asset.\(videoextension)?id=\(self.model[sender.tag].assetID)&ext=\(videoextension)")
            PHPhotoLibrary.shared().performChanges({
                        let imageAssetToDelete = PHAsset.fetchAssets(withALAssetURLs: [assetURLStr!], options: nil)
                        PHAssetChangeRequest.deleteAssets(imageAssetToDelete)}, completionHandler: {success, error in
                            if error != nil {
                                print(success ? "Success" : error!)
                            }
                        })
        }
        
        let Shate = UIAction(title: "Shate") { _ in
            print("Shate")}
        
        let Details = UIAction(title: "Details") { _ in
              
            self.performSegue(withIdentifier: "videoPopup", sender: self)
        }
        let menu = UIMenu(title: "More", children: [Rename,Hide,Delete,Shate,Details])
        sender.showsMenuAsPrimaryAction = true
        sender.menu = menu
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "seguaVideo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguaVideo"{
            let vc = segue.destination as! VideoPlay
            vc.url = URL(fileURLWithPath: model[selectedIndex].Video_URL)
            vc.titlename = model[selectedIndex].Video_name
        }
        if segue.identifier == "videoPopup"{
            let vc = segue.destination as! detailPopup
            let modelobj = model[selectedIndex]
            vc.VideoName = model[selectedIndex].Video_name
            vc.VideoDuration = geTimefromSecond(second: Int(modelobj.Video_duration.seconds))
            vc.VideoSize = fileSize(fromPath: modelobj.Video_URL)!
            vc.VideoPath = URL(fileURLWithPath: model[selectedIndex].Video_URL)
           // vc.VideoResolution =
            vc.VideoModify_date = model[selectedIndex].Video_ModifyDate
        }
    }
    
    func resolutionSizeForLocalVideo(url:NSURL) -> CGSize? {
        guard let track = AVAsset(url: url as URL).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: fabs(size.width), height: fabs(size.height))
    }
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

