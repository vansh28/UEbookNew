//
//  UserInfoUpdateViewController.swift
//  UeBook
//
//  Created by Admin on 12/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class UserInfoUpdateViewController: UIViewController ,UITextFieldDelegate, UIPickerViewDelegate , UIPickerViewDataSource   {
    
    
    
    @IBOutlet weak var userImage: UIImageView!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLoction: UILabel!
  
    @IBOutlet weak var txtChangeUserName: UITextField!
    
    @IBOutlet weak var lblChangeUserName: UILabel!
    
    
    @IBOutlet weak var txtBookDes: UITextField!
    
    @IBOutlet weak var lblBookDes: UILabel!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lblUpdateEmail: UILabel!
    @IBOutlet weak var txtUpdateEmail: UITextField!
    
    
    
    @IBOutlet weak var txtUpdateCountry: UITextField!
    
    @IBOutlet weak var lblUpdateCountry: UILabel!
     var userId  = String()
    var stringActor = ["Select kind of Actor","Reader", "Writer", "Publish House","Reader and Writer"]
     var picker  = UIPickerView()
     var toolBar = UIToolbar()
    var btnVAlue = String()
    @IBOutlet weak var btnUserType: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width:view.frame.width, height: 500)
        
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!

        UserInfo_API_Method()
        
        txtChangeUserName.delegate = self
              txtChangeUserName.placeholder="Change Username"
              lblChangeUserName.isHidden = true
              txtChangeUserName.layer.cornerRadius = 5
              txtChangeUserName.layer.borderWidth = 1.0
              txtChangeUserName.layer.borderColor = UIColor.gray.cgColor
              txtChangeUserName.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    
        txtBookDes.placeholder="Brief Description"
        lblBookDes.isHidden = true
        txtBookDes.delegate = self
        txtBookDes.layer.cornerRadius = 5
        txtBookDes.layer.borderWidth = 1.0
        txtBookDes.layer.borderColor = UIColor.gray.cgColor
        txtBookDes.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
        txtUpdateEmail.delegate = self
        txtUpdateEmail.placeholder="Update Email"
        lblUpdateEmail.isHidden = true
        txtUpdateEmail.layer.cornerRadius = 5
        txtUpdateEmail.layer.borderWidth = 1.0
        txtUpdateEmail.layer.borderColor = UIColor.gray.cgColor
        txtUpdateEmail.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        txtUpdateCountry.delegate = self
        txtUpdateCountry.placeholder="Update Country"
        lblUpdateCountry.isHidden = true
        txtUpdateCountry.layer.cornerRadius = 5
        txtUpdateCountry.layer.borderWidth = 1.0
        txtUpdateCountry.layer.borderColor = UIColor.gray.cgColor
        txtUpdateCountry.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
               
      
        btnUserType.layer.cornerRadius = 5
        btnUserType.layer.borderColor = UIColor.gray.cgColor
        btnUserType.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
                //activeDataArray = []
                
                
                   let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
                
                if(textField == txtChangeUserName)
                {
                    txtChangeUserName.placeholder = ""
                    self.lblChangeUserName.isHidden=false
                    
                 
                    txtChangeUserName.layer.borderColor = myColor.cgColor
                    
                    txtChangeUserName.layer.borderWidth = 2.0
                    
                }
                else if(textField == txtBookDes)
                {
                    txtBookDes.placeholder = ""
                    self.lblBookDes.isHidden=false
                    
                   
                    txtBookDes.layer.borderColor = myColor.cgColor
                    
                    txtBookDes.layer.borderWidth = 2.0
                    
                }
                else if(textField == txtUpdateEmail)
                {
                    txtUpdateEmail.placeholder = ""
                    self.lblUpdateEmail.isHidden=false
                    
                  
                    txtUpdateEmail.layer.borderColor = myColor.cgColor
                    
                    txtUpdateEmail.layer.borderWidth = 2.0
                    
                }
        else if(textField == txtUpdateCountry)
        {
            txtUpdateCountry.placeholder = ""
            self.lblUpdateCountry.isHidden=false
            
          
            txtUpdateCountry.layer.borderColor = myColor.cgColor
            
            txtUpdateCountry.layer.borderWidth = 2.0
            
        }
        
     
   
    }
            
            
            func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
                let myColor = UIColor.black

                if(textField == txtChangeUserName)
                {
                    let myColor = UIColor.black
                    txtChangeUserName.layer.borderColor = myColor.cgColor
                    
                    txtChangeUserName.layer.borderWidth = 1.0
                    
                    if self.txtChangeUserName.text?.count == 0
                    {
                        txtChangeUserName.placeholder="Change Username"
                        self.lblChangeUserName.isHidden = true
                    }
                }
                   
                      
                    
                    
                    
                    
                  else  if(textField == txtUpdateCountry)
                               {
                                   txtUpdateCountry.layer.borderColor = myColor.cgColor
                                   
                                   txtUpdateCountry.layer.borderWidth = 1.0
                                   
                                   if self.txtUpdateCountry.text?.count == 0
                                   {
                                       txtUpdateCountry.placeholder="Update Country"
                                       self.lblUpdateCountry.isHidden = true
                                   }
                               }
                    
                    
                else if(textField == txtUpdateEmail)
                {
                    
                    txtUpdateEmail.layer.borderColor = myColor.cgColor
                    
                    txtUpdateEmail.layer.borderWidth = 1.0
                    if self.txtUpdateEmail.text?.count == 0
                    {
                        txtUpdateEmail.placeholder="Update Email"
                        self.lblUpdateEmail.isHidden = true
                    }
                }
                else if(textField == txtBookDes)
                {
                    
                    let myColor = UIColor.black
                    txtBookDes.layer.borderColor = myColor.cgColor
                    
                    txtBookDes.layer.borderWidth = 1.0
                    if self.txtBookDes.text?.count == 0
                    {
                        txtBookDes.placeholder="Brief Description"
                        self.lblBookDes.isHidden = true
                    }
                }
                
                
                
                return true
                
            }
    

    @IBAction func btnUserType(_ sender: Any) {
         pickerview()
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
            return stringActor.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return(stringActor[row])
            
        
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            print(stringActor[row])
            
            btnUserType.setTitle("", for: .normal)
            
                btnUserType.setTitle(stringActor[row], for: .normal)
              btnVAlue = stringActor[row]
             
        
        }
    
    @IBAction func btnCeamra(_ sender: Any) {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
                self.openGallary()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = sender as? UIView
                alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
            }
            
            self.present(alert, animated: true, completion: nil)
        }
        //MARK: - Open the camera
        func openCamera(){
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                //If you dont want to edit the photo then you can set allowsEditing to false
                imagePicker.allowsEditing = true
                //imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        //MARK: - Choose image from camera roll
        
        func openGallary(){
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
        //    imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }

        func Edit_Img_API_Method() {
            // ShowLoader()
            let userID = UserDefaults.standard.string(forKey: "Save_User_ID")
            
            let dictionary: NSDictionary = [
                "user_id" : userID
            ]
            
            
            
            let kBaseUrl                           = "http://dnddemo.com/ebooks/api/v1/"
            let kPostUserImage                          = kBaseUrl + "UpdatePrfilePic"
            
            
            
            
            ServiceManager.POSTServerRequestWithImage(kPostUserImage, andParameters: dictionary as! [String : String], andImage: userImage.image! , imagePara: "profile_image", success: {response in
                //
                
                
                
                //self.HideLoader()
                print("response-------",response!)
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let msg = response?["message"] as? String
                    
                  
                    let img = response?["url"] as? String
                    
                    
                    
                    let kProfileImageUploadURL = "http://dnddemo.com/ebooks/api/v1/upload/"
                    
                    
                    if statusCode == 0
                    {
                     
                        let fullURL = kProfileImageUploadURL + img!
                        
                        
                       let downloadURL = NSURL(string: fullURL)
                        
                    
                        //}
                        UserDefaults.standard.set(fullURL, forKey: "Save_User_Img")
                        //self.Update_Profile_API_Method()
                    }
                    
                    
                   
               
                    
                    
                    if statusCode == 1 {
                        //self.AlertVC(alertMsg:msg!)
                    }
                    //            else if statusCode == 0 {
                    //                AJAlertController.initialization().showAlertWithOkButton(aStrMessage: msg!) { (index, title) in
                    //                    if index == 0 {
                    //                        let vc = self.storyboard?.instantiateViewController(withIdentifier: kHomeViewController) as! HomeViewController
                    //                        self.navigationController?.pushViewController(vc, animated: true)
                    //                    }
                    //                }
                    //            }
                }
            }, failure: {
                error in
                //self.HideLoader()
            })
        }
        

    
    
    @IBAction func btnUpdate(_ sender: Any) {
        UserInfoUpdate_API_Method() 
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    func UserInfo_API_Method() {
    
    
    let parameters: NSDictionary = [
       "user_id": userId
      ]
    

    ServiceManager.POSTServerRequest(String(kgetUserInfo), andParameters: parameters as! [String : String], success: {response in
        print("response-------",response!)
        //self.HideLoader()
        if response is NSDictionary {
           // let statusCode = response?["error"] as? Int
            
            let UserDetail = response?["response"] as? NSDictionary

            
            
            
            if UserDetail == nil || UserDetail?.count == 0 {
                }
            else {
                let objUserDetails = AllgetUserInfo(getAllUserInfo : UserDetail!)
                
                self.lblUserName.text = objUserDetails.user_name
              
                if objUserDetails.email == nil
                {
                    //self.txtUpdateEmail.text = ""
                }
                else{
                    self.txtUpdateEmail.text = objUserDetails.email
                }
                  if objUserDetails.user_name == nil
                              {
                                  //self.txtChangeUserName.text = ""
                              }
                              else{
                               self.txtChangeUserName.text = objUserDetails.user_name

                              }
                
                                   
                                           
                                   
            }
        }
            
        
                           }, failure: { error in
                               //self.HideLoader()
                           })

                               
        }
    



func UserInfoUpdate_API_Method() {
    
    
    let parameters: NSDictionary = [
       "user_id": userId,
       "password ": " ",
       "email" :  txtUpdateEmail.text as Any,
       "publisher_type" : btnVAlue,
       "country": txtUpdateCountry.text as Any,
       "about_me": txtBookDes.text as Any
      ]
    
    
    

    ServiceManager.POSTServerRequest(String(kuserEdit), andParameters: parameters as! [String : String], success: {response in
        print("response-------",response!)
        //self.HideLoader()
        if response is NSDictionary {
           // let statusCode = response?["error"] as? Int
            
            let UserDetail = response?["response"] as? NSDictionary

            
            
            
            if UserDetail == nil || UserDetail?.count == 0 {
                }
            else {
                let objUserDetails = AllgetUserInfo(getAllUserInfo : UserDetail!)
                
                self.lblUserName.text = objUserDetails.user_name
              
                if objUserDetails.email == nil
                {
                    //self.txtUpdateEmail.text = ""
                }
                else{
                    self.txtUpdateEmail.text = objUserDetails.email
                }
                  if objUserDetails.user_name == nil
                              {
                                  //self.txtChangeUserName.text = ""
                              }
                              else{
                               self.txtUpdateEmail.text = objUserDetails.user_name

                              }
                
                                   
                                           
                                   
            }
        }
            
        
                           }, failure: { error in
                               //self.HideLoader()
                           })

                               
        }
    
}
//MARK: - UIImagePickerControllerDelegate

//extension UserInfoUpdateViewController: UIImagePickerControllerDelegate {
//
//    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.pickerController(picker, didSelect: nil)
//    }
//
//    public func imagePickerController(_ picker: UIImagePickerController,
//                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        guard let image = info[.editedImage] as? UIImage else {
//            return self.pickerController(picker, didSelect: nil)
//        }
//        self.pickerController(picker, didSelect: image)
//    }
//}
//
//extension UserInfoUpdateViewController: UINavigationControllerDelegate {
//
//}
//
//
//extension UserInfoUpdateViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
//            self.userImage.image = editedImage
//        }
//       picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.isNavigationBarHidden = false
//        self.dismiss(animated: true, completion: nil)
//    }
//}
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


