//
//  EditProfileViewController.swift
//  UeBook
//
//  Created by Admin on 10/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class EditProfileViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate ,CLLocationManagerDelegate{
    
    
    
    
    
    private let locationManager = LocationManager()

    var locationManager1: CLLocationManager!
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    class func instance()->UIViewController{
        let colorController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kEditProfileViewController)
        let nav = UINavigationController(rootViewController: colorController)
        nav.navigationBar.isTranslucent = false
        return nav
    }
    
    var valueRow  = String()
    var globelImageArr :[UIImage] = []
    var globelArr : [String] = []
    var arrayGallerySingle : [UIImage] = [#imageLiteral(resourceName: "userinfo"),#imageLiteral(resourceName: "companyinfo"),#imageLiteral(resourceName: "addbook"),#imageLiteral(resourceName: "chat_icon"),#imageLiteral(resourceName: "chat_icon"),#imageLiteral(resourceName: "addbook"),#imageLiteral(resourceName: "dict"),#imageLiteral(resourceName: "logout")]
    
    var vbPlayerName : [String] = ["User Info","Company ","Upload Book","Chat with Others","Pending Request ","Pending Book","Dictonary","Logout"]
    
    var CompanyInfoImageArr : [UIImage] = [#imageLiteral(resourceName: "languges"),#imageLiteral(resourceName: "share"),#imageLiteral(resourceName: "helpcenter"),#imageLiteral(resourceName: "about"),#imageLiteral(resourceName: "contactus")]
    var CompanyInfoArr : [String] = ["Interface Language","Share us to friend ","Help Center","About Us","Contact Us"]
    var Imageurl = String()
    @IBOutlet weak var tableView: UITableView!
    var Userimageurl :URL!
    
    @IBOutlet weak var lblLoction: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imageView.addGestureRecognizer(tap)
        self.imageView.isUserInteractionEnabled = true
  
        
        imageView.layer.cornerRadius = imageView.frame.width/2
        self.navigationHide()
        valueRow = "1"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        globelImageArr = arrayGallerySingle
        globelArr  = vbPlayerName
        
        btnBack.isHidden = true
        
        Imageurl = UserDefaults.standard.string(forKey: "Save_Img_url")!
        lblUserName.text = UserDefaults.standard.string(forKey: "Save_User_Name")!
        // UserDefaults.standard.set(fullNameUser, forKey: "Save_User_Name")
        
        let fullURL = kImageUploadURL + Imageurl
        let url = URL(string:fullURL)!
        Userimageurl = url
        imageView?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
        
        
       
            locationManager1 = CLLocationManager()
            locationManager1.delegate = self
            locationManager1.desiredAccuracy = kCLLocationAccuracyBest
            locationManager1.requestAlwaysAuthorization()
            locationManager1.startUpdatingLocation()
        
//        guard let exposedLocation = self.locationManager.exposedLocation else {
//                            print("*** Error in \(#function): exposedLocation is nil")
//                            return
//                        }
//
//                        self.locationManager.getPlace(for: exposedLocation) { placemark in
//                            guard let placemark = placemark else { return }
//
//                            var output = "Our location is:"
//                            if let country = placemark.country {
//                                output = output + "\n\(country)"
//
//                            }
//                            if let state = placemark.administrativeArea {
//                                output = output + "\n\(state)"
//                            }
//                            if let town = placemark.locality {
//                                output = output + "\n\(town)"
//                            }
//         self.lblLoction.text = output
//
//                        }
        
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
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier:kImageZoomInZoomOutViewController ) as! ImageZoomInZoomOutViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.imageurl = Userimageurl
        nextViewController.name = lblUserName.text!
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func btnBack(_ sender: Any) {
        valueRow = "1"
        globelImageArr = arrayGallerySingle
        globelArr  = vbPlayerName
        tableView.reloadData()
        btnBack.isHidden = true
        
    }
    
    @IBAction func btnCamera(_ sender: Any) {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globelImageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EdiProfileCell") as? EditUserProfileTableViewCell
        
        
        let image = globelImageArr[indexPath.row]
        cell?.imgView.image = image
        
        cell?.lblEntyName.text = globelArr[indexPath.row]
        cell?.btnArrow.setImage(#imageLiteral(resourceName: "rightarrow"), for: .normal)
        
        cell?.btnArrow.tag = indexPath.row
        
        cell?.btnArrow.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)
        
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(valueRow == "1")
        {
             //valueRow = "2"
            if indexPath.row == 0
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier:kUserInfoViewController ) as! UserInfoViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                nextViewController.valueBtn = "2"
                nextViewController.Userimageurl = Userimageurl
                nextViewController.Username = lblUserName.text!
                self.present(nextViewController, animated:true, completion:nil)
            }
                
            else if indexPath.row == 1
            {
               // valueRow = "2"
                globelImageArr = CompanyInfoImageArr
                globelArr = CompanyInfoArr
                tableView.reloadData()
                btnBack.isHidden = false
            }
            else if indexPath.row == 2
            {
              //  valueRow = "2"
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier:kUploadBookViewController ) as! UploadBookViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                
                self.present(nextViewController, animated:true, completion:nil)
            }
            else if indexPath.row == 3
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier:kcontactListViewController ) as! contactListViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                
                self.present(nextViewController, animated:true, completion:nil)
            }
            else if indexPath.row == 4
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier:kPendingRequestViewController ) as! PendingRequestViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                
                self.present(nextViewController, animated:true, completion:nil)
               
            }
            else if indexPath.row == 5
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                               let nextViewController = storyBoard.instantiateViewController(withIdentifier:kpendingBookViewController ) as! pendingBookViewController
                               nextViewController.modalPresentationStyle = .overFullScreen
                               
                               self.present(nextViewController, animated:true, completion:nil)
            }
            else  if indexPath.row == 6
            {
                
            }
            else  if indexPath.row == 7
            {
                let defaults = UserDefaults.standard
                                                      defaults.set(false, forKey: "isUserLoggedIn")
                                                      defaults.synchronize()

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: kFirstPageViewController) as! FirstPageViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
        else if (valueRow == "2")
        {
            //valueRow = "1"
            if (indexPath.row == 1)
            {
                
                let textToShareValue = "This is UeBook app"
                // let youtuber = textToShareValue
                
                let textToShare = textToShareValue
                
                if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
                    let objectsToShare: [Any] = [textToShare, myWebsite]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    
                    // activityVC.popoverPresentationController?.sourceView = indexPath.row
                    self.present(activityVC, animated: true, completion: nil)
                }
                
            }
            if (indexPath.row == 2)
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: kHelpUSViewController) as! HelpUSViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                
                self.present(nextViewController, animated:true, completion:nil)
            }
            if (indexPath.row == 4)
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: kContactUSViewController) as! ContactUSViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
        
    }
    func Edit_Img_API_Methods() {
        // ShowLoader()
        let userID = UserDefaults.standard.string(forKey: "Save_User_ID")
        
        let dictionary: NSDictionary = [
            "user_id" : userID as Any
        ]
        
        
        
        
        
        ServiceManager.POSTServerRequestWithImage(kUpdatePrfilePic, andParameters: dictionary as! [String : String], andImage: imageView.image! , imagePara: "profile_image", success: {response in
          
            
            
            
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
    
    @objc func subscribeTapped(_ sender: UIButton){
        
        
        if(valueRow == "1")
        {
            if (sender.tag == 0)
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier:kUserInfoViewController ) as! UserInfoViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                
                self.present(nextViewController, animated:true, completion:nil)
            }
                
                
            else if (sender.tag == 1)
            {
                valueRow = "2"
                globelImageArr = CompanyInfoImageArr
                globelArr = CompanyInfoArr
                tableView.reloadData()
                btnBack.isHidden = false
            }
                
                
            else if (sender.tag == 7)
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: kLoginViewController) as! LoginViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
            
        else if (valueRow == "2")
        {
            if (sender.tag == 4)
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: kHelpUSViewController) as! HelpUSViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                
                self.present(nextViewController, animated:true, completion:nil)
            }
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
    
}
extension EditProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.imageView.image = selectedImage
         self.Edit_Img_API_Methods()
        picker.dismiss(animated: true, completion: nil)
       
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        
        self.dismiss(animated: true, completion: nil)
    }
}


