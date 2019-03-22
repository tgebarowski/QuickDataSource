import UIKit

public typealias CellSelectionHandler = ((IndexPath, ItemType) -> Void)
public typealias CellConfigurator = ((UITableViewCell) -> Void)

open class TableViewDelegate : NSObject, UITableViewDelegate {
    
    public let tableViewDataSource: TableViewDataSource
    
    private var cellSelectionHandler: CellSelectionHandler?
    private var cellConfigurator: CellConfigurator?
    
    public init(tableViewDataSource: TableViewDataSource,
                cellSelectionHandler: CellSelectionHandler? = nil,
                cellConfigurator: CellConfigurator? = nil) {
        
        self.tableViewDataSource = tableViewDataSource
        self.cellSelectionHandler = cellSelectionHandler
        self.cellConfigurator = cellConfigurator
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewDataSource.tableView(tableView, viewForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.tableViewDataSource.items.item(index: indexPath.row,
                                                            section: indexPath.section)
        cellSelectionHandler?(indexPath,viewModel)
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellConfigurator?(cell)
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
