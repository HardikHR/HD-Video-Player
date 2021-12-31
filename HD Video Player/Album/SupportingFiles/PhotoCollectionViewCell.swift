






import UIKit

class PhotoCollectionViewCell: UITableViewCell {
  static let reuseIdentifier = "photoCell"
  @IBOutlet weak var photoView: UIImageView!

  override func prepareForReuse() {
    super.prepareForReuse()
    photoView.image = nil
  }
}
