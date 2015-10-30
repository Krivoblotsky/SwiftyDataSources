//
//  ViewController.swift
//  SwiftyDemo
//
//  Created by krivoblotsky on 10/30/15.
//  Copyright © 2015 Home. All rights reserved.
//

import UIKit
import SwiftyDataSources

class ViewController: UIViewController
{
    //Data
    var dataSource:TableViewDataSource<PersonClass, PersonCell>?
    
    //UI
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupDataSource()
    }
    
    //MARK: Private
    
    private func setupDataSource()
    {
        let items = [PersonClass(), PersonClass(), PersonClass()];
        
        self.dataSource = TableViewDataSource<PersonClass, PersonCell>(itemsArray:items, tableView:tableView)
        self.dataSource?.cellSetupHandler = cellUpdateHandler;
    }
    
    private func cellUpdateHandler(model:PersonClass, cell:PersonCell, indexPath:NSIndexPath)
    {
        cell.textLabel?.text = model.name
    }
}

