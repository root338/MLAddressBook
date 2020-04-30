//
//  CNContactFormatter+Extension.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018 apple. All rights reserved.
//

import Contacts.CNContactFormatter

public extension CNContactFormatter {
    
    /// 验证指定样式是否可以转换
    ///
    /// - Returns: true 可以转换，false 不可以
    public class func verifyString(from contact: CNContact, style: CNContactFormatterStyle = CNContactFormatterStyle.fullName) -> Bool {
        let mustKeys : [String]
        switch style {
        case .fullName:
            mustKeys = MLContactsConstant.fullNameMustKeys
        case .phoneticFullName:
            mustKeys = MLContactsConstant.phoneticFullNameMustKeys
        }
        for keyName in mustKeys {
            let isAvailaleKey = contact.isKeyAvailable(keyName)
            if !isAvailaleKey {
                return false
            }
        }
        return true
    }
    
    public func verifyString(from contact: CNContact, style: CNContactFormatterStyle = CNContactFormatterStyle.fullName) -> Bool {
        return CNContactFormatter.verifyString(from: contact, style: style)
    }
    
    
}
