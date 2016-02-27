//
//  DetailViewControllerTests.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation


class DetailViewControllerTests: XCTestCase {

    var sut:DetailViewController!
    override func setUp()
    {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        _ = sut.view
    }
    
    override func tearDown()
    {
        super.tearDown()
    }

    func test_HasTitleLabel()
    {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertNotNil(sut.locationLabel)
    }

    func test_HasMapView()
    {
        XCTAssertNotNil(sut.mapView)
    }
    
    func testSettingInfo_SetsTextsToLabels()
    {
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
        let itemManager = ItemManager()
        itemManager.addItem(ToDoItem(title: "The title", itemDescription: "The descriptio", timestamp: 1456150025, location: Location(name: "Home", coordinate: coordinate)))
        
        sut.itemInfo = (itemManager, 0)
        
        // Interessant: Instead of forcing ViewWillAppear.
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, "The title")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, "Home")
        XCTAssertEqual(sut.descriptionLabel.text, "The descriptio")
        XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
                
    }
   
    func testCheckItem_ChecksItemInItemManager()
    {
        let itemManager = ItemManager()
        itemManager.addItem(ToDoItem(title: "The title"))
        sut.itemInfo = (itemManager,0)
        
        sut.checkItem()
        
        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
    }

}
