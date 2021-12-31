

import UIKit

extension UIImage {
  func applyFilter(_ filter: Filter) -> UIImage? {
    let filter = CIFilter(name: filter.rawValue)
    let inputImage = CIImage(image: self)
    filter?.setValue(inputImage, forKey: "inputImage")
    guard let finalImage = filter?.outputImage else { return nil }
    guard let cgImage = CIContext().createCGImage(finalImage, from: finalImage.extent) else { return nil }
    return UIImage(cgImage: cgImage)
  }
}
