//
//  ItemManagerTests.swift
//  ToDo
//
//  Created by Marc Felden on 26.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import XCTest
@testable import ToDo
class ItemManagerTests: XCTestCase
{

    var sut: ItemManager!
    
    override func setUp()
    {
        super.setUp()
        sut = ItemManager()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }

    func testToDoCount_Initially_ShouldBeZero()
    {
        XCTAssertEqual(sut.toDoCount, 0, "Initially toDo count should be 0")
    }
    
    func testDoneCount_Initially_ShouldBeZero()
    {
        XCTAssertEqual(sut.doneCount, 0, "Initially done count should be 0")
    }
    
    func testToDoCount_AfterAddingOneItem_IsOne()
    {
        sut.addItem(ToDoItem(title: "Test title"))
        XCTAssertEqual(sut.toDoCount,1, "toDoCount should be 1")
    }
    
    func testItemAtIndex_ShouldReturnPreviouslyAddedItem()
    {
        let item = ToDoItem(title: "Item")
        sut.addItem(item)
        let returnedItem = sut.itemAtIndex(0)
        XCTAssertEqual(item.title, returnedItem.title,"should be the same item")
    }
    
    func testCheckingItem_ChangesCountOfToDoAndOfDoneItems()
    {
        sut.addItem(ToDoItem(title: "First Item"))
        sut.checkItemAtIndex(0)
        XCTAssertEqual(sut.toDoCount,0, "todoCount should be 0")
        XCTAssertEqual(sut.doneCount, 1,"doneCount should be 1")
    }
    
    func testCheckingItem_RemovesItFromTheToDoItemList()
    {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        sut.addItem(firstItem)
        sut.addItem(secondItem)
        sut.checkItemAtIndex(0)
        XCTAssertEqual(sut.itemAtIndex(0).title, secondItem.title)
    }
    
    func testDoneItemAtIndex_ShouldReturnPreviouslyCheckedItem()
    {
        let item = ToDoItem(title: "Item")
        sut.addItem(item)
        sut.checkItemAtIndex(0)
        let returnedItem = sut.doneItemAtIndex(0)
        XCTAssertEqual(item.title, returnedItem.title,"should be the same")
    }
    
    func testRemoveAllItems_ShouldResultInCountsBeZero()
    {
        sut.addItem(ToDoItem(title: "First"))
        sut.addItem(ToDoItem(title: "Seecond"))
        sut.checkItemAtIndex(0)
        XCTAssertEqual(sut.toDoCount, 1,"toDoCount should be 1")
        XCTAssertEqual(sut.doneCount, 1,"doneCount should be 1")
        sut.removeAllItems()
        XCTAssertEqual(sut.toDoCount, 0,"toDoCount should be 0")
        XCTAssertEqual(sut.doneCount, 0,"doneCount should be 0")
    }
    
    func testThatAddingTheSameItem_DoesNotIncreaseCount()
    {
        let firstItem = ToDoItem(title: "First")
        sut.addItem(firstItem)
        sut.addItem(firstItem)
        XCTAssertEqual(sut.toDoCount, 1)
    }
}
