//
//  UIImageView+LoadImage.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/24/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  func loadImage(from urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
      self.image = cachedImage
      return
    }
    guard let url = URL(string: urlString) else {
      return
    }
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let httpURLResponse = response as? HTTPURLResponse,
            httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType,
            mimeType.hasPrefix("image"),
            error == nil,
            let data = data,
            let image = UIImage(data: data) else {
        print("Error loading image: \(String(describing: error))")
        return
      }
      DispatchQueue.main.async() { [weak self] in
        imageCache.setObject(image, forKey: NSString(string: urlString))
        self?.image = image
      }
    }.resume()
  }
}
