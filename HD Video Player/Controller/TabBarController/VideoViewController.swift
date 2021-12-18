






import UIKit
import Photos
import AVKit
import VersaPlayer

class VideoViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet var videoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var allUrls = [URL]()
    var videoDate = [AVMetadataItem?]()
    var videoduration = [CMTime]()
    var selectedIndex = 0
    var VideoFileSize = ""
    
//    private var sideMenuViewController: SideMenuViewController!
//    private var sideMenuShadowView: UIView!
//    private var sideMenuRevealWidth: CGFloat = 260
//    private let paddingForRotation: CGFloat = 150
//    private var isExpanded: Bool = false
//    private var draggingIsEnabled: Bool = false
//    private var panBaseLocation: CGFloat = 0.0
//    private var sideMenuTrailingConstraint: NSLayoutConstraint!
//    private var revealSideMenuOnTop: Bool = true
//    var gestureEnabled: Bool = true
//    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navControl()
        fetchAllVideos()
        videoTableView.backgroundColor = .black
//        navigationController?.navigationBar.tintColor = .white
//        menu.target = self.revealViewController()
//        menu.action = #selector(self.revealViewController()?.revealSideMenu)
        
//        self.sideMenuShadowView = UIView(frame: self.view.bounds)
//        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.sideMenuShadowView.backgroundColor = .black
//        self.sideMenuShadowView.alpha = 0.0
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
//        tapGestureRecognizer.numberOfTapsRequired = 1
//        tapGestureRecognizer.delegate = self
//        view.addGestureRecognizer(tapGestureRecognizer)
//        if self.revealSideMenuOnTop {
//            view.insertSubview(self.sideMenuShadowView, at: 1)
//        }
//
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuID") as? SideMenuViewController
//        self.sideMenuViewController.defaultHighlightedCell = 0 // Default Highlighted Cell
//        self.sideMenuViewController.delegate = self
//        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
//        addChild(self.sideMenuViewController!)
//        self.sideMenuViewController!.didMove(toParent: self)
//        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
//
//        if self.revealSideMenuOnTop {
//            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
//            self.sideMenuTrailingConstraint.isActive = true
//        }
//        NSLayoutConstraint.activate([
//            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
//            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
//        ])
//
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
//        panGestureRecognizer.delegate = self
//        view.addGestureRecognizer(panGestureRecognizer)
//        showViewController(viewController: UINavigationController.self, storyboardId: "HomeNavID")
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate { _ in
//            if self.revealSideMenuOnTop {
//                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
//            }
//        }
//    }
//
//    func animateShadow(targetPosition: CGFloat) {
//        UIView.animate(withDuration: 0.5) {
//            // When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
//            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
//        }
//    }
//
//    @IBAction open func revealSideMenu() {
//        self.sideMenuState(expanded: self.isExpanded ? false : true)
//    }
//
//    func sideMenuState(expanded: Bool) {
//        if expanded {
//            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
//                self.isExpanded = true
//            }
//            // Animate Shadow (Fade In)
//            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
//        }
//        else {
//            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
//                self.isExpanded = false
//            }
//            // Animate Shadow (Fade Out)
//            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
//        }
//    }
//
//    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
//            if self.revealSideMenuOnTop {
//                self.sideMenuTrailingConstraint.constant = targetPosition
//                self.view.layoutIfNeeded()
//            }
//            else {
//                self.view.subviews[1].frame.origin.x = targetPosition
//            }
//        }, completion: completion)
//    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    @IBAction func SideMenu(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func moreItem(_ sender: UIBarButtonItem) {
        let ShortBy = UIAction(title: "Short By") { _ in
            print("Short By")}
        let ViewAs = UIAction(title: "View As") { _ in
            print("View As")}
        let menu = UIMenu(title: "More", children: [ShortBy,ViewAs])
        sender.menu = menu
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        tableView.reloadData()
    }
    
    @IBAction func searchVideo(_ sender: UIBarButtonItem) {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
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
                        self.allUrls.append(urlVideo)
                        self.videoDate.append(asset!.creationDate)
                        self.videoduration.append(asset!.duration)
                    }
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
        cell.lblVideoDate.text = videoDate[indexPath.row]?.dateValue?.debugDescription
        cell.lblVideoDuration.text = self.geTimefromSecond(second: Int(videoduration[indexPath.row].seconds))
        cell.lblVideoName.text = allUrls[indexPath.row].lastPathComponent
        cell.lblVideoSize.text = fileSize(fromPath: allUrls[indexPath.row].path)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguaVideo"{
            let vc = segue.destination as! VideoPlay
            vc.url = allUrls[selectedIndex]
            vc.titlename = allUrls[selectedIndex].lastPathComponent
            
        }
    }
}

//extension UIViewController {
//    func revealViewController() -> MainViewController? {
//        var viewController: UIViewController? = self
//
//        if viewController != nil && viewController is MainViewController {
//            return viewController! as? MainViewController
//        }
//        while (!(viewController is MainViewController) && viewController?.parent != nil) {
//            viewController = viewController?.parent
//        }
//        if viewController is MainViewController {
//            return viewController as? MainViewController
//        }
//        return nil
//    }
//}

// MARK: ------ NAVIGATION VIEW ------

//extension MainViewController: UIGestureRecognizerDelegate {

//    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
//        if sender.state == .ended {
//            if self.isExpanded {
//                self.sideMenuState(expanded: false)
//            }
//        }
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
//            return false
//        }
//        return true
//    }

    // Dragging Side Menu
//    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
//
//        guard gestureEnabled == true else { return }
//
//        let position: CGFloat = sender.translation(in: self.view).x
//        let velocity: CGFloat = sender.velocity(in: self.view).x
//
//        switch sender.state {
//        case .began:
//            if velocity > 0, self.isExpanded {
//                sender.state = .cancelled
//            }
//            if velocity > 0, !self.isExpanded {
//                self.draggingIsEnabled = true
//            }
//            else if velocity < 0, self.isExpanded {
//                self.draggingIsEnabled = true
//            }
//
//            if self.draggingIsEnabled {
//                let velocityThreshold: CGFloat = 550
//                if abs(velocity) > velocityThreshold {
//                    self.sideMenuState(expanded: self.isExpanded ? false : true)
//                    self.draggingIsEnabled = false
//                    return
//                }
//
//                if self.revealSideMenuOnTop {
//                    self.panBaseLocation = 0.0
//                    if self.isExpanded {
//                        self.panBaseLocation = self.sideMenuRevealWidth
//                    }
//                }
//            }
//
//        case .changed:
//            if self.draggingIsEnabled {
//                if self.revealSideMenuOnTop {
//                    // Show/Hide shadow background view while dragging
//                    let xLocation: CGFloat = self.panBaseLocation + position
//                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
//                    let alpha = percentage >= 0.6 ? 0.6 : percentage
//                    self.sideMenuShadowView.alpha = alpha
//                    if xLocation <= self.sideMenuRevealWidth {
//                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
//                    }
//                }
//                else {
//                    if let recogView = sender.view?.subviews[1] {
//                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
//                        let alpha = percentage >= 0.6 ? 0.6 : percentage
//                        self.sideMenuShadowView.alpha = alpha
//                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
//                            recogView.frame.origin.x = recogView.frame.origin.x + position
//                            sender.setTranslation(CGPoint.zero, in: view)
//                        }
//                    }
//                }
//            }
//        case .ended:
//            self.draggingIsEnabled = false
//            if self.revealSideMenuOnTop {
//                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
//                self.sideMenuState(expanded: movedMoreThanHalf)
//            }
//            else {
//                if let recogView = sender.view?.subviews[1] {
//                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
//                    self.sideMenuState(expanded: movedMoreThanHalf)
//                }
//            }
//        default:
//            break
//        }
//    }
//}

// MARK: - SIDEMENU VIEW -

//extension MainViewController: SideMenuViewControllerDelegate {
//    func selectedCell(_ row: Int) {
//        switch row {
//        case 0:
//            self.showViewController(viewController: UINavigationController.self, storyboardId: "HomeNavID")
//        case 1:
//            self.showViewController(viewController: UINavigationController.self, storyboardId: "MoviesNavID")
//        default:
//            break
//        }
//        DispatchQueue.main.async { self.sideMenuState(expanded: false) }
//    }
//    
//    func showViewController<T: UIViewController>(viewController: T.Type, storyboardId: String) -> () {
//        for subview in view.subviews {
//            if subview.tag == 99 {
//                subview.removeFromSuperview()
//            }
//        }
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
//        vc.view.tag = 99
//        view.insertSubview(vc.view, at: self.revealSideMenuOnTop ? 0 : 1)
//        addChild(vc)
//        if !self.revealSideMenuOnTop {
//            if isExpanded {
//                vc.view.frame.origin.x = self.sideMenuRevealWidth
//            }
//            if self.sideMenuShadowView != nil {
//                vc.view.addSubview(self.sideMenuShadowView)
//            }
//        }
//        vc.didMove(toParent: self)
//    }
//}
