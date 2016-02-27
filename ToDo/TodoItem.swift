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
    if lhs.title != rhs.title {
        return false
    }
    if lhs.location != rhs.location {
        return false
    }
    if lhs.timestamp != rhs.timestamp {
        return false
    }
    if lhs.itemDescription != rhs.itemDescription {
        return false
    }
    return true
    
    
}