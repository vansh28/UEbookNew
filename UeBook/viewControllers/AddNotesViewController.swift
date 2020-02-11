//
//  AddNotesViewController.swift
//  UeBook
//
//  Created by Admin on 11/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Photos
import AVKit
import AVFoundation
import MobileCoreServices
class AddNotesViewController: UIViewController , UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var txtNoteTitle: UITextField!
    
    @IBOutlet weak var textViewWriteNotes: UITextView!
    @IBOutlet weak var btnAddNotes: UIButton!
   
    
    var userId = String()
    var note_id = String()
    var strNoteTitle = String()
    var strNoteDescription = String()
    var valueNote = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        txtNoteTitle.addPadding(.left(8))
        txtNoteTitle.delegate = self
        textViewWriteNotes.delegate = self
        textViewWriteNotes.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        textViewWriteNotes.textColor = .lightGray
        
        if (valueNote == "1")
            {
                
        }
        else if (valueNote == "2" )
        {
            textViewWriteNotes.text = strNoteDescription
            textViewWriteNotes.textColor = .black
            txtNoteTitle.text = strNoteTitle
        }
        
        // Do any additional setup after loading the view.
    }
    
     override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            navigationShow()

           
        }

    @IBAction func btnAddNotes(_ sender: Any) {
        
        if self.txtNoteTitle.text?.count == 0
            {
                AlertVC(alertMsg:" Enter your Note Title")
                
            }
        else if self.textViewWriteNotes.textColor == .lightGray || self.textViewWriteNotes.text?.count == 0
            {
                AlertVC(alertMsg:"Enter your Note")
                
            }
            
            else{
            
            if (valueNote == "1")
            {
                   AddNotes_API_Method()

            }
            
            else if (valueNote == "2" )
            {
                UpdateNotes_API_Method()
            }
        }
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

    @IBAction func btnBack(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
   
    
    func textViewDidBeginEditing(_ textView: UITextView) {
               if textView.textColor == UIColor.lightGray {
                   textView.text = nil
                   textView.textColor = UIColor.black
                   
                  let myColor = UIColor.black
                  textViewWriteNotes.layer.borderColor = myColor.cgColor
                   
                  
                   
               }
           }
           
           func textViewDidEndEditing(_ textView: UITextView) {
               
               
               
               
               
               if(textView == textViewWriteNotes)
               {
                   if self.textViewWriteNotes.text?.count == 0
                   {
                       
                       textViewWriteNotes.text = "Write Your Notes here :"
                       textViewWriteNotes.textColor = UIColor.lightGray
                     
                       }
                   
               }
               
       }
    func AddNotes_API_Method() {
        
        
        
        let parameters: NSDictionary = [
           "user_id": userId,
           "title"   : txtNoteTitle.text as Any,
           "description": textViewWriteNotes.text as Any
            
          ]
        

        ServiceManager.POSTServerRequest(String(kaddNote), andParameters: parameters as! [String : String], success: {response in
            print("response-------",response!)
            //self.HideLoader()
            if response is NSDictionary {
               // let statusCode = response?["error"] as? Int
                let message = response? ["message"] as? String
                let data = response?["data"] as? Int
                let error = response?["error"] as? Int
                
                 if (error == 0)
                 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: kNotepadViewController) as! NotepadViewController
                    nextViewController.userId = self.userId
                    // nextViewController.modalPresentationStyle = .overFullScreen
                   //  self.present(nextViewController, animated:true, completion:nil)
                    self.dismiss(animated: true, completion: nil)
                    // self.navigationController?.popViewController(animated: true)
                    
                }
                 else{
                    
                }
                
                
                 print("response-------",response!)
                       
            
                        
                
                    
                
            }
        }, failure: { error in
            //self.HideLoader()
        })
    }
    
    func UpdateNotes_API_Method() {
      
        
        let parameters: NSDictionary = [
           "note_id": note_id,
           "description"   : txtNoteTitle.text as Any,
           "title": textViewWriteNotes.text as Any
            
          ]
        

        ServiceManager.POSTServerRequest(String(kUpdateNoteBook), andParameters: parameters as! [String : String], success: {response in
            print("response-------",response!)
            //self.HideLoader()
            if response is NSDictionary {
               // let statusCode = response?["error"] as? Int
                let message = response? ["message"] as? String
                let data = response?["data"] as? Int
                let error = response?["error"] as? Int
                
                 if (error == 0)
                 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: kNotepadViewController) as! NotepadViewController
                    nextViewController.userId = self.userId
                    // nextViewController.modalPresentationStyle = .overFullScreen
                     self.present(nextViewController, animated:true, completion:nil)
                     self.dismiss(animated: true, completion: nil)
                    // self.navigationController?.popViewController(animated: true)
                    
                }
                 else{
                    
                }
                
                
                 print("response-------",response!)
                       
            
                        
                
                    
                
            }
        }, failure: { error in
            //self.HideLoader()
        })
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

    
