//
//  ItemCellTests.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemCellTests: XCTestCase
{

    var tableView: UITableView!
    
    override func setUp()
    {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController
        _ = controller.view
        
        tableView = controller.tableView
        
        let myDataSource = FakeDataSource()
        tableView.dataSource = myDataSource
    }

    
    override func tearDown()
    {
        super.tearDown()
    }

    func testSUT_HasNameLabel()
    {

        print(tableView.dataSource)
        let myDataSource = FakeDataSource()
        tableView.dataSource = myDataSource
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testSUT_HasLocationLabel()
    {
        let myDataSource = FakeDataSource()
        tableView.dataSource = myDataSource
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testConfigWithItem_SetsLabelTexts()
    {
        
        let myDataSource = FakeDataSource()
        tableView.dataSource = myDataSource
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        cell.configCellWithItem(ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home")))
        
       
        XCTAssertEqual(cell.titleLabel.text, "First")
         XCTAssertEqual(cell.locationLabel.text, "Home")
         XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
    }
    
    func testConfigWithItem_SetsLabelTexts1()
    {
        
       
        let myDataSource = FakeDataSource()
        tableView.dataSource = myDataSource
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        cell.configCellWithItem(ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home")))
        
        
        XCTAssertEqual(cell.titleLabel.text, "First")
        XCTAssertEqual(cell.locationLabel.text, "Home")
        XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
    }
    
    func testTitle_ForCheckedTasks_IsStrokeThroughi()
    {
        let myDataSource = FakeDataSource()
        tableView.dataSource = myDataSource
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        let toDoItem = ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home"))
        cell.configCellWithItem(toDoItem, checked: true)
    }
    



}

extension ItemCellTests
{
    class FakeDataSource: NSObject, UITableViewDataSource
    {
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            print("Returning Cell")
            return UITableViewCell()
        }
    }
}