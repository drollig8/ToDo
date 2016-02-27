//
//  LocationTests.swift
//  TodoItemTDDHauser
//
//  Created by Marc Felden on 26.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class LocationTests: XCTestCase
{
    
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testInit_ShouldSetNameAndCoordinate()
    {
        let testCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: testCoordinate)
        XCTAssertEqual(location.coordinate?.latitude,testCoordinate.latitude, "Initializer should set latitude")
        XCTAssertEqual(location.coordinate?.longitude,testCoordinate.longitude, "Initializer should set longitude")
    }
    
    func testInit_ShouldSetName()
    {
        let location = Location(name: "Test name")
        XCTAssertEqual(location.name, "Test name", "Initializer should set the name")
    }
    
    func testEqualLocations_ShouldBeEqual()
    {
        let firstLocation = Location(name: "Home")
        let secondLocation = Location(name: "Home")
        XCTAssertEqual(firstLocation, secondLocation)
    }
    
    func testWhenLatitudeDifferes_ShouldbeNotEqual()
    {
        performNotEqualTestsWithLocationProperties("Home", secondName: "Home", firstLongLat: (1.0,0.0), secondLongLat: (0.0,0.0))
    }
    
    func testThwnLongitudeDifferes_ShouldbeNotEqual()
    {
        performNotEqualTestsWithLocationProperties("Home", secondName: "Home", firstLongLat: (0.0,1.0), secondLongLat: (0.0,0.0))
    }
    
    func performNotEqualTestsWithLocationProperties(firstName:String, secondName:String, firstLongLat:(Double,Double)?, secondLongLat:(Double,Double)?, line:UInt=__LINE__)
    {
        let firstCoord: CLLocationCoordinate2D?
        if let firstLongLat = firstLongLat {
            firstCoord = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
        } else {
            firstCoord = nil
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoord)
        
        let secondCoord: CLLocationCoordinate2D?
        if let secondLongLat = secondLongLat {
            secondCoord = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
        } else {
            secondCoord = nil
        }

        let secondLocation = Location(name: secondName, coordinate: secondCoord)
        XCTAssertNotEqual(firstLocation, secondLocation, "line: \(line)")
        
    }
    
    func testWhenOneHasCoordinateAndTheOtherDoesnt_ShouldBeNotEqual()
    {
        performNotEqualTestsWithLocationProperties("Home", secondName: "Home", firstLongLat: (0.0,0.0), secondLongLat: nil)
    }
    
    func testWhenNameDiffer_ShouldBeNotEqual()
    {
        performNotEqualTestsWithLocationProperties("Home", secondName: "Office", firstLongLat: nil, secondLongLat: nil)
    }
}
