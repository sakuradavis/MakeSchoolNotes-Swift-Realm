//
//  File.swift
//  MakeSchoolNotes
//
//  Created by sakura davis on 6/29/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift


//Define the Note class! We need to import the RealmSwift header, make Note a subclass of Realm's Object class, and make the properties are dynamic.


class Note: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var modificationTime = NSDate()
}