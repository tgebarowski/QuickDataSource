# QuickDataSource

μFramework for writing testable Data Sources and ViewModels for UITableView and UICollectionView. It promotes separation of concerns and encourages to write less boilerplate code.

# Features

✅ The same data source for UITableView and UICollectionView. 

✅ Supporting different cell types within a single Table or Collection View. 

✅ Model, View and logic separation. 

✅ Less boilerplate.

✅ Out of box support for flat, nested and aggregated (i.e. date-driven) data sources. 

✅ Integrates well with coordinator pattern and ViewModels. 


# Requirements

- iOS 10.0+
- Xcode 10.1+
- Swift 4.2+


# Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. To integrate QuickDataSource into your Xcode project using CocoaPods, specify the following in your `Podfile`:

```ruby
pod 'QuickDataSource', '~> 1.0.0'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate QuickDataSource into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "tgebarowski/QuickDataSource" "1.0.0"
```

# Quick tutorial

## Flat list

Implementing a flat cell list (without section headers) supporting different cell types. 

### Step 1 (Create cell)

Create UITableViewCell representing content to be displayed.

 ```swift
class DummyCell: UITableViewCell {
    @IBOutlet fileprivate weak var label: UILabel!
}
```

By conforming to _CellLoadableType_ we are providing a _load(viewModel:)_ method, binding ViewModel data with _@IBOutlets_ properties:

```swift
extension DummyCell: CellLoadableType {
    
    func load(viewModel: DummyViewModel) {
        label.text = viewModel.label
    }
}
 ```

 
### Step 2 (Create View model)

 ```swift
struct DummyViewModel: Equatable, Hashable {
    let label: String
}
```

By implementing _ItemType_ protocol we provide a _cellToViewModelBinder()_ method which returns a binding between cell and ViewModel.

```swift
extension DummyViewModel: ItemType  {
    func cellToViewModelBinder() -> CellToViewModelBinderType {
        return CellToViewModelBinder<DummyCell>(viewModel: self)
    }
}
```

### Step 3 (View Controller)

When ViewModels, Cells and binding between them are defined we may create a View Controller responsible for displaying the content.
Let's assume that we have a static list of cells. We can create a _FlatDataSource_ passing a list of _DummyViewModels_ and wrap the FlatDataSource with TableViewDataSource, assigning it to tableView.dataSource property. With this approach, there is no need to implement _UITableViewDataSource_ protocol and we may almost seamlessly use our _FlatDataSource_ as _UICollectionViewData_ source by wrapping it with _CollectionViewDataSource_.

```swift
class FlatDataSourceViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    lazy var staticDataSource: DataSourceType = {
        return FlatDataSource(items: [DummyViewModel(label: "Foo"),
                                      DummyViewModel(label: "Bar"),
                                      DummyViewModel(label: "Tar")])
    }()
    
    lazy var tableDataSource: TableViewDataSource = {
        return TableViewDataSource(items: self.staticDataSource)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableDataSource
    }
}
```

Note that we have to make a strong reference to our _tableDataSource_, because _tableView.dataSource_ is not retaining the reference. 
Lazy vars that appear throughout the source code are used to make the code shorter, for production ready code, consider using dependency injection.


_FlatDataSource_ does not limit us to use only a single ViewModel type, we may create various ViewModels and map them to different cells:

```swift
struct DateViewModel: Equatable, Hashable {
    let date: String
}

extension DummyViewModel: ItemType  {
    func cellToViewModelBinder() -> CellToViewModelBinderType {
        return CellToViewModelBinder<DateCell>(viewModel: self)
    }
}

class DateCell: UITableViewCell {
    @IBOutlet fileprivate weak var dateLabel: UILabel!
}

extension DummyCell: CellLoadableType {
    
func load(viewModel: DateViewModel) {
   dateLabel.text = viewModel.date
}
}

```

and use it like that:

```swift
lazy var staticDataSource: DataSourceType = {
    return FlatDataSource(items: [DummyViewModel(label: "Foo"),
                                  DateViewModel(date: "7th of May"),
                                  DummyViewModel(label: "Tar")])
}()
```

Note that we assumed here that cells are defined in Storyboard as we don't have to register them, but this approach will work also with cells layout written from code or using XIBs.

## Nested Data Source


Sometimes a flat list of cells is not enough. For that purpose, I created a _NestedDataSource_, which allows grouping our data into sections which are described by corresponding headers.

We can introduce such a header by defining its View and corresponding ViewModel.

```swift
class DummyHeaderView: UITableViewHeaderFooterView {
    
    fileprivate let label = UILabel()
    ...
}

extension DummyHeaderView: CellLoadableType {
    
    func load(viewModel: DummyHeaderViewModel) {
        label.text = viewModel.title
        label.textColor = viewModel.textColor
    }
}

struct DummyHeaderViewModel: Hashable, Equatable {
    let title: String
    let textColor: UIColor
    
    init(title: String, textColor: UIColor = .white) {
        self.title = title
        self.textColor = textColor
    }
}

extension DummyHeaderViewModel: ItemType {
    
    func cellToViewModelBinder() -> CellToViewModelBinderType {
        return CellToViewModelBinder<DummyHeaderView>(viewModel: self)
    }
}
```

Secondly, we add conformance to _Comparable_, so that _DummyHeaderViewModel_ knows how to sort itself on the list.

```swift
extension DummyHeaderViewModel: Comparable {
    static func < (lhs: DummyHeaderViewModel, rhs: DummyHeaderViewModel) -> Bool {
        return lhs.title < rhs.title
    }
}
```

As a next step, we can prepare a NestedDataSource fed by a dictionary mapping sections represented by _DummyHeaderViewModel_ with an array of _DummyViewModel_.
Note that as long as our items in an array are conforming to _ItemType_ we may mix cells of different type within the array.


```swift
lazy var staticHeaderDataSource: DataSourceType = {
    let dict: [DummyHeaderViewModel: [ItemType]] = [DummyHeaderViewModel(title: "Header 1", textColor: .white):
                                                   [DummyViewModel(label: "Foo"), DummyViewModel(label: "Bar")],
                                                   DummyHeaderViewModel(title: "Header 2", textColor: .white):
                                                   [DummyViewModel(label: "Baz"), DummyViewModel(label: "Qux")]]
        
    return NestedDataSource<DummyHeaderViewModel>(items: dict, sectionsComparator: >)
}()

lazy var tableDataSource: TableViewDataSource = {
    return TableViewDataSource(items: self.staticHeaderDataSource)
}()
```

We are using here a custom sections comparator that is implemented by less than operator (<) defined in DummyHeaderViewModel extension.

Because _UITableView_ headers are returned from _UITableViewDelegate_ (not _UITableViewDataSource_), we have to construct one, feeding it with data source items:

```swift
lazy var tableDelegate: UITableViewDelegate = {
    return TableViewDelegate(tableViewDataSource: self.tableViewDataSource)
}()

```

Finally when all above is done we can assign _UITableView_ properties to our wrappers:

```swift
tableView.dataSource = self.tableDataSource
tableView.delegate = self.tableViewDelegate
```

## Aggregated Data Source

Let's assume that we have a model that represents some orders and includes a date when an order was made:

```swift
struct Order {
    let date: Date
    let name: String
}
```

We would like to group our orders by day. We could use an _AggregatedDataSource_ without writing too much code. The first thing that we have to do is to add conformance to _Aggregating_ protocol to our model:

```swift
extension Order: Aggregating {
    var aggregator: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}
``` 

The protocol defines a single computed property (_aggregator_) that provides a string representation of what we what to aggregate.

Note that constructing a _DateFormatter_ is an expensive operation so on a production-ready code this should be taken into account. For simplicity reasons let's assume that this is something that is acceptable.

When this is done we may create a static list of orders:

```swift
let orders = [Order(date: Date(), name: "Foo"),
                          Order(date: Date(), name: "Bar"),
                          Order(date: Date(), name: "Baz"),
                          Order(date: Date().addingTimeInterval(3600 * 24 * 7), name: "Qux")]
```

Now let's create a function transforming this list into a dictionary wrapping date with _DummyHeaderViewModel_
 as key and having a list of _DummyViewModel_ representing wrapped orders as dictionary values:

```swift
let aggregator: ([Order]) -> [DummyHeaderViewModel: [DummyViewModel]] = { (items) in
         return Dictionary(grouping: items) { return DummyHeaderViewModel(title: $0.aggregator) }
                                            .mapValues { $0.map { DummyViewModel(label: $0.name ) } }
}
```


When this is done we may create an _AggregatedDataSource_:

```swift
AggregatedDataSource<Order, DummyHeaderViewModel, DummyViewModel>(items: orders,
                                                                  aggregator: aggregator,
                                                                  sectionsComparator: <))
```

_AggregatedDataSource_ is very similar to NestedDataSource with an exception that it provides an entry point to plug in aggregating function.


## Hooking up actions to cell selection

Almost always when working with _UITableView_ or _UICollectionView_ we want to add some interactions when cells are selected.
For that purpose one may use our _TableViewDelegate_ and provide a function that handles cell selection:

```swift
lazy var tableDelegate: TableViewDelegate = {
    return TableViewDelegate(tableViewDataSource: self.tableDataSource,
                                 cellSelectionHandler: self.actionHandler)
}()
```

_actionHandler()_ function could forward action to our ViewModel (conforming to _ItemType_). By introducing _ActionHandler_ protocol to which it may conform we are able to forward invocation from ViewModel to the corresponding method in _ActionCoordinator_ (note that I used here a visitor pattern)


```swift
private func actionHandler(indexPath: IndexPath, item: ItemType?) {
(item as? ActionsHandler)?.accept(visitor: coordinator)
}
```

```swift
protocol ActionsHandler {
    func accept(visitor: ActionsCoordinator)
}

class ActionsCoordinator {
    
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func handle(item: DummyViewModel) {
        let alert = UIAlertController(title: "Alert", message: "DummyViewModel: \(item.label)",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

extension DummyViewModel: ActionsHandler {
    func accept(visitor: ActionsCoordinator) { visitor.handle(item: self) }
}
```

Of course, we may add support to more cells by adding new _handle(item:)_ methods to _ActionsCoordinator_ and adding conformance to _ActionsHandler_ to other ViewModels. Something like that:

```swift
extension DateViewModel: ActionsHandler {
    func accept(visitor: ActionsCoordinator) { visitor.handle(item: self) }
}

extension ActionsCoordinator {
func handle(item: DateViewModel) {
    ...
    }
}
```


## Supporting UICollectionView

When at some point we decide to drop _UITableView_ support we may easily migrate our code to use _UICollectionView_. What will not change is the DataSource itself, the only difference is that we will wrap it with _CollectionViewDataSource_ that is provided by _QuickDataSource_ framework.

```swift
lazy var dataSource: DataSourceType = {
    return FlatDataSource(items: [DummyViewModel(label: "Foo"),
                                  DummyViewModel(label: "Bar"),
                                  DummyViewModel(label: "Baz"),
                                  DummyViewModel(label: "Qux"),
                                  DummyViewModel(label: "Yam"),
                                  DummyViewModel(label: "Xam"),
                                  DummyViewModel(label: "Zum")])
}()

lazy var collectionDataSource: CollectionViewDataSource = {
    return CollectionViewDataSource(items: self.dataSource)
}()

lazy var collectionDelegate: CollectionViewDelegate = {
    return CollectionViewDelegate(dataSource: self.dataSource,
                                  cellConfigurator: self.cellConfigurator)
}()

override func viewDidLoad() {
super.viewDidLoad()
...
collectionView.dataSource = collectionDataSource
    collectionView.delegate = collectionDelegate
}

```

Finally, we would have to change _DummyCell_ to inherit from _UICollectionViewCell_ and modify any cell-specific logic if there is any. Isn't it simple?

## Triggering actions from cells

Not all cells are as simple as described so far. Sometimes they have buttons, text fields or invoke specific logic from outside of the cell's scope.
For that purpose, one may use a cell decorator that could inject a dependency from outer context.

Let's assume that we have a _GridCell_ that has a _UIButton_. Upon pressing that button an action that is forwarded to our previously defined coordinator is triggered.


```swift
class GridCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var button: UIButton!
    fileprivate var viewModel: GridViewModel?
    
    weak var coordinator: ActionsCoordinator?
    
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
```

One may plug in the coordinator by injecting it via cellConfigurator function or directly closure passed to _CollectionViewDelegate_:

```swift
class GridDataSourceViewController: UIViewController {
    
    ...
    
    lazy var coordinator = {
        return ActionsCoordinator(viewController: self)
    }()
    
    ...
    
   
    lazy var collectionDelegate: CollectionViewDelegate = {
        return CollectionViewDelegate(dataSource: self.dataSource,
                                      cellConfigurator: self.cellConfigurator)
    }()
    
    private func cellConfigurator(cell: UICollectionViewCell) {
        (cell as? GridCell)?.coordinator = self.coordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ...
        collectionView.delegate = collectionDelegate
    }
}
```

As a final step, we could extend _ActionsCoordinator_ to support events triggered by UIButton added to GridCell.

```swift
extension GridViewModel: ActionsHandler {
    func accept(visitor: ActionsCoordinator) { visitor.handle(item: self) }
}

extension ActionsCoordinator {
func handle(item: GridViewModel) {
    ...
    }
}
```

# Examples

For more details see [Examples dictionary](https://github.com/tgebarowski/QuickDataSource/tree/master/Examples).

# Author

Tomasz Gebarowski. 
Twitter: @tgebarowski

# Credits

Many thanks to @arekholko and his ConfigurableTableViewController for the inspiration and some of the key concepts:
[https://github.com/fastred/ConfigurableTableViewController](https://github.com/fastred/ConfigurableTableViewController)

I would like to thank Pawel Kowalczuk ([@riamf1](https://twitter.com/riamf1)) for initial feedback to this project.

