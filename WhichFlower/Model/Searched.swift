//
//  Searched.swift
//  WhichFlower
//
//  Created by aisenur on 30.03.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation
import RealmSwift

class Searched: Object {
    
    @objc dynamic var flowerName: String?
    @objc dynamic var flowerDescription: String?
    @objc dynamic var dateCreated: Date = Date()
    @objc dynamic var flowerImgUrl: String?
}
