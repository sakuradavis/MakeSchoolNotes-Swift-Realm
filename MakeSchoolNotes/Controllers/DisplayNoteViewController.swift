//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController {

    //Create optional note property.
    var note: Note?
    
    //Connect note title and content.
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Every time a view controller is about to be displayed on screen, the operating system will call the viewWillAppear() method and populate the text field and text view with the note's title and content.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //If note exists
        if let note = note {
            //Display correctly
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            //Set the text field and text view to empty strings to ensure that our users can immediately begin typing their new note.
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
    
    //Identical to prepareForSegue() method. Check what segue should happen.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Downcast, specify that the destination is a ListNotesViewController, not just any UIViewController.
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        
        
        if let identifier = segue.identifier {
            if identifier == "Cancel" {
                print("Cancel button tapped")
            } else if identifier == "Save" {
                // if note exists, update title and content
                if let note = note {
                    //Create a new note with the user's updated note content and pass it to the helper
                    let newNote = Note()
                    newNote.title = noteTitleTextField.text ?? ""
                    newNote.content = noteContentTextView.text ?? ""
                    //add the newly created note to Realm
                    RealmHelper.updateNote(note, newNote: newNote)
                } else {
                    // if note does not exist, create new note
                    let note = Note()
                    note.title = noteTitleTextField.text ?? ""
                    note.content = noteContentTextView.text ?? ""
                    note.modificationTime = NSDate()
                    // 2
                    RealmHelper.addNote(note)
                }
                //Updated
                listNotesTableViewController.notes = RealmHelper.retrieveNotes()
            
            }
        }
    }
}
