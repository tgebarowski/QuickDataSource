import UIKit
import QuickDataSource

class GridDataSourceViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    lazy var coordinator = {
        return ActionsCoordinator(viewController: self)
    }()
    
    lazy var dataSource: DataSourceType = {
        return FlatDataSource(items: [GridViewModel(title: "Foo"),
                                      GridViewModel(title: "Bar"),
                                      GridViewModel(title: "Baz"),
                                      GridViewModel(title: "Qux"),
                                      GridViewModel(title: "Yam"),
                                      GridViewModel(title: "Xam"),
                                      GridViewModel(title: "Zum")])
    }()
    
    lazy var collectionDataSource: CollectionViewDataSource = {
        return CollectionViewDataSource(items: self.dataSource)
    }()
    
    lazy var collectionDelegate: CollectionViewDelegate = {
        return CollectionViewDelegate(dataSource: self.dataSource,
                                      cellConfigurator: self.cellConfigurator)
    }()
    
    private func cellConfigurator(cell: UICollectionViewCell) {
        (cell as? GridCell)?.coordinator = self.coordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = collectionDataSource
        collectionView.delegate = collectionDelegate
    }
}


