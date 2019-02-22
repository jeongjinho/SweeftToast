//
//  CellReusable.swift
//  Toast
//
//  Created by jeongjinho on 20/02/2019.
//  Copyright © 2019 jeongjinho. All rights reserved.
//

import UIKit

protocol CellReusable {
    static var reuseIdentifier: String { get }
}
extension UITableViewCell: CellReusable {
    static var reuseIdentifier: String {
        return String(describing: self.self)
    }
}

extension UITableView {
    func register<T>(cell: T.Type) where T: UITableViewCell {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    func registerForNib<T>(cell: T.Type) where T: UITableViewCell {
        register(UINib(nibName: cell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: cell.reuseIdentifier)
    }
}
