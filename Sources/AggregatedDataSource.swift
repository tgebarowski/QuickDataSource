import Foundation

public protocol Aggregating {
    var aggregator: String { get }
}

public class AggregatedDataSource<I: Aggregating,
    K: ItemType & Hashable & Comparable,
V: ItemType & Hashable & Comparable>: NestedDataSource<K> {
    
    public init(items: [I], aggregator: ([I]) -> [K: [ItemType]],
                sectionsComparator: ((K, K) throws -> Bool)) {
        
        print(aggregator(items))
        super.init(items: aggregator(items), sectionsComparator: sectionsComparator)
    }
}
