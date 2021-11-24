//
//  ForgetViewController.swift
//  FitnessX
//
//  Created by Ali on 23/11/2021.
//

import UIKit
import CoreData
class ForgetViewController: UIViewController {
    var user:[Employee]? = nil
    private let CoreDataHandler: EmployeeManager = EmployeeManager()
    @IBOutlet weak var Passwordlbl: UILabel!
    @IBOutlet weak var Labl: UILabel!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBAction func ResetBtn(_ sender: UIButton) {
        var  EmailStored = UserDefaults.standard.string(forKey: "Email");
        var  PasswordStored = UserDefaults.standard.string(forKey: "Password");
        var email = PasswordTF.text
        let user = CoreDataHandler.fetchEmployee()
        for i in user! {
            
            EmailStored = i.email
            PasswordStored = i.password
    }
        if(email == EmailStored){
            Passwordlbl.text = "Your password is: " + PasswordStored!
            self.Passwordlbl.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Passwordlbl.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
