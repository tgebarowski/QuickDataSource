import Foundation
import QuickDataSource

struct DummyHeaderViewModel: Hashable, Equatable {
    let title: String
    let textColor: UIColor
    
    init(title: String, textColor: UIColor = .white) {
        self.title = title
        self.textColor = textColor
    }
}

extension DummyHeaderViewModel: ItemType {
    
    func cellToViewModelBinder() -> CellToViewModelBinderType {
        return CellToViewModelBinder<DummyHeaderView>(viewModel: self)
    }
}

extension DummyHeaderViewModel: Comparable {
    static func < (lhs: DummyHeaderViewModel, rhs: DummyHeaderViewModel) -> Bool {
        return lhs.title < rhs.title
    }
}
