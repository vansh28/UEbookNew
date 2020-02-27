//
//  RegisterViewController.swift
//  UeBook
//
//  Created by Admin on 04/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController ,UITextFieldDelegate ,UIPickerViewDelegate , UIPickerViewDataSource {
   
    
   var toolBar = UIToolbar()
   var picker  = UIPickerView()
   var value:Int = 0

    var strGender = ["Select Gender","Female", "Male", "Other"] //multi-season
    var stringActor = ["Select kind of Actor","Reader", "Writer", "Publish House","Reader and Writer"]
   var activeDataArray = [String]()
    
   
    @IBOutlet weak var txtSelectKindOfActor: UITextField!
    
    @IBOutlet weak var txtSelectGender: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var txtBriefDecription: UITextField!
    
    
    @IBOutlet weak var btnGender: UIButton!
    
    @IBOutlet weak var btnKindofActor: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmail.delegate = self
        txtFullName.delegate = self
        txtPassword.delegate = self
        txtBriefDecription.delegate = self
       
        
        txtPassword.isSecureTextEntry.toggle()

        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func BtnKindOfActor(_ sender: Any) {
        
        activeDataArray = stringActor
        pickerview()
        value = 2
        //pickerview.reloadAllComponents()

    }
    
   
    @IBAction func btnGender(_ sender: Any) {
        pickerview()
        activeDataArray = strGender
        value = 1
       // pickerview.reloadAllComponents()
    }
    
    
    func pickerview()
    {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
  
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activeDataArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return(activeDataArray[row])
        
    
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(activeDataArray[row])
        
        if (value == 1)
        {
            
            txtSelectGender.text = ""
            txtSelectGender.text = activeDataArray[row]
//            btnGender.setTitle("", for: .normal)
//            btnGender.setTitle(activeDataArray[row], for: .normal)
//            btnGender.tintColor = .black
//            btnGender.contentHorizontalAlignment = .left

        }
        else if (value == 2){
           txtSelectKindOfActor.text = ""
           txtSelectKindOfActor.text = activeDataArray[row]
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
    
    if (textField == txtEmail)
    {
      
        txtEmail.textColor = UIColor.black
        

    }
        
}
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//    {
//        let newLength = textField.text!.count + string.count - range.length
//        
//        if(textField == txtPassword)
//        {
//            return newLength <= 20
//        }
//        
//        return true
//    }
    @IBAction func btnSubmit(_ sender: Any) {
        
        if self.txtFullName.text?.count == 0
        {
            AlertVC(alertMsg:"Please Enter User Name")
            
        }
        else if self.txtEmail.text?.count == 0
        {
            AlertVC(alertMsg:"Please Enter Email-ID")
            
        }
        else  if isValidEmail (testStr: txtEmail.text!) == false
        {
            
            
            txtEmail.textColor = UIColor.red
           
            AlertVC(alertMsg:"Please Enter Vaild Email-ID")
            
        }
            
            
        else if self.txtPassword.text?.count == 0
        {
            AlertVC(alertMsg:"Please Enter Password")
            
        }
        
        else{
        Register_API_Method()
        }

    }
    
func Register_API_Method() {
    
    
    let parameters: NSDictionary = [
        "user_name": txtFullName.text!,
        "password":  txtPassword.text!,
        "email":     txtEmail.text!,
        "publisher_type":txtSelectKindOfActor.text!,
        "gender":txtSelectGender.text!,
        "country":"india",
        "about_me": txtBriefDecription.text!,
        "device_type":"iOS",
        "device_token":"1234567"
        
        
     
    ]
    

    ServiceManager.POSTServerRequest(String(kCreateUser), andParameters: parameters as! [String : String], success: {response in
        print("response-------",response!)
        //self.HideLoader()
        if response is NSDictionary {
           // let statusCode = response?["error"] as? Int
            let message = response? ["message"] as? String
          //  let resposeArr = response?["response"] as? [[String: AnyObject]]
            
            let messageStr = message
            
            if (messageStr!.elementsEqual("You are successfully registered") == true)
            {
                 // self.AlertVC(alertMsg:"You are successfully registered")
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: kLoginViewController) as! LoginViewController
                self.present(nextViewController, animated:true, completion:nil)
            }
            else if (messageStr!.elementsEqual("Oops! An error occurred while registereing") == true)
            
            {
                self.AlertVC(alertMsg:"Oops! An error occurred while registereing, please retry Again")
            }
            else if(messageStr!.elementsEqual("Sorry, this user  already existed") == true){
                 self.AlertVC(alertMsg:"Sorry, this user  already existed")
            }
            
            
                
            
        }
    }, failure: { error in
        //self.HideLoader()
    })
}

func AlertVC(alertMsg:String) {
    
    let alert = UIAlertController(title: alertMsg, message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        switch action.style{
        case .default:
            print("default")
            
        case .cancel:
            print("cancel")
            
        case .destructive:
            print("destructive")
            
            
        }}))
    
    present(alert, animated: true, completion: nil)
}

func isValidEmail(testStr:String) -> Bool {
    print("validate emilId: \(testStr)")
    let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: testStr)
    return result
}

func isValidPhone(phoneNumber: String) -> Bool {
    let mobileNumberPattern = "[789][0-9]{9}"
    let mobileNumberPred = NSPredicate(format: "SELF MATCHES %@", mobileNumberPattern)
    if mobileNumberPred.evaluate(with: phoneNumber) == true {
        return true
    }
    else {
        return false
    }
    
}
    
    
    @IBAction func btnSignIn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kLoginViewController) as! LoginViewController
        nextViewController.modalPresentationStyle = .overFullScreen

        self.present(nextViewController, animated:true, completion:nil)
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
