//
//  MLContactBaseGroupItem.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLContactBaseGroupItem: NSObject, MLContactGroupItem {
    var itemIdentifier: String?
    var title: String
    var contactList: [MLContact]
    
    init(title: String, contactList: [MLContact], itemIdentifier: String? = nil) {
        self.title = title
        self.contactList = contactList
        self.itemIdentifier = itemIdentifier
        super.init()
    }
}
