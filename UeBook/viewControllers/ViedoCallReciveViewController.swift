//
//  ViedoCallReciveViewController.swift
//  UeBook
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViedoCallReciveViewController: UIViewController, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var btnViedoRecive: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "call-recieve", withExtension: "gif")!)
        let advTimeGif = UIImage.gif(data: imageData!)
         btnViedoRecive.setImage(advTimeGif, for: .normal)

        self.openCamera()

//        let Gif = UIImage.gif(name: "call-recieve.gif")
//
//        // A UIImageView with async loading
//        btnViedoRecive.setImage(Gif, for: .normal)
//
        // Do any additional setup after loading the view.
    }
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.sourceType = .camera
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
    }
    
    @IBAction func btnViedoRecive(_ sender: Any) {
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

