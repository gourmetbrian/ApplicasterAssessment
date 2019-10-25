//
//  NibLoadableView.swift
//  Applicaster Assessment
//
//  Created by Brian Lane on 10/23/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//
import UIKit

class NibLoadableView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    //MARK: - nib setup
    
    func loadViewFromNib(){
        let bundle = Bundle(for: type(of: self))
        let className = String(NSStringFromClass(type(of: self)).split(separator: ".").last!)
        let nib = UINib(nibName: className, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
