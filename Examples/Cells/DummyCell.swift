import UIKit
import QuickDataSource

class DummyCell: UITableViewCell {
    @IBOutlet fileprivate weak var label: UILabel!
}

extension DummyCell: CellLoadableType {
    
    func load(viewModel: DummyViewModel) {
        label.text = viewModel.label
    }
}
