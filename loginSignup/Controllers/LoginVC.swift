
import UIKit

class LoginVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PassTF: UITextField!
    var user:[Employee]? = nil
    private let CoreDataHandler = EmployeeManager()
    
    //MARK: Changing textfeilds Colors
    @IBAction func LoginButtuon(_ sender: Any) {
        //Poperties
        let Email = EmailTF.text
        let passWord = PassTF.text
        
        var  EmailStored = UserDefaults.standard.string(forKey: "Email");
        var  PasswordStored = UserDefaults.standard.string(forKey: "Password");
        
        
        
        if (EmailTF.text == "" || PassTF.text == "") {
            self.popUPAleart(title: "Sign Up", message: "Please Enter Email and Password", actionTitle: ["Okay"], actionStyles: [.default], action: [
                { Okay in
                    print("okay is pressd")
                },
            ])
        }
        
        
        
        
        // MARK: -Fetch Data from CoreData
        
        let user = CoreDataHandler.fetchEmployee()
        for i in user! {
           
            print("\(i.email)")
            print("\(i.password)")
          
            EmailStored = i.email
            PasswordStored = i.password
        }
        
        // MARK: -login Comperison
        
        if EmailStored == Email && PasswordStored == passWord{
                // Login is Successful & Error
                UserDefaults.standard.set(true,forKey:"isUserLoggedIn")
                UserDefaults.standard.synchronize()
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "dashboardController") as! UIViewController
            
         }else {
            displayMyAlertMessage(userMessage: "Login failed")
            print("Login failed")

        }
       
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
