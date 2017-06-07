//
//  RandomColorCell.swift
//  QuickDataSource
//
//  Created by Pawel Kowalczuk on 07/06/2017.
//  Copyright © 2017 Tomasz Gebarowski. All rights reserved.
//

import Foundation
import QuickDataSource

class RandomColorCell: UITableViewCell {
}

extension RandomColorCell: CellLoadableType {
    
    func load(viewModel: RandomColorViewModel) {
        contentView.backgroundColor = viewModel.color
    }
}
