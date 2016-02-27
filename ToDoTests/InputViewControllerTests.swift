//
//  InputViewControllerTests.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class InputViewControllerTests: XCTestCase
{
    var placemark: MockPlacemark!
    var sut:InputViewController!
    
    override func setUp()
    {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier("InputViewController") as! InputViewController
        _ = sut.view

    }
    
    func test_HastTitleTextField()
    {
        XCTAssertNotNil(sut.titleTextField)
        XCTAssertNotNil(sut.dateTextField)
        XCTAssertNotNil(sut.locationTextField)
        XCTAssertNotNil(sut.addressTextField)
        XCTAssertNotNil(sut.descriptionTextField)
    }
    
    func testSave_UsesGeocoderToGetCoordinateFromAddress()
    {
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Office"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Test Description"
        
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder  // Dependency Injection
        sut.itemManager = ItemManager()
        
        sut.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2DMake(37.3316851,-122.0300674)
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark],nil)
        let item = sut.itemManager?.itemAtIndex(0)
        
        let testItem = ToDoItem(title: "The title", itemDescription: "The description", timestamp: 1456095600, location: Location(name: "Office", coordinate: coordinate))
        
        XCTAssertEqual(item, testItem)
    }
    
}

extension InputViewControllerTests
{
    class MockGeocoder: CLGeocoder
    {
        var completionHandler: CLGeocodeCompletionHandler?
        override func geocodeAddressString(addressString: String, completionHandler: CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockPlacemark : CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D?
        override var location:CLLocation? {
            guard let coordinate = mockCoordinate else { return CLLocation() }
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}

