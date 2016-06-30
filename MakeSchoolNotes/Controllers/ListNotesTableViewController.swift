//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {

    
    //At beginning, retrieveNotes() helper method returns a Results<Note> object (like an array of notes). Will add and delete Notes from this.
    //Reload all of its data whenever our notes property is changed.
    var notes: Results<Note>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = RealmHelper.retrieveNotes()
    }
    
    
    //tableView methods answer questions the table view will ask us about the data it should display
    
    //This tableView function takes in a UItableView and number of rows within the section. Function returns an int, how many cells/notes it should display (the number of notes in the notes array).
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    //This tableView function takes in a UITableView and an indexPath. The function builds a new cell, and the indexPath indicates which section and row that cell/note will go in within the entire table view.
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Fetching actual cell that will be displayed, a prototype cell named listNotesTableViewCell.
        //UITableView relies on giving us previously constructed cells for us to update with new information. If there's no recycled cells ready to be reused, dequeueReusableCellWithIdentifier(_:forIndexPath:) will give us a new one instead.
        //"as!" is a DOWNCAST. We expect dequeue to return a ListNotesTableViewCell, not just any UITableViewCell. ListNotesTableViewCell is a subclass of UITableViewCell.
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        
        //The indexPath is an argument that tells us what row/section it wants a cell for. We access the row property here.
        let row = indexPath.row
        
        //Use the row to index into our notes array to get the appropriate note object.
        let note = notes[row]
        
        //Changing the noteTitleLabel and noteModificationTimeLabel instance properties of the ListNotesTableViewCell class object.
        //Convert modificationTime of the note (which is of type NSDate) to a String
        cell.noteTitleLabel.text = note.title
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        
        return cell
    }
    
    //Function to set up work before the next view is displayed.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Storing the identifier of the segue.
        if let identifier = segue.identifier {
            //Checking to see if the "displayNote" segue was triggered.
            if identifier == "displayNote" {
                print("Table view cell tapped")
                //Access that particular cell's index path
                let indexPath = tableView.indexPathForSelectedRow!
                //Retrieve corresponding note from the notes array
                let note = notes[indexPath.row]
                //Access to Display Note View Controller (destination).
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                //Set note property of the Display Note View Controller to the note corresponding to the cell that the user tapped.
                displayNoteViewController.note = note
            }
            //Checking to see if the "addNote" segue was triggered.
            else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    
    //Enable the the table view to have additional editing modes, one of which is that the cells display the delete option when a user swipes right. The other mode is an insert mode, but that won't appear without additional configuration.
   
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //Check if edit is delete
        if editingStyle == .Delete {
            //Use the indexPath.row to index into notes to delete the correct one.
            RealmHelper.deleteNote(notes[indexPath.row])
            notes = RealmHelper.retrieveNotes()
        }
    }
    
    //Connect our Cancel and Save buttons to the unwind segue.
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
    }

}



