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
        let mockTableView = MockTableView()
        
        mockTableView.dataSource = sut
        mockTableView.registerClass(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func testConfigCell_GetsCalledInCellForRow()
    {
        let mockTableView = MockTableView()
        
        mockTableView.dataSource = sut
        mockTableView.registerClass(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        let toDoItem = ToDoItem(title: "First", itemDescription: "First description")
        sut.itemManager?.addItem(toDoItem)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! MockItemCell
        XCTAssertTrue(cell.configCellGotCalled)
        
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
    }
    
    class MockItemCell: ItemCell
    {
        var configCellGotCalled = false
        override func configCellWithItem(item: ToDoItem) {
            configCellGotCalled = true
        }
    }
}
