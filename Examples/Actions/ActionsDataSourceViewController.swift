import UIKit
import QuickDataSource

class ActionsDataSourceViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    lazy var coordinator: ActionsCoordinator = {
        return ActionsCoordinator(viewController: self)
    }()
    
    lazy var staticDataSource: DataSourceType = {
        return FlatDataSource(items: [DummyViewModel(label: "Foo"),
                                      ColorViewModel(color: .gray),
                                      DummyViewModel(label: "Bar"),
                                      ColorViewModel(color: .gray),])
    }()
    
    lazy var tableDataSource: TableViewDataSource = {
        return TableViewDataSource(items: self.staticDataSource)
    }()
    
    lazy var tableDelegate: TableViewDelegate = {
        return TableViewDelegate(tableViewDataSource: self.tableDataSource,
                                 cellSelectionHandler: self.actionHandler)
    }()
    
    private func actionHandler(indexPath: IndexPath, item: ItemType?) {
        (item as? ActionsHandler)?.accept(visitor: coordinator)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
    }
}


