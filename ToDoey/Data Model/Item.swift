//
//  Item.swift
//  ToDoey
//
//  Created by Defkalion on 13/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
