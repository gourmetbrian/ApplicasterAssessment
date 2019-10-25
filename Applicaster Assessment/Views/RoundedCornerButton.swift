//
//  BLButton.swift
//  Applicaster Assessment
//
//  Created by Brian Lane on 10/22/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//

import UIKit

@IBDesignable class RoundedCornerButton: UIButton {
    
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
