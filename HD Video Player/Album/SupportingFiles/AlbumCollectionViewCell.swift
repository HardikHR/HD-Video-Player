



import UIKit

class AlbumCollectionViewCell: UITableViewCell {
  static let reuseIdentifier = "albumCell"

   // @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumCount: UILabel!
    
  override func prepareForReuse() {
    super.prepareForReuse()
    albumTitle.text = "Untitled"
    albumCount.text = "0 photos"
 //   photoView.image = nil
   // photoView.isHidden = true
  }

  func update(title: String?, count: Int) {
    albumTitle.text = title ?? "Untitled"
    albumCount.text = "\(count.description) \(count == 1 ? "photo" : "photos")"
  }
}
