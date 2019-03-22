import Foundation
import QuickDataSource

struct DummyViewModel: Equatable, Hashable {
    let label: String
}

extension DummyViewModel: ItemType, Comparable  {
    func cellToViewModelBinder() -> CellToViewModelBinderType {
        return CellToViewModelBinder<DummyCell>(viewModel: self)
    }
}
    
extension DummyViewModel {
    static func < (lhs: DummyViewModel, rhs: DummyViewModel) -> Bool {
        return lhs.label < rhs.label
    }
}


