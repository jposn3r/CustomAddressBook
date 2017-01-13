//
//  AddViewController.swift
//  CustomAddressBook
//
//  Created by Jacob Posner on 1/13/17.
//  Copyright © 2017 Kaizen Human. All rights reserved.
//

import Foundation
import UIKit

class AddViewController : UIViewController {
    
    //Checking if I set it up properly for github.
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Button Pressed Foo")
        let person = Person(firstName: nameField.text!)
        print("Created a person: \(person.firstName)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
