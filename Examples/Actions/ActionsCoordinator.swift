import UIKit

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
    
    func handle(item: ColorViewModel) {
        let alert = UIAlertController(title: "Alert", message: "ColorViewModel",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func handle(item: GridViewModel) {
        let alert = UIAlertController(title: "Alert", message: item.title,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

protocol ActionsHandler {
    func accept(visitor: ActionsCoordinator)
}

extension DummyViewModel: ActionsHandler {
    func accept(visitor: ActionsCoordinator) { visitor.handle(item: self) }
}

extension ColorViewModel: ActionsHandler {
    func accept(visitor: ActionsCoordinator) { visitor.handle(item: self) }
}
