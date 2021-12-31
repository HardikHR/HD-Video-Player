



import UIKit

struct CollectionViewFlowLayoutType {
  enum ViewType { case album, photos }

  private var viewType: ViewType = .album
  private var viewFrame: CGRect = .zero
  var itemsPerRow: CGFloat {
    switch viewType {
    case .album: return 2
    case .photos: return 3
    }
  }
  var sectionInsets: UIEdgeInsets {
    switch viewType {
    case .album: return UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
    case .photos: return UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
    }
  }
  var sizeForItem: CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = viewFrame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  init(_ type: ViewType, frame: CGRect) {
    viewType = type
    viewFrame = frame
  }
}
