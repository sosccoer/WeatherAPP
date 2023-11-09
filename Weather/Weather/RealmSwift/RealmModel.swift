//
//  RealmModel.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 3.11.23.
//

import Foundation
import RealmSwift

class MainCellsRealm: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var mainCells = Data()
    @objc dynamic var completed = Bool()
    
}
