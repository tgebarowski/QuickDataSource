//
//  TableViewDataSource.swift
//
//  QuickDataSource
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

open class TableViewDataSource: NSObject, UITableViewDataSource {
    
    internal let items: DataSourceType
    
    public init(items: DataSourceType) {
        self.items = items
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return items.sectionsCount
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items.item(index: indexPath.row, section: indexPath.section)
        let viewModelBinder = item.cellViewModelBinder()
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModelBinder.reuseId, for: indexPath)
        viewModelBinder.update(cell: cell)
 
        return cell
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.itemsCount(section: section)
    }
    
    @nonobjc open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let viewModelBinder = items.item(section: section, kind: nil)?.cellViewModelBinder(),
              let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewModelBinder.reuseId)
        else {
            return nil
        }
        
        viewModelBinder.update(cell: cell)
        
        return cell
    }
    
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String,
                        at index: Int) -> Int {
        return 0
    }
}
