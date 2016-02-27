//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Marc Felden on 27.02.16.
//  Copyright © 2016 NoName.com. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: protocol<UITableViewDataSource,UITableViewDelegate>!
    
    override func viewDidLoad()
    {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }


    


}
