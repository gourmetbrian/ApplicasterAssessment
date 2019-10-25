//
//  AsyncLoadableImageView.swift
//  Applicaster Assessment
//
//  Created by Brian Lane on 10/23/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//

import UIKit

@IBDesignable class AsyncLoadableImageView: UIImageView {
    var imageURLString: String?
    
    func loadImage(with urlString: String) {
        imageURLString = urlString
        guard let url = URL(string: urlString) else { return }
        if let imageFromCache = DataController.shared.imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
        } else {
            DataController.shared.downloadImage(url) { [unowned self] data in
                guard let imageToCache = UIImage(data: data), self.imageURLString == urlString  else {
                        return
                }
                DispatchQueue.main.async {
                    self.image = imageToCache
                    DataController.shared.imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }

            }
        }
    }
    
    //MARK: - IBInspectable properties
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    //MARK: - Override properties
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = cornerRadius
    }
}
