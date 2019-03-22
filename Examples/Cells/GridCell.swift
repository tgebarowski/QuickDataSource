import Foundation
import QuickDataSource

class GridCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var button: UIButton!
    fileprivate var viewModel: GridViewModel?
    
    var coordinator: ActionsCoordinator?
    
    @IBAction func buttonTapped(sender: UIButton) {
        guard let viewModel = viewModel else { return }
        self.coordinator?.handle(item: viewModel)
    }
}

extension GridCell: CellLoadableType {
    func load(viewModel: GridViewModel) {
        self.viewModel = viewModel
        button.setTitle(viewModel.title, for: .normal)
    }
}
