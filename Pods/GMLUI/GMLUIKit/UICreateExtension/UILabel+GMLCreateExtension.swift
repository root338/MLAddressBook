//
//  UILabel+GMLCreateExtension.swift
//  GMLUIDemo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(font: UIFont?, textColor: UIColor?, text: String? = nil) {
        self.init(frame: .zero)
        if font != nil {
            self.font = font!
        }
        if textColor != nil {
            self.textColor = textColor
        }
        self.text = text
    }
    
    convenience init(textAlignment: NSTextAlignment = NSTextAlignment.left, lineBreakMode: NSLineBreakMode = NSLineBreakMode.byTruncatingTail, font: UIFont? = nil, textColor: UIColor? = nil, text: String? = nil) {
        self.init(font: font, textColor: textColor, text: text)
        self.textAlignment = textAlignment
        self.lineBreakMode = lineBreakMode
    }
}
