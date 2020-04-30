//
//  MLContactsGroupViewController.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Contacts

class MLContactsGroupViewController: UITableViewController {
    
    private let contactsManager = MLContactsManager.init()
    private let groupManager = MLContactGroupManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = groupManager
        self.tableView.dataSource = groupManager
        
        requestContactsGroup()
    }
}

private extension MLContactsGroupViewController {
    
    func requestContactsGroup() {
        contactsManager.usersContactsAuthorizationStatus { [weak self] (status, error) in
            if status == .authorized {
                
                self?.contactsManager.asyncRequestContacts(keysToFetch: MLContactsConstant.allKeys as [CNKeyDescriptor], usingBlock: { (result) in
                    do {
                        let contacts = try result.resolve()
                        self?.handle(contacts: contacts)
                    }catch {
                        self?.handleGetContactsError(error)
                    }
                })
            }else {
                self?.handlePermissionDeniedResult()
            }
        }
    }
    
    func handlePermissionDeniedResult() {
        
    }
    
    func handle(contacts: [MLContact]) {
        
        do {
            
            let result = try MLContactGroupHelper.grouping(contacts: contacts, groupType: .yinpinFirst, sortType: .ascending)
            
        }catch {
            
        }
        
    }
    
    func handleGetContactsError(_ error: Error) {
        
    }
}
