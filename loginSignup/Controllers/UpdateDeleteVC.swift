//
//  UpdateDeleteVC.swift
//  FitnessX
//
//  Created by Ali on 23/11/2021.
//

import UIKit
import CoreData

class UpdateDeleteVC: UIViewController {
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var lastTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    var selectedEmployee: Employee? = nil
    var user:[Employee]? = nil
    private let CoreDataHandler: EmployeeManager = EmployeeManager()
    
    @IBOutlet weak var DateTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillSetUp()

    }
    

    func isValidEmail(emailID:String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
       let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailTest.evaluate(with: emailID)
   }
    @IBAction func UpdateButton(_ sender: Any) {
        let Email = EmailTF.text
        let employee = Employee(fname: self.firstTF.text, lname:self.lastTF.text, email: self.EmailTF.text, id: selectedEmployee!.id)
        var  EmailStored = UserDefaults.standard.string(forKey: "Email");
        
        user = CoreDataHandler.fetchEmployee()
        for i in user! {
            
            EmailStored = i.email
        }
        if (EmailStored == Email){
            displayMyAlertMessage(userMessage: "Email has already Registered")
        }
        guard let email = EmailTF.text, EmailTF.text?.count != 0  else {
                    return
                }
                if isValidEmail(emailID: email) == false {
                   displayMyAlertMessage(userMessage: "Please Enter a valid Email")// vaild email calling
                }
        self.popUPAleart(title: "Update", message: "Are you sure?", actionTitle: ["Okay", "Cancel"], actionStyles: [.default, .cancel], action: [
            { [self] Okay in
                self.CoreDataHandler.updateEmployee(employee: employee)
            }
            ,
            {
                Cancel in
                    print("Cancel is pressd")
            }
        ])
        
    }
    
    @IBAction func DeleteButton(_ sender: UIButton) {
        self.popUPAleart(title: "Delete", message: "Are you sure?", actionTitle: ["Okay", "Cancel"], actionStyles: [.default, .cancel], action: [
            { Okay in
                self.CoreDataHandler.deleteEmployee(id: self.selectedEmployee!.id)
            },{ Cancel in
                print("Cancel is pressd")
            }
        ])
    }
    
    let datePicker = UIDatePicker()
    func showDatePicker(){
       //Formate Date
       datePicker.datePickerMode = .date
        

      //ToolBar
      let toolbar = UIToolbar();
      toolbar.sizeToFit()
      let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
     let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

     DateTF.inputAccessoryView = toolbar
     DateTF.inputView = datePicker
     datePicker.preferredDatePickerStyle = .wheels

    }
    
    @objc func donedatePicker(){
        // Formatting the date picker
       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       DateTF.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }
        // Cancel button
        // self.view.endEditing(true) it ends editing
     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            
            
        })
        myAlert.addAction(okAction)
        self.present(myAlert,animated: true,completion: nil)
    }
    func viewWillSetUp()
    {
        self.firstTF.text = selectedEmployee?.fname
        self.lastTF.text = selectedEmployee?.lname
        self.DateTF.text = selectedEmployee?.dob
        self.EmailTF.text = selectedEmployee?.email
    }
    func popUPAleart(
        title:String,
        message:String,
        actionTitle:[String],
        actionStyles:[UIAlertAction.Style],
        action:[((UIAlertAction) -> Void)]){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for(index,title) in actionTitle.enumerated(){
                let action = UIAlertAction(title: title, style: actionStyles[index], handler: action[index])
                alert.addAction(action)
            }
            self.present(alert, animated: true, completion: nil)
    }
}
