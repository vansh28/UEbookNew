//
//  UserInfoUpdateViewController.swift
//  UeBook
//
//  Created by Admin on 12/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class UserInfoUpdateViewController: UIViewController ,UITextFieldDelegate, UIPickerViewDelegate , UIPickerViewDataSource ,CLLocationManagerDelegate  {
    
    
    private let locationManager = LocationManager()
    var locationManager1: CLLocationManager!

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
   
    var Userimageurl :URL!
    var Username = String()
    
     var userId  = String()
    var stringActor = ["Select kind of Actor","Reader", "Writer", "Publish House","Reader and Writer"]
     var picker  = UIPickerView()
     var toolBar = UIToolbar()
    var btnVAlue = String()
    @IBOutlet weak var btnUserType: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.cornerRadius = userImage.frame.width/2
        imagePicker.delegate = self
        
        
        let Imageurl = UserDefaults.standard.string(forKey: "Save_Img_url")!
        let fullURL = kImageUploadURL + Imageurl
        let url = URL(string:fullURL)!
        self.userImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
        
        
        lblUserName.text = Username
        scrollView.contentSize = CGSize(width:view.frame.width, height: 500)
        
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!

        UserInfo_API_Method()
            locationManager1 = CLLocationManager()
            locationManager1.delegate = self
            locationManager1.desiredAccuracy = kCLLocationAccuracyBest
            locationManager1.requestAlwaysAuthorization()
            locationManager1.startUpdatingLocation()
        
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        {

            let location = locations.last! as CLLocation

            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

            var loctionValue = String()
            let geoCoder = CLGeocoder()
            

           // let location = CLLocation(latitude: l, longitude: touchCoordinate.longitude)
            geoCoder.reverseGeocodeLocation(location, completionHandler:
                {
                    placemarks, error -> Void in
                    var output = ""

                    // Place details
                    guard let placeMark = placemarks?.first else { return }
                    // Location name
//                    if let locationName = placeMark.locality {
//                        print(locationName)
//                        output = locationName
//                    }
//
//                    // Street address
//                    if let street = placeMark.thoroughfare {
//                        print(street)
//                         output = street
//                    }
//                    // City
//                    if let city = placeMark.subAdministrativeArea {
//                        print(city)
//                        output = output + city
//                    }
//                    // Zip code
//                    if let zip = placeMark.isoCountryCode {
//                        print(zip)
//                         output = output + zip
//                    }
                    // Country
//                  if let thoroughfare = placeMark.thoroughfare {
//
//                       output = thoroughfare
//                    print(thoroughfare)
//
//                  }
//                    if let subThoroughfare = placeMark.subThoroughfare {
//
//                         output = subThoroughfare
//                        print(subThoroughfare)
//
//
//                    }
//                    if let subAdministrativeArea = placeMark.subAdministrativeArea {
//
//                         output = subAdministrativeArea
//                        print(subAdministrativeArea)
//                    }
                    if let name = placeMark.name {
                      
                         output = name
                        print(name)
                        
                    }
                    if let thoroughfare = placeMark.subAdministrativeArea {
                                      
                                         output = output + "," +  thoroughfare
                                      print(thoroughfare)
                                        
                                    }
                    if let subLocality = placeMark.subLocality {
                                          
                                           output = output + "," + subLocality
                                          
                                      }
                    if let locality = placeMark.locality {
                       // print(country)
                         output = output + "," + locality
                        
                    }
                    if let country = placeMark.country {
                                        //  print(country)
                                           output = output + "," + country
                                          
                                      }
                   // address = addresses.get(0).getFeatureName()+" - "+addresses.get(0).getSubLocality()+" , "+addresses.get(0).getLocality()
                    self.lblLoction.text = output
                    
                    
                    
                  //    address = addresses.get(0).getFeatureName()+" - "+addresses.get(0).getSubLocality()+" , "+addresses.get(0).getLocality()
            })
    //                guard let exposedLocation = self.locationManager.exposedLocation else {
    //                           print("*** Error in \(#function): exposedLocation is nil")
    //                           return
    //                       }
    //
    //                       self.locationManager.getPlace(for: exposedLocation) { placemark in
    //                           guard let placemark = placemark else { return }
    //
    //                           var output = ""
    //                           if let country = placemark.country {
    //                               output = output + country
    //
    //                           }
    //                           if let state = placemark.administrativeArea {
    //                               output = output + state
    //                           }
    //                           if let town = placemark.locality {
    //                               output = output + town
    //                           }
    //
    //                        self.lblLoction.text = output
    //                       }
    //        //
          
            
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
    
    @IBAction func btnCam(_ sender: Any) {
    
    let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as! UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }


       func Edit2_Img_API_Method() {
            // ShowLoader()
            let userID = UserDefaults.standard.string(forKey: "Save_User_ID")
            
            let dictionary: NSDictionary = [
                "user_id" : userID as Any
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
                    let resposeArr = response?["user_data"] as? NSDictionary

                    
                    self.AlertVC(alertMsg:msg!)
                                if statusCode == 1 {
                                                if resposeArr == nil || resposeArr?.count == 0 {
                                                    self.AlertVC(alertMsg:"Data Not Found!")
                                                }
                                }
                                                else {
                               
                               
                                                 let imgUrlUser = resposeArr!["url"] as? String
                                             
                                    
                                    // UserDefaults.standard.set(fullNameUser, forKey: "Save_User_Name")
                                    
                                    let fullURL = kImageUploadURL + imgUrlUser!
                                    let url = URL(string:fullURL)!
                                    self.Userimageurl = url
                                    //imageView?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
                
                                   UserDefaults.standard.set(imgUrlUser, forKey: "Save_Img_url")
                                    
                                    
                                    
                              
                }
                }
                
                
            }, failure: {
                error in
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
    
    
    @IBAction func btnUpdate(_ sender: Any) {
        UserInfoUpdate_API_Method() 
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier:kUserInfoViewController ) as! UserInfoViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.valueBtn = "2"
        nextViewController.Userimageurl = Userimageurl
        nextViewController.Username = lblUserName.text!
        self.present(nextViewController, animated:true, completion:nil)
        

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
extension UserInfoUpdateViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.userImage.image = selectedImage
        self.Edit2_Img_API_Method()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


