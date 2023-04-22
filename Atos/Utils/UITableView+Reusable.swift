//
//  UITableView+DequeueCells.swift
//  Atos
//
//  Created by Piotr Debosz on 21/04/2023.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<Cell: UITableViewCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: cellType)
        
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue a cell with identifier: \(identifier)")
        }
        
        return cell
    }
    
    func registerCell<Cell: UITableViewCell>(_ cellType: Cell.Type) {
        let identifier = String(describing: cellType)
        
        register(cellType, forCellReuseIdentifier: identifier)
    }
}
