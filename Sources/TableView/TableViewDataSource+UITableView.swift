import Foundation

public extension TableViewDataSource {
    func propagate(to tableView: UITableView) {
        tableView.dataSource = self
        tableView.reloadData()
    }
}
