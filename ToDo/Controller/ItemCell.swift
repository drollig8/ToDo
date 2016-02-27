//
//  ItemCell.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import UIKit

class ItemCell :UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    lazy var dateFormatter:NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    func configCellWithItem(item:ToDoItem, checked:Bool = false)
    {
        
        if checked {
            let attributedTitel = NSAttributedString(string: item.title, attributes: [NSStrikethroughColorAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
            titleLabel.attributedText = attributedTitel
            locationLabel.text = nil
            dateLabel.text = nil
        } else {
            titleLabel.text = item.title
            locationLabel.text = item.location?.name
            if let timestamp = item.timestamp {
                let date = NSDate(timeIntervalSince1970: timestamp)
                dateLabel.text = dateFormatter.stringFromDate(date)
            }
        }

        
        
    }
}
