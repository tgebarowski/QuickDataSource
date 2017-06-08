//
//  ThirdViewController.swift
//  QuickDataSource
//
//  Created by Pawel Kowalczuk on 07/06/2017.
//  Copyright © 2017 Tomasz Gebarowski. All rights reserved.
//

import Foundation
import QuickDataSource

class ThirdViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    lazy var tableDataSource: TableViewDataSource = {
        return TableViewDataSource(items: CustomDataSource(list: [
            DummyViewModel(label: "Foo"),
            RandomColorViewModel(color: UIColor.random),
            DummyViewModel(label: "Bar"),
            RandomColorViewModel(color: UIColor.random)
            ]))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableDataSource
    }
}

private extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
private extension UIColor {
    
    static var random: UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
