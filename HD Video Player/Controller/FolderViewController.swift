






import UIKit
import Photos
import ContextMenu

class FolderViewController: UITableViewController {
    
    @IBOutlet weak var sideMemu: UIBarButtonItem!
    var sections: [AlbumCollectionSectionType] = [.smartAlbums, .userCollections]
    var smartAlbums = PHFetchResult<PHAssetCollection>()
    var userCollections = PHFetchResult<PHAssetCollection>()
    var searchModel = [VideoModel]()
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getPermissionIfNecessary { granted in
            guard granted else { return }
            self.fetchAssets()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        PHPhotoLibrary.shared().register(self)
        navigationController?.navigationBar.tintColor = .white
        sideMemu.target = revealViewController()
        sideMemu.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    @IBAction func sideMemu(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func Search(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func refresh(_ sender: Any) {
        
    }
    @IBAction func MoreOption(_ sender: Any) {
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
    
//MARK:- tableview -
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .smartAlbums: return smartAlbums.count
        case .userCollections: return userCollections.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCollectionViewCell.reuseIdentifier, for: indexPath) as! AlbumCollectionViewCell
        var coverAsset: PHAsset?
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .smartAlbums, .userCollections:
            let collection = sectionType == .smartAlbums ?
                smartAlbums[indexPath.item] :
                userCollections[indexPath.item]
            let fetchedAssets = PHAsset.fetchAssets(in: collection, options: nil)
            coverAsset = fetchedAssets.firstObject
            cell.update(title: collection.localizedTitle, count: fetchedAssets.count)
        }
//        guard let asset = coverAsset else { return cell }
//        cell.photoView.fetchImageAsset(asset, targetSize: cell.bounds.size) { success in
//            cell.photoView.isHidden = !success
//        }
        return cell
    }
// MARK:- didSelect and Segua Method -
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
    }
        
    func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        PHPhotoLibrary.requestAuthorization { status in
            completionHandler(status == .authorized ? true : false)
        }
    }
    
    @IBSegueAction func makePhotosCollectionViewController(_ coder: NSCoder) -> PhotosCollectionViewController? {
      guard
        let selectedIndexPath = tableView.indexPathForSelectedRow?.first
        else { return nil }

        let sectionType = sections[selectedIndexPath]
        let item = selectedIndexPath

      let assets: PHFetchResult<PHAsset>
      let title: String

      switch sectionType {
      case .smartAlbums, .userCollections:
        let album = sectionType == .smartAlbums ? smartAlbums[item] : userCollections[item]
        assets = PHAsset.fetchAssets(in: album, options: nil)
        title = album.localizedTitle ?? ""
      }

      return PhotosCollectionViewController(assets: assets, title: title, coder: coder)
    }
    
    func fetchAssets() {// 1
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false)
        ]
        smartAlbums = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .smartAlbumVideos,
            options: nil)
        // 4
        userCollections = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .smartAlbumVideos,
            options: nil)
    }
}

extension FolderViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.sync {
            if let changeDetails = changeInstance.changeDetails(for: smartAlbums) {
                smartAlbums = changeDetails.fetchResultAfterChanges
            }
            if let changeDetails = changeInstance.changeDetails(for: userCollections) {
                userCollections = changeDetails.fetchResultAfterChanges
            }
            // 4
            tableView.reloadData()
        }
    }
}
