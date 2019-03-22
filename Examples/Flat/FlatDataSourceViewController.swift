import UIKit
import QuickDataSource

class FlatDataSourceViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    lazy var staticDataSource: DataSourceType = {
        return FlatDataSource(items: [DummyViewModel(label: "Foo"),
                                      DummyViewModel(label: "Bar"),
                                      DummyViewModel(label: "Tar")])
    }()
    
    lazy var tableDataSource: TableViewDataSource = {
        return TableViewDataSource(items: self.staticDataSource)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableDataSource
    }
}
