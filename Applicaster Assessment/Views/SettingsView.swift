//
//  SettingsView.swift
//  Applicaster Assessment
//
//  Created by Brian Lane on 10/23/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//

import UIKit

enum SettingsState {
    case settingsActive, settingsSet
}

protocol SettingsViewDelegate: class {
    var settingsView: SettingsView? { get set }
    var settings: Int? { get set }
    func handleSettingsChanged(_ value: Int)
    func deleteSettingsView()
    var settingsState: SettingsState? { get set }
    
}

@IBDesignable class SettingsView: NibLoadableView {
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(frame: CGRect, setting: Int) {
        super.init(frame: frame)
        slider.value = Float(setting)
        distanceChanged(slider!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: SettingsViewDelegate?
    
    
    @IBAction func distanceChanged(_ sender: Any) {
        distanceLabel.text = ("\(Int(slider.value))m")
        delegate?.handleSettingsChanged(Int(slider.value))
    }
    
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
