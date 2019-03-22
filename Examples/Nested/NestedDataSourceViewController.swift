import UIKit
import QuickDataSource

class NestedDataSourceViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    lazy var tableDataSource: TableViewDataSource = {
        return TableViewDataSource(items: self.staticHeaderDataSource)
    }()
    
    lazy var staticHeaderDataSource: DataSourceType = {
        let dict: [DummyHeaderViewModel: [ItemType]] = [DummyHeaderViewModel(title: "Header 1", textColor: .white):
                                                        [DummyViewModel(label: "Foo"), DummyViewModel(label: "Bar")],
                                                        DummyHeaderViewModel(title: "Header 2", textColor: .white):
                                                        [DummyViewModel(label: "Baz"), DummyViewModel(label: "Qux")]]
        
       return NestedDataSource<DummyHeaderViewModel>(items: dict, sectionsComparator: >)
    }()
    
    fileprivate var tableViewDelegate: TableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DummyHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: String(describing: DummyHeaderView.self))
        tableView.estimatedSectionHeaderHeight = 40.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.dataSource = tableDataSource
        tableViewDelegate = TableViewDelegate(tableViewDataSource: tableDataSource)
        tableView.delegate = tableViewDelegate
    }
}

