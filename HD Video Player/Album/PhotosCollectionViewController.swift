






import UIKit
import Photos

class PhotosCollectionViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
  var assets: PHFetchResult<PHAsset>

    @IBOutlet weak var tableView: UITableView!
    required init?(coder: NSCoder) {
    fatalError("init(coder:) not implemented.")
  }

  init?(assets: PHFetchResult<PHAsset>, title: String, coder: NSCoder) {
    self.assets = assets
    super.init(coder: coder)
    self.title = title
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    PHPhotoLibrary.shared().register(self)
  }

  deinit {
    PHPhotoLibrary.shared().unregisterChangeObserver(self)
  }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Unable to dequeue PhotoCollectionViewCell")}
        let asset = assets[indexPath.item]
        cell.photoView.fetchImageAsset(asset, targetSize: cell.photoView.bounds.size, completionHandler: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.height, height: 135)
    }
}

extension PhotosCollectionViewController: PHPhotoLibraryChangeObserver {
  func photoLibraryDidChange(_ changeInstance: PHChange) {
    // 1
    guard let change = changeInstance.changeDetails(for: assets) else {
      return
    }
    DispatchQueue.main.sync {
      // 2
      assets = change.fetchResultAfterChanges
      tableView.reloadData()
    }
  }
}
