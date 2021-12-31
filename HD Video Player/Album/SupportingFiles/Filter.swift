






import Foundation

enum Filter: String {
  case noir = "CIPhotoEffectNoir"

  var data: Data? {
    return self.rawValue.data(using: .utf8)
  }
}
