import UIKit

public protocol CellToViewModelBinderType {
    var cellClass: AnyClass { get }
    var reuseId: String { get }
    func update(cell: UIView)
}

public protocol CellLoadableType {
    associatedtype ViewModel
    func load(viewModel: ViewModel)
}

public final class CellToViewModelBinder<Cell> : CellToViewModelBinderType where Cell: CellLoadableType, Cell: UIView {
    
    public let viewModel: Cell.ViewModel
    public let cellClass: AnyClass = Cell.self
    
    public init(viewModel: Cell.ViewModel) {
        self.viewModel = viewModel
    }
    
    public func update(cell: UIView) {
        (cell as? Cell)?.load(viewModel: viewModel)
    }
    
    public var reuseId: String {
        return String(describing: cellClass)
    }
}
