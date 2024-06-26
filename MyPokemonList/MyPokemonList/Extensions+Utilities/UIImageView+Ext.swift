//
//  UIImageView+Ext.swift
//  IrsyadBasicsUtility
//
//  Created by Irsyad Ashari on 21/04/24.
//

//Fetching Remote Images
import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    /// Loads an image from a URL and saves it into an image cache, returns
    /// the image if already available in the cache.
    /// - Parameter urlString: String representation of the URL to load the
    /// image from
    /// - Parameter placeholder: An optional placeholder to show while the
    /// image is being fetched
    /// - Returns: A reference to the data task in order to pause, cancel,
    /// resume, etc.
    @discardableResult
    func loadImageFromURL(
        urlString: String,
        placeholder: UIImage? = nil
    ) -> URLSessionDataTask? {
        DispatchQueue.main.async {
            self.image = nil
        }
        
        let key = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: key) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
        }
        
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        DispatchQueue.main.async {
            if let placeholder = placeholder {
                self.image = placeholder
            } else {
                self.image = UIImage(named: "loading-placeholder")
            }
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _ , _ in
            
            DispatchQueue.main.async {
                if let data = data,
                   let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(
                        downloadedImage,
                        forKey: NSString(string: urlString))
                    self.image = downloadedImage
                    self.layoutIfNeeded()
                }
            }
        }
        task.resume()
        return task
    }
}
