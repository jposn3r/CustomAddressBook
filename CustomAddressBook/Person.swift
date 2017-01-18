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

class Person : NSObject, NSCoding {
    private(set) var firstName : String!
    private(set) var lastName : String!
    private(set) var address : String!
    private(set) var phone : String!
    private(set) var email : String!
    
    init?(firstName fn : String) {
        //firstName = fn
        super.init()
            do {
                try setFirstName(fn: fn)
            } catch {
                return nil
            }
    }
    
    required init?(coder aDecoder : NSCoder) {
        if let s = aDecoder.decodeObject(forKey: "firstName") as? String {
            firstName = s
        }
        if let s = aDecoder.decodeObject(forKey: "lastName") as? String {
            lastName = s
        }
        if let s = aDecoder.decodeObject(forKey: "phone") as? String {
            phone = s
        }
        if let s = aDecoder.decodeObject(forKey: "email") as? String {
            email = s
        }
        if let s = aDecoder.decodeObject(forKey: "address") as? String {
            address = s
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(address, forKey: "address")

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
            let result = phoneTest.evaluate(with: pn)
            
            if (!result) {
                throw PersonValidationError.InvalidPhone
            }
            
        }
        
        phone = pn
    }
    
    func setEmail(em : String) throws {
        let count = em.characters.count
        if(count > 0 ) {
            let EMAIL_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", EMAIL_REGEX)
            let result = emailTest.evaluate(with: em)
            
            if (!result) {
                throw PersonValidationError.InvalidEmail
            }
        }
        
        email = em
        
    }
    
    
    
    
    
    
    
}
