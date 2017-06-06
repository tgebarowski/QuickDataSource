//
//  EmptyHeaderViewModel.swift
//  QuickDataSource
//
//  Created by Pawel Kowalczuk on 07/06/2017.
//  Copyright © 2017 Tomasz Gebarowski. All rights reserved.
//

import Foundation

public struct EmptyHeaderViewModel {
    public init() {}
}

extension EmptyHeaderViewModel: CellBindingType {
    public func cellViewModelBinder() -> CellViewModelBinderType {
        return CellViewModelBinder<EmptyHeaderView>(viewModel: self)
    }
}
