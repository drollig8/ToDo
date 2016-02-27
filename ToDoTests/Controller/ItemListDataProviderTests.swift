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

    override func setUp()
    {
        super.setUp()
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        tableView = UITableView()
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
    
}
