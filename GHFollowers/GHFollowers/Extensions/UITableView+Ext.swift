//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/20/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
