//
//  TodoItem.swift
//  ToDo
//
//  Created by Marc Felden on 26.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

struct ToDoItem : Equatable
{
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil)
    {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}


func ==(lhs:ToDoItem, rhs: ToDoItem) -> Bool
{
    if lhs.location?.name != rhs.location?.name {
        return false
    }
    return true
    
}