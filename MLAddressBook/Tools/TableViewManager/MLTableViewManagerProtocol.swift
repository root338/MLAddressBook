//
//  MLTableViewManagerProtocol.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

protocol MLTableViewManagerProtocol: UITableViewDataSource, UITableViewDelegate {
    
    associatedtype MLDataModel
    var isEmpty : Bool {get}
    var listDataSource : [MLDataModel] {get}
    
    func add(dataList: [MLDataModel], page: Int)
    
}

extension MLTableViewManagerProtocol {
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDataSource.count
    }
}
