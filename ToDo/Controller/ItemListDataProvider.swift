//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import UIKit

enum Section: Int {
    case ToDo
    case Done
}

class ItemListDataProvider: NSObject, UITableViewDataSource
{
    var itemManager:ItemManager?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else { fatalError() }
        
        let numberOfRows: Int
        
        switch itemSection {
        case .ToDo:
            numberOfRows = itemManager.toDoCount
        case .Done:
            numberOfRows = itemManager.doneCount

        }
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        return UITableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }

}
