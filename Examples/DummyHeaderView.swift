//
//  DummyHeaderView.swift
//  QuickDataSource
//
//  Created by Pawel Kowalczuk on 07/06/2017.
//  Copyright © 2017 Tomasz Gebarowski. All rights reserved.
//

import UIKit
import QuickDataSource

class DummyHeaderView: UITableViewHeaderFooterView {
    
    fileprivate let label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupSubviews() {
        contentView.backgroundColor = UIColor.lightGray
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension DummyHeaderView: CellLoadableType {
    
    func load(viewModel: DummyHeaderViewModel) {
        label.text = viewModel.title
        label.textColor = viewModel.textColor
    }
}
