//
//  EmptyHeaderView.swift
//  QuickDataSource
//
//  Created by Pawel Kowalczuk on 07/06/2017.
//  Copyright © 2017 Tomasz Gebarowski. All rights reserved.
//

import Foundation

public class EmptyHeaderView: UITableViewHeaderFooterView { }

extension EmptyHeaderView: CellLoadableType {
    public func load(viewModel: EmptyHeaderViewModel) { }
}
