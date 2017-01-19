//
//  CustomAddressBookTests.swift
//  CustomAddressBookTests
//
//  Created by Jacob Posner on 1/13/17.
//  Copyright © 2017 Kaizen Human. All rights reserved.
//

import XCTest
@testable import CustomAddressBook

class CustomAddressBookTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPersonValidation() {
        let p = Person(firstName : "Jimbo")
        XCTAssert(p != nil)
        do {
            try p?.setLastName(ln: "Rey")
            try p?.setEmail(em: "Bob@Bob.com")
            try p?.setPhone(pn: "516-578-4028")
            try p?.setAddress(ad: "3274 Balsam Street Oceanside NY")
        } catch {
            XCTFail("Validation failed")
        }
    }
    
    func testPersonValidationFailures() {
        let p = Person(firstName : "Jimbo")
        XCTAssert(p != nil)
        do {
            try p?.setEmail(em: "email")
            XCTFail("Email validation failed")
        } catch {
            
        }
        do {
            try p?.setPhone(pn: "516")
            XCTFail("Phone validation failed")
        } catch {
            
        }
        do {
            try p?.setAddress(ad: "J")
            XCTFail("Address validation failed")
        } catch {
            
        }
        do {
            try p?.setFirstName(fn: "")
            XCTFail("First name validation failed")
        } catch {
            
        }
        

    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
