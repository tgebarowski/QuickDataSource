import UIKit

public class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var items: DataSourceType

    public init(items: DataSourceType) {
        self.items = items
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.sectionsCount
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return items.itemsCount(section: section)
    }


    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items.item(index: indexPath.row, section: indexPath.section)
        let viewModelBinder = item.cellToViewModelBinder()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModelBinder.reuseId, for: indexPath)
        viewModelBinder.update(cell: cell)

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        guard let viewModelBinder = items.item(section: indexPath.section,
                                               kind: nil)?.cellToViewModelBinder() else {
                return UICollectionReusableView()
        }
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: viewModelBinder.reuseId,
                                                                   for: indexPath)
        viewModelBinder.update(cell: cell)

        return cell
    }
}
