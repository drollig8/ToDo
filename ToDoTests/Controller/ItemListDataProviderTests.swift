//
//  ItemListDataProviderTests.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import XCTest
@testable import ToDo
class ItemListDataProviderTests: XCTestCase {
    
    override func setUp()
    {
        super.setUp()

    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    

    func testNumbersOfSections_IsTwo()
    {
        let sut = ItemListDataProvider()
        
        let tableView = UITableView()
        tableView.dataSource = sut
        
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
}
