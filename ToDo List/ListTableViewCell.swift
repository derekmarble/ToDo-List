//
//  ListTableViewCell.swift
//  ToDo List
//
//  Created by Derek Marble on 2/26/22.
//

import UIKit

protocol ListTableViewCellDelegate: class {
    func checkBoxToggle(sender: ListTableViewCell)
        
    
}

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: ListTableViewCellDelegate?
    
    var toToItem: ToDoItem! {
        didSet {
            nameLabel.text = toToItem.name
            checkBoxButton.isSelected = toToItem.completed
        }
    }
    
    @IBAction func checkToggled(_ sender: UIButton) {
        delegate?.checkBoxToggle(sender: self)
    }
}
