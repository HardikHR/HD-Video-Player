





import UIKit
import Photos
import PhotosUI

class PhotoViewController: UIViewController {
    
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  var asset: PHAsset
  
    var editingOutput: PHContentEditingOutput?

  required init?(coder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }

  init?(asset: PHAsset, coder: NSCoder) {
    self.asset = asset
    super.init(coder: coder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    getPhoto()
    saveButton.isEnabled = false
    PHPhotoLibrary.shared().register(self)
  }

  deinit {
    PHPhotoLibrary.shared().unregisterChangeObserver(self)
  }
    
  func saveImage() {
    let changeRequest: () -> Void = {
      let changeRequest = PHAssetChangeRequest(for: self.asset)
      changeRequest.contentEditingOutput = self.editingOutput
    }
    let completionHandler: (Bool, Error?) -> Void = { success, error in
      guard success else {
        print("Error: cannot edit asset: \(String(describing: error))")
        return
      }
      self.editingOutput = nil
      DispatchQueue.main.async {
        self.saveButton.isEnabled = false
      }
    }
    PHPhotoLibrary.shared().performChanges(
      changeRequest,
      completionHandler: completionHandler)
  }

  func getPhoto() {
    imageView.fetchImageAsset(asset, targetSize: view.bounds.size, completionHandler: nil)
  }
}

extension PhotoViewController: PHPhotoLibraryChangeObserver {
  func photoLibraryDidChange(_ changeInstance: PHChange) {
    guard
      let change = changeInstance.changeDetails(for: asset),
      let updatedAsset = change.objectAfterChanges
      else { return }
    DispatchQueue.main.sync {
      asset = updatedAsset
      imageView.fetchImageAsset(
        asset,
        targetSize: view.bounds.size
      ) { [weak self] _ in
        guard self != nil else { return }
      }
    }
  }
}
