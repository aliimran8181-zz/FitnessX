
import UIKit

class LoginVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblValidationMessage: UILabel!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PassTF: UITextField!
    
    
    //MARK: Changing textfeilds Colors
    @IBAction func LoginButtuon(_ sender: Any) {
        if PassTF.text == "" {
            let myColor : UIColor = UIColor.red
            PassTF.layer.borderWidth = 2.0
              PassTF.layer.borderColor = myColor.cgColor
        }
        else{
            let myColor : UIColor = UIColor.white
            PassTF.layer.borderWidth = 2.0
              PassTF.layer.borderColor = myColor.cgColor
        }
        if EmailTF.text == ""{
            let myColor : UIColor = UIColor.red
            EmailTF.layer.borderWidth = 2.0
            EmailTF.layer.borderColor = myColor.cgColor
        }
        else{
            let myColor : UIColor = UIColor.white
            EmailTF.layer.borderWidth = 2.0
            EmailTF.layer.borderColor = myColor.cgColor
        }
        guard let email = EmailTF.text, EmailTF.text?.count != 0  else {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter your email"
            return
        }
        if isValidEmail(emailID: email) == false {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter valid email address" // Calling Valid Email 
        }
        else {
            lblValidationMessage.isHidden = true
        }
        
       
        
    }
    //MARK: Email Verification
    func isValidEmail(emailID:String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
       let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailTest.evaluate(with: emailID) // Vaild Email Script
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblValidationMessage.isHidden = true
       
    }

    
}
