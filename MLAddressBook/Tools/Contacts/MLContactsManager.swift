//
//  MLContactsManager.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

import Contacts

@available(iOS 9.0, *)
open class MLContactsManager: NSObject {
    
    let contactsStore = CNContactStore.init()
    
    
}

// MARK: - 授权信息
extension MLContactsManager {
    /// 获取用户联系人的授权状态
    class var usersContactsAuthorizationStatus : CNAuthorizationStatus {
        return CNContactStore.authorizationStatus(for: .contacts)
    }
    /// 获取用户授权状态，当用户没有设置时，直接请求授权，返回授权结果状态
    /// - Parameter completion: 返回在主线程
    func usersContactsAuthorizationStatus(completion: @escaping (CNAuthorizationStatus, Error?) -> Void) {
        
        let status = MLContactsManager.usersContactsAuthorizationStatus
        if status != .notDetermined {
            completion(status, nil)
        }else {
            self.requestAccess(for: .contacts) { (resultValue, error) in
                
                let status = MLContactsManager.usersContactsAuthorizationStatus
                DispatchQueue.main.async {
                    completion(status, error)
                }
            }
        }
    }
    
    /// 请求联系的授权
    ///
    /// completion 返回异步线程
    func requestAccess(for entityType: CNEntityType, completion: @escaping (Bool, Error?) -> Void) {
        contactsStore.requestAccess(for: entityType, completionHandler: completion)
    }
}

// MARK: - 检索联系人
extension MLContactsManager {
    
    open func unifiedContacts(matching predicate: NSPredicate, keysToFetch keys: [CNKeyDescriptor]) throws -> [MLContact] {
        let contacts = try contactsStore.unifiedContacts(matching: predicate, keysToFetch: keys)
        return contacts
    }
    
    open func syncRequestContacts(keysToFetch keys: [CNKeyDescriptor]) throws -> [MLContact] {
        
        var contacts = [CNContact]()
        try enumerateContacts(with: CNContactFetchRequest.init(keysToFetch: keys), usingBlock: { (contact, _) in
            contacts.append(contact)
        })
        return contacts
    }
    
    open func asyncRequestContacts(keysToFetch keys: [CNKeyDescriptor], usingBlock block: @escaping (MLContactsResult<[MLContact]>) -> Void) {
        
        DispatchQueue.global().async {
            do {
                var contacts = [MLContact]()
                try self.enumerateContacts(with: CNContactFetchRequest.init(keysToFetch: keys), usingBlock: { (contact, _) in
                    contacts.append(contact)
                })
                DispatchQueue.main.async {
                    block(MLContactsResult.success(contacts))
                }
            }catch {
                block(MLContactsResult.failure(error))
            }
        }
    }
    
    open func enumerateContacts(with fetchRequest: CNContactFetchRequest, usingBlock block: @escaping (MLContact, UnsafeMutablePointer<ObjCBool>) -> Void) throws {
        try contactsStore.enumerateContacts(with: fetchRequest, usingBlock: block)
    }
    
    
}
