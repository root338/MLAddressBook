//
//  MLContactGroupManager.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

extension MLContactGroupManager {
    
}

open class MLContactGroupManager: NSObject {
    private var contactGroupList = [MLContactGroupItem]()
}

// MARK: - UITableViewDataSource
extension MLContactGroupManager: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactGroupList[section].contactList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
}

extension MLContactGroupManager: UITableViewDelegate {
    
}
