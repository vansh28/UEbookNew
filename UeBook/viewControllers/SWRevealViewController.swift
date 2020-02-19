//
//  SWRevealViewController.swift
//  UeBook
//
//  Created by Admin on 10/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AZTabBar


class SWRevealViewController: UIViewController {

    
    var indexValue = String()
     var counter = 0
        var tabController:AZTabBarController!
        
      //  var audioId: SystemSoundID!
        
        var resultArray:[String] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
         //   audioId = createAudio()

            
            var icons = [UIImage]()
            icons.append(#imageLiteral(resourceName: "homenew.png"))
            icons.append(#imageLiteral(resourceName: "bookmarkhome.png"))
            icons.append(#imageLiteral(resourceName: "categorieshome"))
            icons.append(#imageLiteral(resourceName: "notehome.png"))
            icons.append(#imageLiteral(resourceName: "userhome.png"))
            
            var sIcons = [UIImage]()
            sIcons.append(#imageLiteral(resourceName: "homenew.png"))
            sIcons.append(#imageLiteral(resourceName: "bookmarkhome.png"))
            sIcons.append(#imageLiteral(resourceName: "categorieshome"))
            sIcons.append(#imageLiteral(resourceName: "notehome.png"))
            sIcons.append(#imageLiteral(resourceName: "userhome.png"))

            
            //init
            //tabController = .insert(into: self, withTabIconNames: icons)
            tabController = .insert(into: self, withTabIcons: icons, andSelectedIcons: sIcons)

            //set delegate
            tabController.delegate = self

            //set child controllers

            
            //set child controllers




            if indexValue == "0"
            {
                tabController.setViewController(HomeViewController.instance(), atIndex: 0)
                
            }
            else if indexValue == "1"
            {
                tabController.setViewController(BookMarkViewController.instance(), atIndex: 1)
                
            }
            else if indexValue == "2"
            {
                tabController.setViewController(CategoriesViewController.instance(), atIndex: 2)
                
                
            }
            else if indexValue == "3"
            {
                tabController.setViewController(NotepadViewController.instance(), atIndex: 3)
            }
                
                
            else if indexValue == "4"
            {
                tabController.setViewController(EditProfileViewController.instance(), atIndex: 4)
            }
            
            

            
            
            
            
            //customize

                   let color = UIColor(red: (95.0/255), green: (122.0/255), blue: (134.0/255), alpha: 1.0)

                   tabController.selectedColor = color

                   tabController.highlightColor = color

                   tabController.highlightedBackgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)

                   tabController.defaultColor = .lightGray

                   //tabController.highlightButton(atIndex: 2)

                   tabController.buttonsBackgroundColor = UIColor(red: (247.0/255), green: (247.0/255), blue: (247.0/255), alpha: 1.0)

                   tabController.selectionIndicatorHeight = 0

                   tabController.selectionIndicatorColor = color

                   tabController.tabBarHeight = 60

                   tabController.notificationBadgeAppearance.backgroundColor = .red
                   tabController.notificationBadgeAppearance.textColor = .white
                   tabController.notificationBadgeAppearance.borderColor = .clear
                   tabController.notificationBadgeAppearance.borderWidth = 0.2

//                   tabController.setAction(atIndex: 0) {
//                       self.tabController.onlyShowTextForSelectedButtons = !self.tabController.onlyShowTextForSelectedButtons
//                   }

            tabController.setAction(atIndex: 3){
                self.counter = 0
                self.tabController.setBadgeText(nil, atIndex: 3)
            }
            
                   tabController.setIndex(0, animated: true)

                   tabController.animateTabChange = true
                      tabController.onlyShowTextForSelectedButtons = true

                   //tabController.onlyShowTextForSelectedButtons = false
                   tabController.setTitle("Home", atIndex: 0)
                   tabController.setTitle("Bookmark", atIndex: 1)
                   tabController.setTitle("Category", atIndex: 2)
                   tabController.setTitle("Notepad", atIndex: 3)
                   tabController.setTitle("User", atIndex: 4)
                   tabController.font = UIFont(name: "AvenirNext-Regular", size: 12)

                   let container = tabController.buttonsContainer
                   container?.layer.shadowOffset = CGSize(width: 0, height: -2)
                   container?.layer.shadowRadius = 10
                   container?.layer.shadowOpacity = 0.1
                   container?.layer.shadowColor = UIColor.black.cgColor

            tabController.setButtonTintColor(color: #colorLiteral(red: 0.373326242, green: 0.4800810218, blue: 0.5238870978, alpha: 1), atIndex: 0)
            tabController.setButtonTintColor(color: #colorLiteral(red: 0.373326242, green: 0.4800810218, blue: 0.5238870978, alpha: 1), atIndex:1)
            tabController.setButtonTintColor(color: #colorLiteral(red: 0.373326242, green: 0.4800810218, blue: 0.5238870978, alpha: 1), atIndex: 2)
            tabController.setButtonTintColor(color: #colorLiteral(red: 0.373326242, green: 0.4800810218, blue: 0.5238870978, alpha: 1), atIndex: 3)
            tabController.setButtonTintColor(color: #colorLiteral(red: 0.373326242, green: 0.4800810218, blue: 0.5238870978, alpha: 1), atIndex: 4)
           
            
            
            
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            if indexValue == "3"
            {
                tabController.setViewController(NotepadViewController.instance(), atIndex: 3)
            }

        }
        
        override var childForStatusBarStyle: UIViewController?{
            return tabController
        }
        
        func getNavigationController(root: UIViewController)->UINavigationController{
            let navigationController = UINavigationController(rootViewController: root)
            navigationController.title = title
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.barStyle = .black
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.368627451, alpha: 1)
            return navigationController
        }
        
//        func createAudio()->SystemSoundID{
//            var soundID: SystemSoundID = 0
//            let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "blop" as CFString?, "mp3" as CFString?, nil)
//            AudioServicesCreateSystemSoundID(soundURL!, &soundID)
//            return soundID
//        }
//
//        func actionLaunchCamera()
//        {
//            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
//            {
//                let imagePicker:UIImagePickerController = UIImagePickerController()
//                imagePicker.delegate = self
//                imagePicker.sourceType = UIImagePickerController.SourceType.camera
//                imagePicker.allowsEditing = true
//
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//            else
//            {
//                let alert:UIAlertController = UIAlertController(title: "Camera Unavailable", message: "Unable to find a camera on this device", preferredStyle: UIAlertController.Style.alert)
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
    }

    extension SWRevealViewController: AZTabBarDelegate{
        func tabBar(_ tabBar: AZTabBarController, statusBarStyleForIndex index: Int) -> UIStatusBarStyle {
            return (index % 2) == 0 ? .default : .lightContent
        }
        
        func tabBar(_ tabBar: AZTabBarController, shouldLongClickForIndex index: Int) -> Bool {
            return true//index != 2 && index != 3
        }
        
        func tabBar(_ tabBar: AZTabBarController, shouldAnimateButtonInteractionAtIndex index: Int) -> Bool {
            return true
        }
        
        func tabBar(_ tabBar: AZTabBarController, didMoveToTabAtIndex index: Int) {
            print("didMoveToTabAtIndex \(index)")
        }
        
        func tabBar(_ tabBar: AZTabBarController, didSelectTabAtIndex index: Int) {
            print("didSelectTabAtIndex \(index)")
            
            
            
            if index == 0
            {
                tabController.setViewController(HomeViewController.instance(), atIndex: 0)
                
            }
            else if index == 1
            {
                tabController.setViewController(BookMarkViewController.instance(), atIndex: 1)
                
            }
            else if index == 2
            {
                tabController.setViewController(CategoriesViewController.instance(), atIndex: 2)
                
                
            }
            else if index == 3
            {
                tabController.setViewController(NotepadViewController.instance(), atIndex: 3)
            }
                
                
            else if index == 4
            {
                tabController.setViewController(EditProfileViewController.instance(), atIndex: 4)
            }
        }
        
        func tabBar(_ tabBar: AZTabBarController, willMoveToTabAtIndex index: Int) {
            print("willMoveToTabAtIndex \(index)")
        }
        
        func tabBar(_ tabBar: AZTabBarController, didLongClickTabAtIndex index: Int) {
            print("didLongClickTabAtIndex \(index)")
        }
//
//        func tabBar(_ tabBar: AZTabBarController, systemSoundIdForButtonAtIndex index: Int) -> SystemSoundID? {
//            return tabBar.selectedIndex == index ? nil : audioId
//        }
        
    }

//    extension SWRevealViewController: AZSearchViewDelegate{
//
//        func searchView(_ searchView: AZSearchViewController, didSearchForText text: String) {
//            searchView.dismiss(animated: false, completion: nil)
//        }
//
//        func searchView(_ searchView: AZSearchViewController, didTextChangeTo text: String, textLength: Int) {
//            self.resultArray.removeAll()
//            if textLength > 3 {
//                for i in 0..<arc4random_uniform(10)+1 {self.resultArray.append("\(text) \(i+1)")}
//            }
//
//            searchView.reloadData()
//        }
//
//        func searchView(_ searchView: AZSearchViewController, didSelectResultAt index: Int, text: String) {
//            searchView.dismiss(animated: true, completion: {
//            })
//        }
//    }

//    extension ViewController: AZSearchViewDataSource{
//
//        func results() -> [String] {
//            return self.resultArray
//        }
//    }
//
//    extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss(animated: true, completion: nil)
//        }
//    }

    class LabelController: UIViewController {
        
        class func controller(text:String, title: String)-> LabelController{
            
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LabelController") as! LabelController
            controller.title = title
            controller.text = text
            return controller
        }
        
        var text:String!
        
        @IBOutlet weak private var labelView:UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            labelView.text = text
        }
        
    }

    class ButtonController: UIViewController{
        class func controller(badgeCount:Int, currentIndex: Int )-> ButtonController{
            
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ButtonController") as! ButtonController
            controller.badgeCount = badgeCount
            controller.currentIndex = currentIndex
            return controller
        }
        
        var badgeCount: Int = 0
        var currentIndex: Int = 0
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            for view in view.subviews{
                if view is UIButton{
                    view.badge(text: nil)
                }
            }
            
            currentTabBar?.setBadgeText(nil, atIndex: currentIndex)
        }
        
        @IBAction func didClickButton(_ sender: UIButton) {
            badgeCount += 1
            
            //currentTabBar?.removeAction(atIndex: 2)
            
            if let tabBar = currentTabBar{
                tabBar.setBadgeText("\(badgeCount)", atIndex: currentIndex)
                sender.badge(text: "\(badgeCount)")
            }
        }
        
        
    }

