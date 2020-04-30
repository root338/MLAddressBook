//
//  MLContactHelper.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import Contacts.CNContactFormatter

private typealias MLContactGroupDictResult = (groupDict: [String : MLContactGroupItem], otherGroup: MLContactGroupItem?)

/// 联系人组错误
///
/// - getFirstPinyin: 获取首字母拼音错误
enum MLContactGroupError : Error {
    case getFirstPinyin
}

class MLContactHelper: NSObject {
    
    
}

class MLContactGroupHelper: NSObject {
    
    class func grouping(contacts: [MLContact], groupType: MLContactGroupType, sortType: MLContactSort) throws -> MLContactGroup {
        
        let groupDict : MLContactGroupDictResult
        switch groupType {
        case .yinpinFirst:
            try groupDict = pinyinFirstGroup(contacts: contacts)
        }
        
        return sort(sourceGroupResult: groupDict, type: sortType)
    }
}

// MARK: - 联系人分类
private extension MLContactGroupHelper {
    class func pinyinFirstGroup(contacts: [MLContact]) throws -> MLContactGroupDictResult {
        
        var contactGroupDict = [String : MLContactGroupItem]()
        var otherContacts : MLContactGroupItem? = nil
        
        func addContact(contact: MLContact, title: String?) {
            
            if title != nil {
                var groupItem = contactGroupDict[title!]
                if groupItem == nil {
                    groupItem = MLContactBaseGroupItem.init(title: title!, contactList: [])
                    contactGroupDict.updateValue(groupItem!, forKey: title!)
                }
                groupItem?.add(contact: contact)
            }else {
                if otherContacts == nil {
                    otherContacts = MLContactBaseGroupItem.init(title: MLContactGroupOtherTitleValue, contactList: [])
                }
                otherContacts?.add(contact: contact)
            }
        }
        
        func createGroup(items: [MLContactGroupItem]) -> MLContactGroup {
            return MLContactGroup.init(items: items)
        }
        
        let regex = "[a-zA-Z]+"
        let englishAlphabetPredicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        
        for contact in contacts {
            let firstAvailableName = contact.ml_firstAvailableName
            var groupItemTitle : String? = nil
            
            if !firstAvailableName.isEmpty {
                
                let prefixWord = firstAvailableName.prefix(1)
                do {
                    let prefixWordPinyin = try String(prefixWord).ml_transformToPinyin()
                    if englishAlphabetPredicate.evaluate(with: prefixWordPinyin) {
                        let firstPinyin = prefixWordPinyin.prefix(1).localizedLowercase
                        groupItemTitle = String(firstPinyin)
                    }
                }
                catch {
                    throw MLContactGroupError.getFirstPinyin
                }
            }
            
            addContact(contact: contact, title: groupItemTitle)
        }
        
        return (contactGroupDict, otherContacts)
    }
}

// MARK: - 联系人排序
private extension MLContactGroupHelper {
    
    class func sort(sourceGroupResult: MLContactGroupDictResult, type: MLContactSort) -> MLContactGroup {
        let keys = sourceGroupResult.groupDict.keys
        var didSortKeys : [String]
        switch type {
        case .ascending:
            didSortKeys = keys.sorted(by: <)
        case .descending:
            didSortKeys = keys.sorted(by: >)
        }
        
        var groupItems = [MLContactGroupItem]()
        let contactFormatter = CNContactFormatter.init()
        
        func sort(groupItem: MLContactGroupItem) {
            let groupSortResultValue = groupItem.contactList.sorted { (con1, con2) -> Bool in
                guard contactFormatter.verifyString(from: con1), let con1Name = contactFormatter.string(from: con1) else {
                    return false
                }
                guard contactFormatter.verifyString(from: con2), let con2Name = contactFormatter.string(from: con2) else {
                    return true
                }
                
                let resultValue = con1Name < con2Name
                switch type {
                case .ascending:
                    return resultValue
                case .descending:
                    return !resultValue
                }
            }
            groupItem.reset(contacts: groupSortResultValue)
        }
        
        let groupDict = sourceGroupResult.groupDict
        
        for key in didSortKeys {
            let groupItem : MLContactGroupItem! = groupDict[key]
            sort(groupItem: groupItem)
            groupItems.append(groupItem)
        }
        
        if sourceGroupResult.otherGroup != nil {
            sort(groupItem: sourceGroupResult.otherGroup!)
            groupItems.append(sourceGroupResult.otherGroup!)
        }
        
        return MLContactGroup.init(items: groupItems)
    }
    
    
}
