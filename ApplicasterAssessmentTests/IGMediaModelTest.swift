//
//  IGMediaModelTest.swift
//  ApplicasterAssessmentTests
//
//  Created by Brian Lane on 10/25/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Applicaster_Assessment
class IGMediaModelTest: XCTestCase {
    
    let media1 = IGMediaModel(id: 1, user: "brian", userAvatar: "http://pic.jpg", caption: "Hello World", mediaURL: "http://pic.jpg", longitude: "1.0", latitude: "2.0")

    func testCreateMediaModel() {
        XCTAssertEqual(1, media1.id)
        XCTAssertEqual("brian", media1.user)
        XCTAssertEqual("http://pic.jpg", media1.userAvatar)
        XCTAssertEqual("Hello World", media1.caption)
        XCTAssertEqual("http://pic.jpg", media1.mediaURL)
        XCTAssertEqual("1.0", media1.longitude)
        XCTAssertEqual("2.0", media1.latitude)
    }
    
    func testMediaModelHasCorrectLocation() {
        let loc = CLLocation(latitude: 2.0, longitude: 1.0)
        XCTAssertEqual(0, loc.distance(from: media1.location))
    }

}
