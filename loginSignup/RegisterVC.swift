import UIKit

class RegisterVC: UIViewController{
    
   
    //MARK: IBOutlets
    @IBOutlet weak var lblValidationMessage: UILabel!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var FirstTF: UITextField!
    @IBOutlet weak var LastTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PassTF: UITextField!
    @IBOutlet weak var CPassTF: UITextField!
    @IBOutlet weak var DOB: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var agreeBtn: UIButton!
    
    
    // MARK: Varibales
    var isSelected:Bool = true

    
    
    
    /* //MARK: Date Picker addition to Date of birth text field
        i am using date picker method on a text field
        using two buttons Done and cancel
        to add space in the buttons i've used a space button which does nothing
        
     */
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

     DOB.inputAccessoryView = toolbar
     DOB.inputView = datePicker
     datePicker.preferredDatePickerStyle = .wheels

    }
    
    @objc func donedatePicker(){
        // Formatting the date picker
       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       DOB.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }
        // Cancel button
        // self.view.endEditing(true) it ends editing
     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    
    //MARK: Valid Email script
    func isValidEmail(emailID:String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
       let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailTest.evaluate(with: emailID)
   }
    
    /* //MARK: Agree Button selection
     if the is selected = true image will be set to markcheck
     otherwise it will be set to markuncheck
     */
    @IBAction func agreeBtnTapped(_ sender: Any) {
        isSelected = !isSelected
            if isSelected  {
                agreeBtn.setImage(UIImage(named: "markCheck.png"), for: .normal)
            } else {
                agreeBtn.setImage(UIImage(named: "markUncheck.png"), for: .normal)
            }
    }
   
    @IBAction func ctnButton(_ sender: Any) {
    
        /* //MARK: Changing the color red & Validations
            i've changed the color of the text feild by using the property bordercolor
            and i've changed the border width to 2.0 for it to be visible
        */
        
        if FirstTF.text == ""{
            let myColor : UIColor = UIColor.red
            FirstTF.layer.borderWidth = 2.0
              FirstTF.layer.borderColor = myColor.cgColor // Changing the color of the borders of the text feilds
        }
        else{
            let myColor : UIColor = UIColor.white
            FirstTF.layer.borderWidth = 2.0
              FirstTF.layer.borderColor = myColor.cgColor
        }
        if LastTF.text == ""{
            let myColor : UIColor = UIColor.red
            LastTF.layer.borderWidth = 2.0
            LastTF.layer.borderColor = myColor.cgColor
        }
        else{
            let myColor : UIColor = UIColor.white
            LastTF.layer.borderWidth = 2.0
            LastTF.layer.borderColor = myColor.cgColor
        }
        if PassTF.text == ""{
            let myColor : UIColor = UIColor.red
            PassTF.layer.borderWidth = 2.0
              PassTF.layer.borderColor = myColor.cgColor
        }
        else{
            let myColor : UIColor = UIColor.white
            PassTF.layer.borderWidth = 2.0
              PassTF.layer.borderColor = myColor.cgColor
        }
        if CPassTF.text == ""{
            let myColor : UIColor = UIColor.red
            CPassTF.layer.borderWidth = 2.0
            CPassTF.layer.borderColor = myColor.cgColor
        }
        else{
            let myColor : UIColor = UIColor.white
            CPassTF.layer.borderWidth = 2.0
            CPassTF.layer.borderColor = myColor.cgColor
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
        lblValidationMessage.isHidden = true
        guard let email = EmailTF.text, EmailTF.text?.count != 0  else {
            return
        }
        if isValidEmail(emailID: email) == false {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter valid email address" // vaild email calling
        }
   
      
    }
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        showDatePicker()
        lblValidationMessage.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.backgroundTap))
        self.ContentView.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /*
    // MARK: - Navigation of the keyboard 

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        
        ScrollView.contentInset = contentInsets
        ScrollView.scrollIndicatorInsets = contentInsets
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        ScrollView.contentInset = contentInsets
        ScrollView.scrollIndicatorInsets = contentInsets
        
    
       
}
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
    // go through all of the textfield inside the view, and end editing thus resigning first responder
    // it will trigger a keyboardWillHide notification
    self.view.endEditing(true)
}
    
}
