//
//  MLContactsConstant.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018 apple. All rights reserved.
//

import Contacts

@available(iOS 9.0, *)
class MLContactsConstant {
    /// 联系人所有的属性
    class var allKeys : [String] {
        var keys = [
            CNContactIdentifierKey,
            
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactNamePrefixKey,
            CNContactMiddleNameKey,
            CNContactNameSuffixKey,
            CNContactTypeKey,
            CNContactOrganizationNameKey,
            
            CNContactPhoneticGivenNameKey,
            CNContactPhoneticMiddleNameKey,
            CNContactPhoneticFamilyNameKey,
            
            CNContactNicknameKey,
            CNContactDepartmentNameKey,
            CNContactJobTitleKey,
            CNContactBirthdayKey,
            CNContactNoteKey,
            CNContactImageDataKey,
            CNContactThumbnailImageDataKey,
            CNContactImageDataAvailableKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactPostalAddressesKey,
            CNContactUrlAddressesKey,
            CNContactDatesKey,
            CNContactRelationsKey,
            CNContactSocialProfilesKey,
            CNContactInstantMessageAddressesKey
        ]
        
        if #available(iOS 10.0, *) {
            keys.append(CNContactPhoneticOrganizationNameKey)
        }
        
        return keys
    }
    
    /// 联系人姓名组合必须的属性
    class var fullNameMustKeys : [String] {
        let keys = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactNamePrefixKey,
            CNContactMiddleNameKey,
            CNContactNameSuffixKey,
            CNContactTypeKey,
            CNContactOrganizationNameKey,
        ]
        return keys
    }
    /// 联系人姓名语音组合必须的属性
    class var phoneticFullNameMustKeys : [String] {
        var keys = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactNamePrefixKey,
            CNContactMiddleNameKey,
            CNContactNameSuffixKey,
            CNContactTypeKey,
            CNContactOrganizationNameKey,
            
            CNContactPhoneticGivenNameKey,
            CNContactPhoneticMiddleNameKey,
            CNContactPhoneticFamilyNameKey,
        ]
        
        if #available(iOS 10.0, *) {
            keys.append(CNContactPhoneticOrganizationNameKey)
        }
        
        return keys
    }
}
