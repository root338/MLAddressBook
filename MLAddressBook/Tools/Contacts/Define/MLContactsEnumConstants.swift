//
//  MLContactsEnumConstants.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

import Contacts

//MARK:- 别名
public typealias MLContact = CNContact

//MARK:- 枚举

/// 联系人错误
///
/// - notDetermined: 还没有决定
/// - permissionDenied: 没有权限(家长控制/用户拒绝)
/// - other: 其他错误
enum MLContactsError: Error {
    
    case notDetermined
    case permissionDenied
    case other
}

//MARK:- 常量
