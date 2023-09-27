//
//  extensionForBool+Int.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 26.09.23.
//

import Foundation

extension Bool {
    init(_ value: Int) {
        if value == 0 {
            self = false
        } else {
            self = true
        }
    }
}
