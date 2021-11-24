
//
//  EmployeeResource.swift
//  loginAndSignin
//
//  Created by Ali on 22/11/2021.
//

import Foundation
import CoreData

protocol EmployeeRepository {

    func create(employee: Employee)
    func getAll() -> [Employee]?
    func get(byIdentifier id: UUID) -> Employee?
    func update(employee: Employee) -> Bool
    func delete(id: UUID) -> Bool
}

struct EmployeeDataRepository : EmployeeRepository
{
    func create(employee: Employee) {

        let cdEmployee = User(context: PersistentStorage.shared.context)
        cdEmployee.email = employee.email
        cdEmployee.fname = employee.fname
        cdEmployee.lname = employee.lname
        cdEmployee.id = employee.id
        cdEmployee.dob = employee.dob
        cdEmployee.password = employee.password

        PersistentStorage.shared.saveContext()


    }

    func getAll() -> [Employee]? {

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: User.self)

        var employees : [Employee] = []

        result?.forEach({ (cdEmployee) in
            employees.append(cdEmployee.convertToEmployee())
        })

        return employees
    }

    func get(byIdentifier id: UUID) -> Employee? {

        let result = getCDEmployee(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToEmployee()
    }

    func update(employee: Employee) -> Bool {

        let cdEmployee = getCDEmployee(byIdentifier: employee.id)
        guard cdEmployee != nil else {return false}
        cdEmployee?.email = employee.email
        cdEmployee?.fname = employee.fname
        cdEmployee?.lname = employee.lname
        cdEmployee?.id = employee.id
        cdEmployee?.dob = employee.dob
        cdEmployee?.password = employee.password
       

        PersistentStorage.shared.saveContext()
        return true
    }

    func delete(id: UUID) -> Bool {

        let cdEmployee = getCDEmployee(byIdentifier: id)
        guard cdEmployee != nil else {return false}

        PersistentStorage.shared.context.delete(cdEmployee!)
        PersistentStorage.shared.saveContext()
        return true
    }


    private func getCDEmployee(byIdentifier id: UUID) -> User?
    {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

            guard result != nil else {return nil}

            return result

        } catch let error {
            debugPrint(error)
        }

        return nil
    }

    
}
