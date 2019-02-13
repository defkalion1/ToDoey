//
//  Category.swift
//  ToDoey
//
//  Created by Defkalion on 13/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
