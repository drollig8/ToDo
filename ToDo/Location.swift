//
//  Location.swift
//  ToDo
//
//  Created by Marc Felden on 26.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import CoreLocation
struct Location
{
    let name: String
    let coordinate: CLLocationCoordinate2D?
    init(name: String, coordinate: CLLocationCoordinate2D? = nil)
    {
        self.name = name
        self.coordinate = coordinate
    }
}

