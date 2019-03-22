import UIKit

public typealias CollectionCellConfigurator = ((UICollectionViewCell) -> Void)

open class CollectionViewDelegate: NSObject, UICollectionViewDelegate {

    private let dataSource: DataSourceType
    private let cellSelectionHandler: CellSelectionHandler?
    private let cellConfigurator: CollectionCellConfigurator?

    public init(dataSource: DataSourceType,
                cellSelectionHandler: CellSelectionHandler? = nil,
                cellConfigurator: CollectionCellConfigurator? = nil) {

        self.dataSource = dataSource
        self.cellSelectionHandler = cellSelectionHandler
        self.cellConfigurator = cellConfigurator
        super.init()
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        let viewModel = self.dataSource.item(index: indexPath.row, section: indexPath.section)
        cellSelectionHandler?(indexPath,viewModel)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
        cellConfigurator?(cell)
    }
}
