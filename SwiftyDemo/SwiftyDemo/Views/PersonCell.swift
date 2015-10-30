//
//  PersonCell.swift
//  SwiftyDemo
//
//  Created by krivoblotsky on 10/30/15.
//  Copyright © 2015 Home. All rights reserved.
//

import Foundation
import SwiftyDataSources

class PersonCell:UITableViewCell, SwiftyCellProtocol
{
    static func cellIdentifier() -> String {
        return "PersonCell"
    }
}