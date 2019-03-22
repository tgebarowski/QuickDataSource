import Foundation
import QuickDataSource

struct ColorViewModel {
    let color: UIColor
}

extension ColorViewModel: ItemType {
    func cellToViewModelBinder() -> CellToViewModelBinderType {
        return CellToViewModelBinder<ColorCell>(viewModel: self)
    }
}
