//
//  DataControllerTest.swift
//  ApplicasterAssessmentTests
//
//  Created by Brian Lane on 10/25/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Applicaster_Assessment

class DataControllerTest: XCTestCase {
    let dataController = DataController.shared
    
    func testLoadDataWillNotLoadValuesForNonexistingFile() {
        let bs = "badstring"
        dataController.loadMediaData(for: bs)
        XCTAssertNil(dataController.fullMediaList)
    }
    
    func testDataControllerWillLoadValuesForExistingFile() {
        dataController.loadMediaData(for: "media_close1")
        XCTAssertNotNil(dataController.fullMediaList)
        XCTAssertEqual(10, dataController.fullMediaList?.count)
    }

    func testDataControllerWillSortMedia() {
        dataController.loadMediaData(for: "media_close1")
        let empireStateBuildingLoc = CLLocation(latitude: 40.748660, longitude: -73.985632)
        dataController.sortData(for: empireStateBuildingLoc)
        XCTAssertEqual(dataController.currentMediaList?.count, 10)
        guard let loc1 = dataController.currentMediaList?[0].location, let loc2 = dataController.currentMediaList?[1].location else {
            XCTFail()
            return
        }
        XCTAssertTrue(empireStateBuildingLoc.distance(from: loc1) < empireStateBuildingLoc.distance(from: loc2))
    }
    
    func testDataControllerWillFilterClosestMedia() {
        dataController.loadMediaData(for: "media_close2")
        let empireStateBuildingLoc = CLLocation(latitude: 40.748660, longitude: -73.985632)
        dataController.sortData(for: empireStateBuildingLoc)
        XCTAssertEqual(dataController.currentMediaList?.count, 10)
        XCTAssertEqual(dataController.fullMediaList?.count, 20)
    }



}
