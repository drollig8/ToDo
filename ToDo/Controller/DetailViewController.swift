//
//  DetailViewController.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var locationLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var mapView:MKMapView!
    
    // Interessannt, immer, wenn wir sovieso 2 Werte brauchen, dann am besten so. Weil dann kann man ncihts vergessen !
    var itemInfo: (ItemManager, Int)?
    
    lazy var dateFormatter:NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //TODO Spasseshalber durch if let ersetzen. Was sieht besser aus? Ist besser lesbar?
        guard let itemInfo = itemInfo else {return}
        let item = itemInfo.0.itemAtIndex(itemInfo.1)
        
        titleLabel.text = item.title
        locationLabel.text = item.location?.name
        descriptionLabel.text = item.itemDescription
        
        if let timestamp = item.timestamp {
            let date = NSDate(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.stringFromDate(date)
            
        }
        
        if let coordinate = item.location?.coordinate {
            
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
            mapView.region = region

        }
        
    }
    
    
    func checkItem()
    {
        if let itemInfo = itemInfo {
            itemInfo.0.checkItemAtIndex(itemInfo.1)
        }
    }
}
