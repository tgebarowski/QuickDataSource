import Foundation
import QuickDataSource

class ColorCell: UITableViewCell {}

extension ColorCell: CellLoadableType {
    
    func load(viewModel: ColorViewModel) {
        contentView.backgroundColor = viewModel.color
    }
}
