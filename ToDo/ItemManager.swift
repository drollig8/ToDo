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
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        } else {
            print("Item \(item) alread exists")
        }
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
    
    func uncheckItemAtIndex(index:Int)
    {
        let item = doneItems.removeAtIndex(index)
        toDoItems.append(item)
    }
    
    func doneItemAtIndex(index: Int) -> ToDoItem
    {
        return doneItems[index]
    }
    
    func removeAllItems()
    {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
}
