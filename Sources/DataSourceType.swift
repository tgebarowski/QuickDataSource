//
//  DataSourceType.swift
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

public protocol DataSourceType: class {
    
    var items: [(CellBindingType, [CellBindingType])] { get }
    var sectionsCount: Int { get }
    func itemsCount(section: Int) -> Int
    func item(index: Int, section: Int) -> CellBindingType
    func item(section: Int, kind: String?) -> CellBindingType?
    
    var isEmpty: Bool { get }
}

public extension DataSourceType {
    
    var isEmpty: Bool {
        return items.count == 0 || items.first?.1.count == 0
    }
}

public extension DataSourceType {
    
    var items: [(CellBindingType, [CellBindingType])] { return [] }
    
    var sectionsCount: Int {
        return items.count
    }
    
    func itemsCount(section: Int) -> Int {
        return items[section].1.count
    }
    
    func item(index: Int, section: Int) -> CellBindingType {
        return items[section].1[index]
    }
    
    func item(section: Int, kind: String?) -> CellBindingType? {
        return items[section].0
    }
}
