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
    
    var person: Person?
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Button Pressed Foo")
        
        if person == nil {
            if let p = Person(firstName: nameField.text!) {
                person = p
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.contacts.append(person!)
                
                
            } else {
                let alert = UIAlertController(title: "Error", message: "Error creating contact", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
        }
        
        do {
            try person!.setFirstName(fn: nameField.text!)
            try person!.setLastName(ln: lastNameField.text!)
            try person!.setEmail(em: emailField.text!)
            try person!.setPhone(pn: phoneField.text!)
            try person!.setAddress(ad: addressField.text!)
            
        } catch let error as PersonValidationError {
            var errorMessage = ""
            
            switch(error) {
            case .InvalidFirstName:
                errorMessage = "Invalid First Name"
            case .InvalidPhone:
                errorMessage = "Invalid Phone Number"
            case .InvalidEmail:
                errorMessage = "Invalid Email Address"
            case .InvalidAddress:
                errorMessage = "Invalid Street Address"
            }
            
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } catch {
            
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.storeContacts()
        
        self.navigationController?.popViewController(animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if let person = person {
            nameField.text = person.firstName
            lastNameField.text = person.lastName
            phoneField.text = person.phone
            emailField.text = person.email
            addressField.text = person.address
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}
