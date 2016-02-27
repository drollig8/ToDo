//
//  ToDoListTests.swift
//  TodoItemTDDHauser
//
//  Created by Marc Felden on 26.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//


// MODEL TESTS

import XCTest
@testable import ToDo
class ToDoListTests: XCTestCase {
    
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testInit_ShouldSetTitle()
    {
        let item = ToDoItem(title: "Test title")
        XCTAssertEqual(item.title, "Test title","Initializer should set the item title")
    }
    
    func testInit_ShouldSetTitleAndDescription()
    {
        let item = ToDoItem(title: "Test title", itemDescription: "Test description")
        XCTAssertEqual(item.itemDescription, "Test description", "Initializer should set the item description")
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestamp()
    {
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0)
        XCTAssertEqual(0.0, item.timestamp,"Initializer should set the time stamp")
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestampAndLocation()
    {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0,location: location)
        XCTAssertEqual(location.name, item.location?.name,"Initializer should set the location")
    }
    
    func testEqualItems_ShouldBeEqual()
    {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "First")
        XCTAssertEqual(firstItem, secondItem)
    }
    
    func testWhenLocationDifferes_ShouldBeNotEqual()
    {
        let firstItem = ToDoItem(title: "First", itemDescription: "First derscription", timestamp: 0.0, location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "First", itemDescription: "First derscription", timestamp: 0.0, location: Location(name: "Office"))
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual()
    {
        var firstItem = ToDoItem(title: "First", itemDescription: "First derscription", timestamp: 0.0, location: nil)
        var secondItem = ToDoItem(title: "First", itemDescription: "First derscription", timestamp: 0.0, location: Location(name: "Office"))
        XCTAssertNotEqual(firstItem, secondItem)
        
        firstItem = ToDoItem(title: "First", itemDescription: "First derscription", timestamp: 0.0, location: Location(name: "Home"))
        secondItem = ToDoItem(title: "First", itemDescription: "First derscription", timestamp: 0.0, location: nil)
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTimestampDiffers_ShouldNotBeEqual()
    {
        let firstItem = ToDoItem(title: "First", itemDescription: "First derscription", timestamp: 0.0, location: nil)
        let secondItem = ToDoItem(title: "First", itemDescription: "First derscription", timestamp: 1.0, location: nil)
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenDescriptionDiffers_ShouldNotBeEqual()
    {
        let firstItem = ToDoItem(title: "First", itemDescription: "First derscription")
        let secondItem = ToDoItem(title: "First", itemDescription: "First derscription2")
        XCTAssertNotEqual(firstItem, secondItem)
    }
   
    
    
}
