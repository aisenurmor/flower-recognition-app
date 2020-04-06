//
//  UITableViewExtensions.swift
//  WhichFlower
//
//  Created by aisenur on 3.04.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func nullTableView(tableView: UITableView, view: UIView?) {
        if let selectedView = view {
            tableView.backgroundView  = selectedView
            tableView.separatorStyle = .none
        } 
        tableView.backgroundColor = K.TableView.bgColor
    }
    
    
    func rowCustomization(tableView: UITableView) {
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.rowHeight = CGFloat(K.TableView.rowHeight)
    }

}
