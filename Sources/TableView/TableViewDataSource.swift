import UIKit

open class TableViewDataSource: NSObject, UITableViewDataSource {
    
    internal let items: DataSourceType
    
    public init(items: DataSourceType) {
        self.items = items
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return items.sectionsCount
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items.item(index: indexPath.row, section: indexPath.section)
        let viewModelBinder = item.cellToViewModelBinder()
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModelBinder.reuseId, for: indexPath)
        viewModelBinder.update(cell: cell)
 
        return cell
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.itemsCount(section: section)
    }
    
    @nonobjc open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let viewModelBinder = items.item(section: section, kind: nil)?.cellToViewModelBinder(),
              let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewModelBinder.reuseId)
        else {
            return nil
        }
        
        viewModelBinder.update(cell: cell)
        
        return cell
    }
    
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String,
                        at index: Int) -> Int {
        return 0
    }
}
