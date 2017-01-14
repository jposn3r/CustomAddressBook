//
//  Person.swift
//  CustomAddressBook
//
//  Created by Jacob Posner on 1/13/17.
//  Copyright © 2017 Kaizen Human. All rights reserved.
//

import Foundation

enum PersonValidationError : Error {
    case InvalidFirstName
    case InvalidAddress
    case InvalidPhone
    case InvalidEmail
}

class Person {
    private(set) var firstName : String!
    private(set) var lastName : String!
    private(set) var address : String!
    private(set) var phone : String!
    private(set) var email : String!
    
    init(firstName fn : String) {
        firstName = fn
    }
    
    func setFirstName(fn : String) throws {
        if (fn.characters.count < 1) {
            throw PersonValidationError.InvalidFirstName
        }
        firstName = fn
    }
    
    func setLastName(ln : String) throws {
        lastName = ln
    }
    
    func setAddress(ad : String) throws {
        let count = ad.characters.count
        if(count != 0) {
            // Should come up with a better validation.
            if(count < 3) {
                throw PersonValidationError.InvalidAddress
            }
            // Make sure there is at least a space. 
            if let _  = ad.characters.index(of: " ") {
                print("There is a space in the address")
            }
            else {
                throw PersonValidationError.InvalidAddress
            }
        }
        address = ad
    }
    
    func setPhone(pn : String) throws {
        let count = pn.characters.count
        if(count > 0 ) {
            let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
            
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            
            
        }
        
        phone = pn
    }
    
    func setEmail(em : String) throws -> Bool {
        let count = em.characters.count
        if(count > 0 ) {
            let EMAIL_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", EMAIL_REGEX)
            return emailTest.evaluate(with: em)
        }
        
        email = em
    }
    
    
    
    
    
    
    
}
