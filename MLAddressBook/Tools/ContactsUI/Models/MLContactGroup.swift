//
//  MLContactGroup.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLContactGroup: NSObject {
    
    var groupIdentifier : String?
    var items: [MLContactGroupItem]
    
    init(items: [MLContactGroupItem], groupIdentifier: String? = nil) {
        self.groupIdentifier = groupIdentifier
        self.items = items
        super.init()
    }
}
