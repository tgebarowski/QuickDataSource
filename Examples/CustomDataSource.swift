//
//  CustomDataSource.swift
//  QuickDataSource
//
//  Created by Pawel Kowalczuk on 07/06/2017.
//  Copyright © 2017 Tomasz Gebarowski. All rights reserved.
//

import Foundation
import QuickDataSource

class CustomDataSource: DataSourceType {
    
    let list: [CellBindingType]
    
    var isEmpty: Bool {
        return list.count == 0
    }
    
    init(list: [CellBindingType]) {
        self.list = list
    }
    
    var sectionsCount: Int {
        return 1
    }
    
    func itemsCount(section: Int) -> Int {
        return list.count
    }
    
    func item(section: Int, kind: String?) -> CellBindingType? {
        return nil
    }
    
    func item(index: Int, section: Int) -> CellBindingType {
        return list[index]
    }
}
