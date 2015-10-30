//
//  SwiftyDataSources.swift
//  SwiftyDataSources
//
//  Created by krivoblotsky on 10/30/15.
//  Copyright © 2015 MacPaw. All rights reserved.
//

import Foundation
import UIKit

public protocol DataSource
{
    //Register a typealias
    typealias DataSourceItem
    
    //Represents items container
    var items: Array<DataSourceItem> {get}
    
    //Represents objects for given section
    func objectsForSection(section:NSInteger) -> Array<DataSourceItem>
    
    //Represents object at given indexpath
    func objectAtIndexPath(indexPath:NSIndexPath) -> DataSourceItem
    
    //Number of sections
    func sectionsCount() -> Int
    
    //Number of objects
    func objectsCount() -> Int
}

public extension DataSource
{
    //default implementation
    
    public func objectAtIndexPath(indexPath:NSIndexPath) -> DataSourceItem
    {
        return self.items[indexPath.row]
    }
    
    public func sectionsCount() -> Int
    {
        return self.items.count > 0 ? 1 : 0
    }
    
    public func objectsCount() -> Int
    {
        return self.items.count
    }
    
    func objectsForSection(section:NSInteger) -> Array<DataSourceItem>
    {
        if section > 0
        {
            return []
        }
        return self.items
    }
}

public class TableViewDataSource <T, CellType:SwiftyCellProtocol> : NSObject, DataSource, UITableViewDataSource
{
    //Items container
    public private(set) var items:Array<T>
    
    //Cell Setup
    public var cellSetupHandler: ((T, CellType, NSIndexPath) -> ())?
    public let tableView:UITableView
    
    //MARK: Initializer
    
    public init(itemsArray:[T], tableView:UITableView)
    {
        //Default values
        self.tableView = tableView
        self.items = itemsArray
        
        super.init()
        self.tableView.dataSource = self;
    }
    
    //MARK: UITableViewDataSource
    
    @objc public func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return self.sectionsCount()
    }
    
    @objc public  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.objectsForSection(section).count
    }
    
    @objc public  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellClass = CellType.cellIdentifier()
        let cell = tableView.dequeueReusableCellWithIdentifier(cellClass)
        let model = self.objectAtIndexPath(indexPath)
        
        /* Setup the cell */
        if let cellSetupHandler = cellSetupHandler
        {
            cellSetupHandler(model, cell as! CellType, indexPath)
        }
        
        return cell!
    }
}
