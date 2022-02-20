//
//  ToDoDetailTableViewController.swift
//  ToDo List
//
//  Created by Derek Marble on 2/20/22.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteView: UITextView!
    
    var toDoItem: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = toDoItem
        
        if toDoItem == nil {
            toDoItem =  ""
        }

 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = nameField.text
        
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
