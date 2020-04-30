//
//  MLContactGroupItem.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

protocol MLContactGroupItem: NSObjectProtocol {
    
    var itemIdentifier: String? {get}
    var title: String {get}
    var contactList: [MLContact] {get set}
    
    func reset(contacts: [MLContact])
    func add(contact: MLContact)
    func add(contacts: [MLContact])
    
//    func remove(contact: MLContact) -> MLContact?
//    func remove(contacts: [MLContact]) -> [MLContact]?
    
    func inset(contact: MLContact, at index: Int)
    func inset(contact: [MLContact], at index: Int)
}

extension MLContactGroupItem {
    
    func reset(contacts: [MLContact]) {
        contactList.removeAll()
        contactList.append(contentsOf: contacts)
    }
    
    func add(contact: MLContact) {
        contactList.append(contact)
    }
    
    func add(contacts: [MLContact]) {
        contactList.append(contentsOf: contacts)
    }
    
//    func remove(contact: MLContact) -> MLContact? {
//
//    }
    
    func inset(contact: MLContact, at index: Int) {
        contactList.insert(contact, at: index)
    }
    
    func inset(contact: [MLContact], at index: Int) {
        contactList.insert(contentsOf: contact, at: index)
    }
}
