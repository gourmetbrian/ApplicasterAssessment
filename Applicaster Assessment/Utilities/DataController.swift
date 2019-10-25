//
//  NetworkController.swift
//  Applicaster Assessment
//
//  Created by Brian Lane on 10/22/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//

import UIKit
import CoreLocation

class DataController {
    
    static let shared = DataController()
    let imageCache = NSCache<NSString, UIImage>()
    var fullMediaList: [IGMediaModel]?
    var currentMediaList: [IGMediaModel]?
    private init() {}
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(_ url: URL, _ completion: @escaping (_ data: Data) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(data)
        }
    }
    
    // Our data is faked, so we are guaranteed to always have media to sort.
    // This function simply sorts the fullMediaList so the first image is the closest
    // to the user's (faked) location.
    // In a real app, we could update the user's location in real time and provide a
    // pull to refresh to find images near that current location.
    func sortData(for userLocation: CLLocation) {
        var cachedDistanches = Dictionary<Int,Double>()
        let sortedMediaList = fullMediaList?.sorted { one, two in
            var dist1: Double
            var dist2: Double
            if let d1 = cachedDistanches[one.id] {
                dist1 = d1
            } else {
                dist1 = userLocation.distance(from: one.location)
                cachedDistanches[one.id] = dist1
            }
            if let d2 = cachedDistanches[two.id] {
                dist2 = d2
            } else {
                dist2 = userLocation.distance(from: two.location)
                cachedDistanches[two.id] = dist2
            }
            return dist1 < dist2
        }
        // Always guaranteed to succeed because of faked data.
        currentMediaList = Array((sortedMediaList?.prefix(10))!)
    }
    
    func loadMediaData(for file: String)  {
        // reset the data
        fullMediaList = nil
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let decoder = JSONDecoder()
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                fullMediaList = try? decoder.decode([IGMediaModel].self, from: data)
            } catch let error as NSError {
                print("There was an error loading the JSON: \(error.description)")
            }
        }
    }
    
    
}


