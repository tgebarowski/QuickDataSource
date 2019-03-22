import Foundation

public class NestedDataSource<S: ItemType & Hashable & Comparable>: DataSourceType {
    
    private let sections: [S]
    private let items: [[ItemType]]
    
    public init(items: [S: [ItemType]], sectionsComparator: ((S, S) throws -> Bool)) {
        self.sections = (try? items.keys.sorted(by: sectionsComparator)) ?? []
        self.items = sections.compactMap { return items[$0] }
    }
    
    public var sectionsCount: Int {
        return sections.count
    }
    
    public func itemsCount(section: Int) -> Int {
        return items[section].count
    }
    
    public func item(index: Int, section: Int) -> ItemType {
        return items[section][index]
    }
    
    public func item(section: Int, kind: String?) -> ItemType? {
        return sections[section]
    }
}
