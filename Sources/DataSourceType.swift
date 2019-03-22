import Foundation

public protocol ItemType {
    func cellToViewModelBinder() -> CellToViewModelBinderType
}

public protocol DataSourceType: class {
    var sectionsCount: Int { get }
    func itemsCount(section: Int) -> Int
    func item(index: Int, section: Int) -> ItemType
    func item(section: Int, kind: String?) -> ItemType?
    var isEmpty: Bool { get }
}

public extension DataSourceType {
    var isEmpty: Bool {
        return sectionsCount == 0 || itemsCount(section: 0) == 0
    }
}

