






import UIKit
import Photos
import AVKit
import VersaPlayer

class VideoViewController: UITableViewController {
    
    @IBOutlet var videoTableView: UITableView!
    var allUrls = [URL]()
    var vidoeDate = [AVMetadataItem]()
    var vidoeduration = [CMTime]()
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navControl()
        fetchAllVideos()
        videoTableView.backgroundColor = .black
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL.rawValue] as? URL else { return }
            print(fileUrl.lastPathComponent)
        }
        let searchButton = UIBarButtonItem(image: UIImage.init(named: "refresh"),  style: .plain, target: self, action: nil)
        let editButton = UIBarButtonItem(image: UIImage.init(named: "search"),  style: .plain, target: self, action: nil)
        let morebtn = UIBarButtonItem(image: UIImage(named: "more")!,  style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [searchButton, editButton ,morebtn]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func fetchAllVideos(){
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@")
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d ", PHAssetMediaType.video.rawValue )
        let allVideo = PHAsset.fetchAssets(with: .video, options: fetchOptions)
        
        allVideo.enumerateObjects { (asset, index, bool) in
            let imageManager = PHCachingImageManager()
            print()
            imageManager.requestAVAsset(forVideo: asset, options: nil, resultHandler: { (asset, audioMix, info) in
                if asset != nil {
                    let avasset = asset as! AVURLAsset
                    let urlVideo = avasset.url
                    self.allUrls.append(urlVideo)
                    self.vidoeDate.append((asset?.creationDate)!)
                    self.vidoeduration.append(asset!.duration)
                }
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.tableView.reloadData()
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
        return allUrls.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoViewCell", for: indexPath) as! VideoViewCell
        cell.imgVideo.image = getThumbnailImage(forUrl: allUrls[indexPath.row])
        cell.lblVideoDate.text = vidoeDate[indexPath.row].dateValue?.debugDescription
        cell.lblVideoDuration.text = self.geTimefromSecond(second: Int(vidoeduration[indexPath.row].seconds))
        cell.lblVideoName.text = allUrls[indexPath.row].lastPathComponent
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "seguaVideo", sender: self)
    }
    
    func geTimefromSecond(second:Int) -> String{
        let (h,m,s) = (second / 3600, (second % 3600) / 60, (second % 3600) % 60)
        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        return "\(h_string):\(m_string):\(s_string)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguaVideo"{
            let vc = segue.destination as! VideoPlay
            vc.url = allUrls[selectedIndex]
        }
    }
}
