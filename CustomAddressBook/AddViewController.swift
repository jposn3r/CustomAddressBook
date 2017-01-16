//
//  AddViewController.swift
//  CustomAddressBook
//
//  Created by Jacob Posner on 1/13/17.
//  Copyright © 2017 Kaizen Human. All rights reserved.
//

import Foundation
import UIKit

class AddViewController : UIViewController, UITextFieldDelegate  {
    
    //Checking if I set it up properly for github.
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Button Pressed Foo")
        
        if let person = Person(firstName: nameField.text!) {
            print("Created a person: \(person.firstName)")
            self.navigationController?.popViewController(animated: true)
        } else {
            print("Error creating Person")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}
