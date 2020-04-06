//
//  SearchedManager.swift
//  WhichFlower
//
//  Created by aisenur on 3.04.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


protocol DbOperations {
    func save()
    func delete()
}

class SearchedManager: DbOperations  {
    var realm = try! Realm()
    
    private var searched = Searched()
    
    init(_searched: Searched) {
        searched = _searched
    }
    
    func save() {
        do {
            try realm.write {
                realm.add(searched)
            }
        } catch {
            print(K.SearchedManager.saveModelFailed, ", \(error)")
        }
    }
    
    func delete() {
        do {
            try self.realm.write {
                self.realm.delete(searched)
            }
        } catch {
            print(K.SearchedManager.deleteModelFailed, ", \(error)")
        }
    }
    
}
