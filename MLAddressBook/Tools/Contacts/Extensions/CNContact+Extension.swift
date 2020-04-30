//
//  CNContact+Extension.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018 apple. All rights reserved.
//

import Contacts.CNContact

extension CNContact {
    
    /// 第一个可用的名字
    var ml_firstAvailableName : String {
        
        var firstAvailableName = ""
        
        if self.isKeyAvailable(CNContactFamilyNameKey) {
            firstAvailableName = self.familyName
        }
        if firstAvailableName.isEmpty {
            if self.isKeyAvailable(CNContactGivenNameKey) {
                firstAvailableName = self.givenName
            }
        }
        if firstAvailableName.isEmpty {
            if self.isKeyAvailable(CNContactOrganizationNameKey) {
                firstAvailableName = self.organizationName
            }
        }
        return firstAvailableName
    }
}

extension CNContact {
    
    func ml_name(style: CNContactFormatterStyle) -> String? {
        guard CNContactFormatter.verifyString(from: self, style: style) else {
            assert(false, "联系人缺少相关属性值")
            return nil
        }
        return CNContactFormatter.string(from: self, style: style)
    }
    
    
}
