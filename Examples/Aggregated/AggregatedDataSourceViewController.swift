import Foundation
import QuickDataSource

class AggregatedDataSourceViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let repository: OrderRepository = OrderRepository()
    private var dataSource: TableViewDataSource?
    private var tableViewDelegate: TableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(DummyHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: String(describing: DummyHeaderView.self))
        tableView.estimatedSectionHeaderHeight = 20.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        load()
    }
    
    private func load() {
        repository.fetch { [weak self] in
            dataSource = TableViewDataSource(items: $0)
            dataSource?.propagate(to: tableView)
            tableViewDelegate = TableViewDelegate(tableViewDataSource: dataSource!)
            self?.tableView.delegate = tableViewDelegate

        }
    }
}

struct Order {
    let date: Date
    let name: String
}

extension Order: Aggregating {
    var aggregator: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}

class OrderRepository {
    
    private let orders = [Order(date: Date(), name: "Foo"),
                          Order(date: Date(), name: "Bar"),
                          Order(date: Date(), name: "Baz"),
                          Order(date: Date().addingTimeInterval(3600 * 24 * 7), name: "Qux")]
    
    func fetch(completion: (DataSourceType) -> Void ) {
        // Function transforming list of orders into a dictionary having DummyHeaderViewModel
        // of dates as keys and array of DummyViewModel of corresponding Order
        let aggregator: ([Order]) -> [DummyHeaderViewModel: [DummyViewModel]] = { (items) in
            return Dictionary(grouping: items) { return DummyHeaderViewModel(title: $0.aggregator) }
                .mapValues { $0.map { DummyViewModel(label: $0.name ) } }
        }
        completion(AggregatedDataSource<Order, DummyHeaderViewModel, DummyViewModel>(items: orders,
                                                                                     aggregator: aggregator,
                                                                                     sectionsComparator: <))
    }
}
