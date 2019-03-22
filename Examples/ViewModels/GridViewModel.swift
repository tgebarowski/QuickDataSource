import Foundation
import QuickDataSource

struct GridViewModel {
    let title: String
}

extension GridViewModel: ItemType  {
    func cellToViewModelBinder() -> CellToViewModelBinderType {
        return CellToViewModelBinder<GridCell>(viewModel: self)
    }
}
