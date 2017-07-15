//
//  String+Extension.swift
//  Pods
//
//  Created by Wo Jun Feng on 7/15/17.
//
//

import Foundation

extension String {
    var isValid: Bool {
        get {
            return self.characters.count > 0
        }
    }
}
