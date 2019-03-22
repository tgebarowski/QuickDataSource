import Foundation

public class FlatDataSource: DataSourceType {
    
    private let items: [ItemType]
    
    public init(items: [ItemType]) {
        self.items = items
    }
    
    public var sectionsCount: Int {
        return 1
    }
    
    public func itemsCount(section: Int) -> Int {
        return items.count
    }
    
    public func item(index: Int, section: Int) -> ItemType {
        return items[index]
    }
    
    public func item(section: Int, kind: String?) -> ItemType? {
        return nil
    }
}
