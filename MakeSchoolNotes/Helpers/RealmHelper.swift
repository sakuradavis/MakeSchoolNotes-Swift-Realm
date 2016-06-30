//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by sakura davis on 6/29/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//


//In RealmHelper.swift we will define static methods that we can call to add, update, retrieve, and delete notes. 

import Foundation
import RealmSwift

class RealmHelper {
    
    //We want to define a static method that accepts a Note object as its one parameter and then saves that note to the default Realm.
    static func addNote(note: Note) {
       //get access to the default Realm:
        let realm = try! Realm()
        //Write transactions are a special way to inform Realm that we want to change something in the default Realm.
        try! realm.write() {
            //Save
            realm.add(note)
        }
    }
    
    static func deleteNote(note: Note) {
        //get access to the default Realm:
        let realm = try! Realm()
        //Write transactions are a special way to inform Realm that we want to change something in the default Realm.
        try! realm.write() {
            realm.delete(note)
        }
    }
    
    static func updateNote(noteToBeUpdated: Note, newNote: Note) {
        //get access to the default Realm:
        let realm = try! Realm()
        //Write transactions are a special way to inform Realm that we want to change something in the default Realm.
        try! realm.write() {
            //Update all parts
            noteToBeUpdated.title = newNote.title
            noteToBeUpdated.content = newNote.content
            noteToBeUpdated.modificationTime = newNote.modificationTime
        }
    }
    
    static func retrieveNotes() -> Results<Note> {
        //get access to the default Realm:
        let realm = try! Realm()
        //We use the objects() method to retrieve objects. We pass the type of the desired object to the object() method to specify what kind of objects we want to retrieve.
        //Returns a template type
        
        return realm.objects(Note).sorted("modificationTime", ascending: false)
    }
    
}