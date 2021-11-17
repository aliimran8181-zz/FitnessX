//
//  CoreDataHandler.swift
//  FitnessX
//
//  Created by Ali on 17/11/2021.
//

import Foundation
import UIKit
import CoreData
class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    class func saveObject(fname:String,lname:String,email:String,password:String,dob:String) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        manageObject.setValue(fname, forKey: "fname")
        manageObject.setValue(lname, forKey: "lname")
        manageObject.setValue(email, forKey: "email")
        manageObject.setValue(password, forKey: "password")
        manageObject.setValue(dob, forKey: "dob")
        
        
        do {
            try context.save()
            return true
        }catch{
            return false
        }
    }
    class func fetchObject() -> [User]?{
        let context =  getContext()
        var user:[User]? = nil
        do{
            user = try context.fetch(User.fetchRequest())
            return user
        }catch{
            return user
        }
    }
}
