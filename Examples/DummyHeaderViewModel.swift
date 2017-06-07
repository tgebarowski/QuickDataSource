//
//  DummyHeaderViewModel.swift
//  QuickDataSource
//
//  Created by Pawel Kowalczuk on 07/06/2017.
//  Copyright © 2017 Tomasz Gebarowski. All rights reserved.
//

import Foundation
import QuickDataSource

struct DummyHeaderViewModel {
    
    let title: String
    let textColor: UIColor
}

extension DummyHeaderViewModel: CellBindingType {
    
    func cellViewModelBinder() -> CellViewModelBinderType {
        return CellViewModelBinder<DummyHeaderView>(viewModel: self)
    }
}
