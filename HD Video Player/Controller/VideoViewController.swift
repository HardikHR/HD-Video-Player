






import UIKit
import Photos
import AVKit
import VersaPlayer
import ContextMenu

class VideoViewController: UITableViewController{
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet var VideoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var videoduration = [CMTime]()
    var selectedIndex = 0
    var model = [VideoModel]()
    var searchModel = [VideoModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        VideoTableView.reloadData()
        navControl()
        fetchAllVideos()
        navigationController?.navigationBar.tintColor = .white
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        VideoTableView.reloadData()
    }
    
    @IBAction func Video_searchBar(_ sender: UIBarButtonItem){
    }
    @IBAction func Video_refresh(_ sender: UIBarButtonItem){
        self.VideoTableView.reloadData()
    }
    @IBAction func Video_moreMenu(_ sender: UIButton) {
        ContextMenu.shared.show(sourceViewController: self, viewController: MenuViewController(),options: ContextMenu.Options(
                                    containerStyle: ContextMenu.ContainerStyle(
                                        backgroundColor: UIColor(red: 41/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1)
                                    )))
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
            self.VideoTableView.reloadData()
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
        if (self.searchBar.text?.count ?? 0) > 0{
            return searchModel.count
        }else{
            return model.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoViewCell", for: indexPath) as! VideoViewCell
        var modelobj = model[indexPath.row]
        if (self.searchBar.text?.count ?? 0) > 0{
            modelobj = searchModel[indexPath.row]
        }
        cell.videoImage.image = getThumbnailImage(forUrl: URL(fileURLWithPath: modelobj.Video_URL))
        cell.videoDatelbl.text = modelobj.Video_date?.dateValue?.description
        cell.Videotimelbl .text = self.geTimefromSecond(second: Int(modelobj.Video_duration.seconds))
        cell.videoNamelbl.text = modelobj.Video_name
        cell.videoSizelbl.text = fileSize(fromPath: modelobj.Video_URL)
        cell.btnMore.tag = indexPath.row
        cell.btnMore.addTarget(self, action: #selector(moreVidoOption(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func moreVidoOption(sender: UIButton) {
        selectedIndex = sender.tag
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
                    self.VideoTableView.reloadData()
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
            self.tableView.reloadData()
        }
        
        let Shate = UIAction(title: "Share") { _ in
            let view = UIView()
            self.share(sender: view)
        }
        
        let Details = UIAction(title: "Details") { _ in
            self.performSegue(withIdentifier: "videoPopup", sender: self)
        }
        let menu = UIMenu(title: "More", children: [Rename,Hide,Delete,Shate,Details])
        sender.showsMenuAsPrimaryAction = true
        sender.menu = menu
    }
    
    @objc func share(sender:UIView){
            UIGraphicsBeginImageContext(view.frame.size)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        let modelobj = model[selectedIndex]

        let textToShare = modelobj.Video_name.description
        if let myWebsite = URL(string: model[selectedIndex].Video_URL) {
                let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "share")] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                //Excluded Activities
                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                activityVC.popoverPresentationController?.sourceView = sender
                self.present(activityVC, animated: true, completion: nil)
            }
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
            vc.selectedIndex = selectedIndex
            vc.Model = self.model
        }
        if segue.identifier == "videoPopup"{
            let vc = segue.destination as! detailPopup
            vc.VideoName =  model[selectedIndex].Video_name
            vc.VideoDuration = geTimefromSecond(second: Int(model[selectedIndex].Video_duration.seconds))
            vc.VideoSize = fileSize(fromPath: model[selectedIndex].Video_URL)!
            vc.VideoPath = URL(fileURLWithPath: model[selectedIndex].Video_URL)
            vc.VideoModify_date = model[selectedIndex].Video_ModifyDate
        }
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

extension VideoViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        searchModel = self.model.filter({ (obj) -> Bool in
            return obj.Video_name.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
        print(searchModel)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        tableView.reloadData()

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()

    }
}
