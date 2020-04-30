//
//  String+MLExtension.swift
//  MLAddressBook
//
//  Created by apple on 2018/10/24.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

extension String {
    
    /// 字符串转换失败
    ///
    /// - isEmpty: 字符串为空
    /// - countOutOfRange: 转换超出范围
    /// - transformError: 执行过程中转换失败
    enum MLStringTransformError: Error {
        case isEmpty
        case countOutOfRange
        case transformError
    }
    
    /// 字符串转拼音
    ///
    /// - Parameter isStripCombiningMarks: 是否去除重音
    /// - Returns: 返回一个字符串
    /// - Throws: MLStringTransformError 类型错误
    func ml_transformToPinyin(isStripCombiningMarks: Bool = true) throws -> String {
        
        let resultValue = try ml_transform()
        if isStripCombiningMarks {
            guard self != resultValue else {
                return resultValue
            }
            return try resultValue.ml_transform(kCFStringTransformStripCombiningMarks as String)
        }else {
            return resultValue
        }
    }
    
    func ml_transform(_ transform: String = kCFStringTransformToLatin as String) throws -> String  {
        return try ml_transform(range: CFRangeMake(0, self.count), transform: transform, reverse: false)
    }
    
    func ml_transform(range: CFRange, transform: String = kCFStringTransformToLatin as String, reverse: Bool = false) throws -> String {
        guard !self.isEmpty else {
            throw MLStringTransformError.isEmpty
        }
        
        guard range.length >= 0, range.location >= 0, range.location + range.length <= self.count else {
            throw MLStringTransformError.countOutOfRange
        }
        let str : CFMutableString = NSMutableString(string: self) as CFMutableString
        var tmpRange = range
        let resultValue = CFStringTransform(str, &tmpRange, transform as CFString, reverse)
        guard resultValue else {
            throw MLStringTransformError.transformError
        }
        return str as String
    }
}
