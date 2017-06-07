//
//  RandomColorViewModel.swift
//  QuickDataSource
//
//  Created by Pawel Kowalczuk on 07/06/2017.
//  Copyright © 2017 Tomasz Gebarowski. All rights reserved.
//

import Foundation
import QuickDataSource

struct RandomColorViewModel {
    let color: UIColor
}

extension RandomColorViewModel: CellBindingType {
    func cellViewModelBinder() -> CellViewModelBinderType {
        return CellViewModelBinder<RandomColorCell>(viewModel: self)
    }
}
