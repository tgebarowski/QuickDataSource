//
//  DummyHeaderDataSource.swift
//  QuickDataSource
//
//  Created by Pawel Kowalczuk on 07/06/2017.
//  Copyright © 2017 Tomasz Gebarowski. All rights reserved.
//

import Foundation
import QuickDataSource

class DummyHeaderDataSource: DataSourceType {
    
    var items: [(CellBindingType, [CellBindingType])] {
        
        return [
            (DummyHeaderViewModel(title: "Foo", textColor: .black), [
                DummyViewModel(label: "Foo"),
                DummyViewModel(label: "Bar")
            ]),
            (DummyHeaderViewModel(title: "Bar", textColor: .white), [
                DummyViewModel(label: "Bar"),
                DummyViewModel(label: "Foo")
                ])
        ]
    }
}
