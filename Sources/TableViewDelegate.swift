//
//  TableViewDelegate.swift
//  QuickDataSource
//
//  Created by Tomasz Gebarowski on 24/05/17.
//  Copyright © 2015 codica Tomasz Gebarowski <gebarowski at gmail.com>.
//  All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation
import UIKit

public typealias CellSelectionHandler = ((IndexPath, CellBindingType?) -> Void)?

open class TableViewDelegate : NSObject, UITableViewDelegate {
    
    open let tableViewDataSource: TableViewDataSource
    
    fileprivate var cellSelectionHandler: CellSelectionHandler
    
    public init(tableViewDataSource: TableViewDataSource,
                cellSelectionHandler: CellSelectionHandler = nil) {
        
        self.tableViewDataSource = tableViewDataSource
        self.cellSelectionHandler = cellSelectionHandler
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewDataSource.tableView(tableView, viewForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.tableViewDataSource.items.item(index: indexPath.row, section: indexPath.section)
        cellSelectionHandler?(indexPath,viewModel)
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        guard let _ = tableViewDataSource.tableView(tableView, viewForHeaderInSection: section) else {
            return 0
        }
        return UITableViewAutomaticDimension
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
}
