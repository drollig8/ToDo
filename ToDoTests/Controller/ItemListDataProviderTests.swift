//
//  ItemListDataProviderTests.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase
{
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!

    override func setUp()
    {
        super.setUp()
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController
        _ = controller.view
        
        tableView = controller.tableView // IMPORTANT!
        tableView.dataSource = sut
        tableView.delegate = sut

    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    

    func testNumbersOfSections_IsTwo()
    {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberOfRowsInFirstSection_IsToDoCount()
    {
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        
        XCTAssertEqual(tableView.numberOfRowsInSection(0), 1)
        
        sut.itemManager?.addItem(ToDoItem(title: "Second"))
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRowsInSection(0), 2)

    }
    
    func testNumberOfRowsInSecondSection_IsDoneCount()
    {
        sut.itemManager?.addItem(ToDoItem(title:"First"))
        sut.itemManager?.addItem(ToDoItem(title:"Second"))
        sut.itemManager?.checkItemAtIndex(0)
        
        XCTAssertEqual(tableView.numberOfRowsInSection(1), 1)
        
        sut.itemManager?.checkItemAtIndex(0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRowsInSection(1), 2)
    }
    
    func testCellForRow_ReturnsItemCell()
    {
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        tableView.reloadData()
        
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        
        XCTAssertTrue(cell is ItemCell)
    }
    
    func testCellForRow_Dequeues()
    {
        let mockTableView = MockTableView.mockTableViewWithDataSource(sut)
        
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func testConfigCell_GetsCalledInCellForRow()
    {
        let mockTableView = MockTableView.mockTableViewWithDataSource(sut)
        
        let toDoItem = ToDoItem(title: "First", itemDescription: "First description")
        sut.itemManager?.addItem(toDoItem)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! MockItemCell
        
        XCTAssertEqual(cell.toDoItem, toDoItem)
    }
    
    func testCellInSectionTwo_GetsConfiguredWithDoneItem()
    {
        let mockTableView = MockTableView.mockTableViewWithDataSource(sut)
        
        let firstItem = ToDoItem(title: "First", itemDescription: "First description")
        let secondItem = ToDoItem(title: "Second", itemDescription: "First description")
        
        sut.itemManager?.addItem(firstItem)
        sut.itemManager?.addItem(secondItem)
        
        sut.itemManager?.checkItemAtIndex(0)
        
        mockTableView.reloadData()
        let cell = mockTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! MockItemCell
        
        XCTAssertEqual(cell.toDoItem,firstItem)
    }
    
    func testDeletionButtonInFirstSection_ShowsTitleCheck()
    {
        let delteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        
        XCTAssertEqual(delteButtonTitle, "Check")
    }
    
    func testDeletionButtonInFirstSection_ShowsTitleUnCheck()
    {
        let delteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 1))
        
        XCTAssertEqual(delteButtonTitle, "Uncheck")
    }
    
    /*
    func testDataSourceAndDelegate_AreNotTheSameObject()
    {
        XCTAssertTrue(tableView.dataSource is ItemListDataProvider)
        XCTAssertTrue(tableView.delegate is ItemListDataProvider)
        XCTAssertNotEqual(tableView.dataSource as? ItemListDataProvider, tableView.delegate as? ItemListDataProvider)
    }
    */
    
    // also user klickt auf check oder uncheck
    func testCheckingAnItem_ChecksItInTheItemManager()
    {
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        tableView.dataSource?.tableView?(tableView, commitEditingStyle: .Delete, forRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRowsInSection(0), 0)
        XCTAssertEqual(tableView.numberOfRowsInSection(1), 1)
    }
    
    func testCheckingAnItem_UnchecksItInTheItemManager()
    {
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        sut.itemManager?.checkItemAtIndex(0)
        tableView.reloadData()
        tableView.dataSource?.tableView?(tableView, commitEditingStyle: .Delete, forRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 1))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRowsInSection(0), 1)
        XCTAssertEqual(tableView.numberOfRowsInSection(1), 0)
    }
}


extension ItemListDataProviderTests
{
    class MockTableView: UITableView
    {
        var cellGotDequeued = false
        
        // MERKE: Nutze forIndexPath !
        override func dequeueReusableCellWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        }
        
        class func mockTableViewWithDataSource(dataSource: UITableViewDataSource) -> MockTableView
        {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .Plain)
            // necessary because "zero" cells will have size 0.0 and be nil.
            
            mockTableView.dataSource = dataSource
            mockTableView.registerClass(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
            
            return mockTableView
        }
    }
    
    class MockItemCell: ItemCell
    {
        var toDoItem: ToDoItem?
        override func configCellWithItem(item: ToDoItem, checked:Bool? = false) {
            toDoItem = item
        }
    }
    

}
