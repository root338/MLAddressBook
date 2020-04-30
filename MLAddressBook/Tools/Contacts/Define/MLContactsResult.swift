//
//  MLContactsResult.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

public enum MLContactsResult<T> {
    case success(T)
    case failure(Error)
}

public extension MLContactsResult {
    func resolve() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let err):
            throw err
        }
    }
}
