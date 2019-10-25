//
//  IGMediaModel.swift
//  Applicaster Assessment
//
//  Created by Brian Lane on 10/22/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//

import UIKit
import CoreLocation

struct IGMediaModel: Codable {
    
    let id: Int
    let user: String
    let userAvatar: String
    let date: String
    let caption: String
    let mediaURL: String
    var location:  CLLocation {
        let lat = Double(latitude)!
        let long = Double(longitude)!
        return CLLocation(latitude: lat, longitude: long)
    }
    let longitude: String
    let latitude: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user = "user"
        case userAvatar = "user_avatar"
        case date = "date"
        case caption = "caption"
        case mediaURL = "media_url"
        case longitude = "longitude"
        case latitude = "latitude"
        case location = "location"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        user = try container.decode(String.self, forKey: .user)
        userAvatar = try container.decode(String.self, forKey: .userAvatar)
        date = try container.decode(String.self, forKey: .date)
        caption = try container.decode(String.self, forKey: .caption)
        mediaURL = try container.decode(String.self, forKey: .mediaURL)
        let location = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        longitude = try location.decode(String.self, forKey: .longitude)
        latitude = try location.decode(String.self, forKey: .latitude)
    }
    
    init(id: Int, user: String, userAvatar: String, date: String = "", caption: String, mediaURL: String, longitude: String, latitude: String) {
        self.id = id
        self.user = user
        self.userAvatar = userAvatar
        self.date = date
        self.caption = caption
        self.mediaURL = mediaURL
        self.longitude = longitude
        self.latitude = latitude
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(user, forKey: .user)
        try container.encode(userAvatar, forKey: .userAvatar)
        try container.encode(date, forKey: .date)
        try container.encode(caption, forKey: .caption)
        try container.encode(mediaURL, forKey: .mediaURL)
        var location = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        try location.encode(longitude, forKey: .longitude)
        try location.encode(latitude, forKey: .latitude)
    }
    
}

