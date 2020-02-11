//
//  EditProfileViewController.swift
//  UeBook
//
//  Created by Admin on 10/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var btnBack: UIButton!
    class func instance()->UIViewController{
           let colorController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kEditProfileViewController)
           let nav = UINavigationController(rootViewController: colorController)
           nav.navigationBar.isTranslucent = false
           return nav
       }
    
   
    var globelImageArr :[UIImage] = []
    var globelArr : [String] = []
    var arrayGallerySingle : [UIImage] = [#imageLiteral(resourceName: "userinfo"),#imageLiteral(resourceName: "companyinfo"),#imageLiteral(resourceName: "addbook"),#imageLiteral(resourceName: "chat_icon"),#imageLiteral(resourceName: "chat_icon"),#imageLiteral(resourceName: "addbook"),#imageLiteral(resourceName: "dict"),#imageLiteral(resourceName: "logout")]
    
    var vbPlayerName : [String] = ["User Info","Company ","Upload Book","Chat with Others","Pending Request ","Pending Book","Dictonary","Logout"]
    
    var CompanyInfoImageArr : [UIImage] = [#imageLiteral(resourceName: "languges"),#imageLiteral(resourceName: "share"),#imageLiteral(resourceName: "helpcenter"),#imageLiteral(resourceName: "about"),#imageLiteral(resourceName: "contactus")]
    var CompanyInfoArr : [String] = ["Interface Language","Share us to friend ","Help Center","About Us","Contact Us"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var lblLoction: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationHide()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        globelImageArr = arrayGallerySingle
        globelArr  = vbPlayerName
        
        btnBack.isHidden = true

        // Do any additional setup after loading the view.
    }
    @IBAction func btnBack(_ sender: Any) {
        globelImageArr = arrayGallerySingle
               globelArr  = vbPlayerName
        tableView.reloadData()
         btnBack.isHidden = true
        
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
    @objc func subscribeTapped(_ sender: UIButton){
        
        
        
        if (sender.tag == 1)
        {
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
        
        
//      // use the tag of button as index
//        let lineNumbers = [notePadArr[sender.tag].title! , notePadArr[sender.tag].description!]
//        let multiLineTemplate = """
//        \(lineNumbers[0])
//        \(lineNumbers[1])
//
//        """
//        let textToShareValue = multiLineTemplate
//       // let youtuber = textToShareValue
//
//        let textToShare = textToShareValue
//
//           if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
//               let objectsToShare: [Any] = [textToShare, myWebsite]
//               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//
//               activityVC.popoverPresentationController?.sourceView = sender
//               self.present(activityVC, animated: true, completion: nil)
//           }
        
        
        
        
            
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
