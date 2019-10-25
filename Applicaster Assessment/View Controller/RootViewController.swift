//
//  RootViewController.swift
//  Applicaster Assessment
//
//  Created by Brian Lane on 10/22/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//

import UIKit
import CoreLocation



class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsViewDelegate, CLLocationManagerDelegate {
  
    var locationManager: CLLocationManager?

    @IBOutlet weak var settingsButton: RoundedCornerButton!
    @IBOutlet weak var tableView: UITableView!
    let filepath: String = {
        let date = Int(Date().timeIntervalSince1970)
        let end = date % 2
        return "media_close\(end)"
    }()

    let dataController = DataController.shared
    var settingsView: SettingsView?
    var settings: Int? = 500
    var settingsState: SettingsState?
    var userLocation: CLLocation?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        // We're faking the user location for this app.
        // The user is at the Empire State Building.
        userLocation = CLLocation(latitude: 40.748660, longitude: -73.985632)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "IGMediaTableViewCell", bundle: nil), forCellReuseIdentifier: "igmediacell")
        settingsButton.layer.borderWidth = 1.0
        settingsButton.layer.borderColor = UIColor.white.cgColor
        settingsState = .settingsSet
        reload()
    }
    
    func reload() {
        guard let userLocation = userLocation else { return }
        if (dataController.fullMediaList == nil)  {
            dataController.loadMediaData(for: filepath)
        }
        dataController.sortData(for: userLocation)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.currentMediaList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "igmediacell") as! IGMediaTableViewCell
        if let igMedia = dataController.currentMediaList?[indexPath.row] {
            cell.populate(with: igMedia)
        }
        return cell
    }
    
    @IBAction func settingsBtnPressed(_ sender: Any) {
        guard let settingsState = settingsState else { return }
        switch settingsState {
        case .settingsSet:
            loadSettingsView()
        case .settingsActive:
            deleteSettingsView()
        }
    }
    
    // Settings Delegate protocol functions
    func handleSettingsChanged(_ value: Int) {
        settings = value
    }
    
    func loadSettingsView() {
        settingsState = .settingsActive
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 275)
        settingsView = SettingsView(frame: frame, setting: settings!)
        tableView.isUserInteractionEnabled = false
        settingsButton.isUserInteractionEnabled = false
        settingsView?.delegate = self
        settingsView?.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 2 + 300)
        settingsView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        settingsView?.alpha = 0
        self.view.addSubview(settingsView!)
        UIView.animate(withDuration: 0.5, animations: {
            self.settingsView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.settingsView?.alpha = 1
            self.settingsView?.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 2)
        }){ (_) in
            self.settingsButton.isUserInteractionEnabled = true
        }

    }
    
    func deleteSettingsView() {
        guard let settingsview = settingsView else { return }
        reload()
        settingsButton.isUserInteractionEnabled = false
        settingsState = .settingsSet
        UIView.animate(withDuration: 0.5, animations: {
            settingsview.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            settingsview.alpha = 0
            settingsview.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 2 + 300)
         }) { (_) in
            settingsview.removeFromSuperview()
            self.settingsButton.isUserInteractionEnabled = true
            self.tableView.isUserInteractionEnabled = true
            self.settingsView = nil
        }
    }
}


