//
//  User+CoreDataProperties.swift
//  
//
//  Created by Ali on 24/11/2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var dob: String?
    @NSManaged public var email: String?
    @NSManaged public var fname: String?
    @NSManaged public var lname: String?
    @NSManaged public var password: String?
    @NSManaged public var id: UUID?
    
    
    func convertToEmployee() -> Employee{
        return Employee(fname: self.fname, lname: self.lname, email: self.email, dob: self.dob, password: self.password, id: self.id!)
    }
}

