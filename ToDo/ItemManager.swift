//
//  ItemManager.swift
//  ToDo
//
//  Created by Marc Felden on 26.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

class ItemManager
{
    var toDoCount : Int {
        return toDoItems.count
    }
    var doneCount : Int {
        return doneItems.count
    }
    
    private var toDoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    
    func addItem(item:ToDoItem)
    {
        toDoItems.append(item)
    }
    
    func itemAtIndex(index: Int) -> ToDoItem
    {
        return toDoItems[index]
    }
    
    func checkItemAtIndex(index:Int)
    {
        let item = toDoItems.removeAtIndex(index)
        doneItems.append(item)
    }
    
    func doneItemAtIndex(index: Int) -> ToDoItem
    {
        return doneItems[index]
    }
}
