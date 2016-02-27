//
//  ItemListViewControllerTests.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTests: XCTestCase {

    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController
        _ = sut.view
        XCTAssertNotNil(sut.tableView)
    }
    
    func testViewDidLoad_ShouldSetTableViewDataSource()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController
        _ = sut.view
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }



}
