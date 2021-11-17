
import UIKit

class LoginVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PassTF: UITextField!
    
    
    var user:[User]? = nil
    
    //MARK: Changing textfeilds Colors
    @IBAction func LoginButtuon(_ sender: Any) {
        let Email = EmailTF.text
        let Password =  PassTF.text
        
        // from userdefault
        var  EmailStored = UserDefaults.standard.string(forKey: "Email");
        var  PasswordStored = UserDefaults.standard.string(forKey: "Password");
        // from coredata
        
        user = CoreDataHandler.fetchObject()
        for i in user! {
            /* Don't deleted commented code , cause it's a efficient way - starts here */
            //  print("\(i.fname!),\(i.lname!),\(i.email!), \(i.password!),\(i.confirmPassword!),\(i.gender!),\(i.phoneType!),\(i.dob!)")
            /* Don't deleted commented code , cause it's a efficient way - ends here */
            print("\(i.fname!)")
            print("\(i.lname!)")
            print("\(i.email!)")
            print("\(i.dob!)")
            
            EmailStored = i.email
            PasswordStored = i.password
        }
        guard let email = EmailTF.text, EmailTF.text?.count != 0  else {
                    return
                }
                if isValidEmail(emailID: email) == false {
                   displayMyAlertMessage(userMessage: "Please Enter a valid Email")// vaild email calling
                }
        if EmailStored == Email && PasswordStored == Password
        {
                // Login is Successful & Error
UserDefaults.standard.set(true,forKey:"isUserLoggedIn")
                UserDefaults.standard.synchronize()
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "dashboardController") as! UIViewController
         }else {
            displayMyAlertMessage(userMessage: "Login failed")
            print("Login failed")

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
       
    }
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
      
        })
        myAlert.addAction(okAction)
        self.present(myAlert,animated: true,completion: nil)
    }
    
}
