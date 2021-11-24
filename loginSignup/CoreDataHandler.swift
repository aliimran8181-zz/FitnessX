//
//  RegisterEmployeeManager.swift
//  loginAndSignin
//
//  Created by Sufyan Arif on 22/11/2021.
//

import Foundation
import CoreData

struct EmployeeManager
{
    private let _employeeDataRepository = EmployeeDataRepository()

    func createEmployee(employee: Employee) {
        _employeeDataRepository.create(employee: employee)
    }

    func fetchEmployee() -> [Employee]? {
        return _employeeDataRepository.getAll()
    }

    func fetchEmployee(byIdentifier id: UUID) -> Employee?
    {
        return _employeeDataRepository.get(byIdentifier: id)
    }

    func updateEmployee(employee: Employee) -> Bool {
        return _employeeDataRepository.update(employee: employee)
    }

    func deleteEmployee(id: UUID) -> Bool {
        return _employeeDataRepository.delete(id: id)
    }
}
