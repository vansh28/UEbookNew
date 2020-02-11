//
//  AppDelegate.swift
//  UeBook
//
//  Created by Admin on 16/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import JitsiMeet
import IQKeyboardManagerSwift
import FBSDKCoreKit

import GoogleSignIn

import AZTabBar



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,GIDSignInDelegate{
 var window: UIWindow?
 var tabController:AZTabBarController!
public var objRevealViewController = SWRevealViewController()
var navController : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        IQKeyboardManager.shared.enable = true
        GIDSignIn.sharedInstance().clientID = "554579271036"
        GIDSignIn.sharedInstance().delegate = self
        
        
               let loginVC = UserDefaults.standard.integer(forKey: "Save_User_Login")

               if loginVC == 1 {
                    let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                           let homePage = mainStoryboard.instantiateViewController(withIdentifier:kHomeViewController) as! HomeViewController
                           self.window?.rootViewController = homePage

               }
               else{
                   self.methodForLogout()
               }
        ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions:
                   launchOptions
               )
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        guard let launchOptions = launchOptions else { return false }
               return JitsiMeet.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
      
     }
    
    
  //..................gmail And Google..........
    @available(iOS 9.0, *)
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
      // Perform any operations on signed in user here.
        _ = user.userID                  // For client-side use only!
        _ = user.authentication.idToken // Safe to send to the server
        _ = user.profile.name
        _ = user.profile.givenName
        let familyName = user.profile.familyName
        _ = user.profile.email
      // ...
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
 //..................gmail And Google..........
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    class func methodForLogin() {
           AppDelegate.getAppDelegate().root()
       }
       class func getAppDelegate() -> AppDelegate {
              return UIApplication.shared.delegate as! AppDelegate
          }
    func root()
    {
        let status = UserDefaults.standard.bool(forKey: "status")
            var rootVC : UIViewController?
           
                print(status)
            

            if(status == true){
                rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kHomeViewController) as! HomeViewController
            }else{
                rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kLoginViewController) as! LoginViewController
            }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = rootVC
            
        }
     

    
    func methodForLogout() {
        let storyboard = UIStoryboard(name: kMain, bundle: nil)
        let objViewController = storyboard.instantiateViewController(withIdentifier: kFirstPageViewController) as? FirstPageViewController
        let loginNav = UINavigationController(rootViewController: objViewController!)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = loginNav
    }
    //..... tabbar view controller
    
     func addRoot() {
            var icons = [String]()
            icons.append("homenew")
            icons.append("userhome")
            icons.append("bookmarkhome")
            icons.append("notehome")
            icons.append("categorieshome")
        
        
        
            
            var selectedIcons = [String]()
            selectedIcons.append("homenew")
            selectedIcons.append("userhome")
            selectedIcons.append("bookmarkhome")
            selectedIcons.append("notehome")
            selectedIcons.append("categorieshome")
           
        
            let pp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:kLoginViewController)
            
            
    //        let rearNavigationController = UINavigationController(rootViewController: rearViewController!)
    //        rearNavigationController.isNavigationBarHidden = true
            
            
            
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kHomeViewController) as? HomeViewController
    //        let frontNavigationControllerHome = UINavigationController(rootViewController: homeVC!)
            
            let bookMarksVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kBookMarkViewController) as? BookMarkViewController
            
             let NotepadVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kNotepadViewController) as? NotepadViewController
            
            let EditProfileVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: kEditProfileViewController) as? EditProfileViewController
        
            let CategoriesVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: kCategoriesViewController) as? CategoriesViewController
   
            let color = UIColor(red:0.71, green:0.45, blue:0.04, alpha:1.0)
            
            tabController = AZTabBarController.insert(into: pp, withTabIconNames: icons, andSelectedIconNames: selectedIcons)
            
            tabController.setViewController(UINavigationController(rootViewController:homeVC!), atIndex: 0)
            tabController.setViewController(UINavigationController(rootViewController:bookMarksVC!), atIndex: 1)
            tabController.setViewController(UINavigationController(rootViewController:NotepadVC!), atIndex: 2)
            tabController.setViewController(UINavigationController(rootViewController:CategoriesVC!), atIndex: 3)
            tabController.setViewController(UINavigationController(rootViewController:EditProfileVC!), atIndex: 3)
            
            tabController.selectionIndicatorHeight = 0
            tabController.font = UIFont(name: "Montserrat-Regular", size: 10)
            
            
            tabController.separatorLineColor = .clear
            tabController.buttonsBackgroundColor = .black
            tabController.highlightedBackgroundColor = color
            tabController.highlightButton(atIndex: 0)
            tabController.setTitle("Home", atIndex: 0)
            tabController.setTitle("BookMark", atIndex: 1)
            tabController.setTitle("Notepad", atIndex: 2)
            tabController.setTitle("Category", atIndex: 3)
            tabController.setTitle("User", atIndex: 4)
            
            tabController.animateTabChange = false
            tabController.highlightColor = .white
            tabController.selectedColor = .white
            tabController.defaultColor = .white
            tabController.setIndex(0)
            
            tabController.setAction(atIndex: 0) {
                self.tabController.highlightButton(atIndex: 0)
                self.tabController.removeHighlight(atIndex: 1)
                self.tabController.removeHighlight(atIndex: 2)
                self.tabController.removeHighlight(atIndex: 3)
                self.tabController.removeHighlight(atIndex: 4)
                (self.tabController.children[0] as? UINavigationController)?.popToRootViewController(animated: true)
            }
            
            tabController.setAction(atIndex: 1) {
                //Your statments
                self.tabController.removeHighlight(atIndex: 0)
                self.tabController.highlightButton(atIndex: 1)
                self.tabController.removeHighlight(atIndex: 2)
                self.tabController.removeHighlight(atIndex: 3)
                self.tabController.removeHighlight(atIndex: 4)
                (self.tabController.children[1] as? UINavigationController)?.popToRootViewController(animated: true)
            }
            tabController.setAction(atIndex: 2) {
                //Your statments
                self.tabController.removeHighlight(atIndex: 0)
                self.tabController.removeHighlight(atIndex: 1)
                self.tabController.highlightButton(atIndex: 2)
                self.tabController.removeHighlight(atIndex: 3)
                self.tabController.removeHighlight(atIndex: 4)
                (self.tabController.children[2] as? UINavigationController)?.popToRootViewController(animated: true)
            }
            tabController.setAction(atIndex: 3) {
                //Your statments
                self.tabController.removeHighlight(atIndex: 0)
                self.tabController.removeHighlight(atIndex: 1)
                self.tabController.removeHighlight(atIndex: 2)
                self.tabController.highlightButton(atIndex: 3)
                self.tabController.removeHighlight(atIndex: 4)
                (self.tabController.children[3] as? UINavigationController)?.popToRootViewController(animated: true)
            }
        tabController.setAction(atIndex: 4) {
                       //Your statments
                       self.tabController.removeHighlight(atIndex: 0)
                       self.tabController.removeHighlight(atIndex: 1)
                       self.tabController.removeHighlight(atIndex: 2)
                       self.tabController.removeHighlight(atIndex: 3)
                       self.tabController.highlightButton(atIndex: 4)
                       (self.tabController.children[4] as? UINavigationController)?.popToRootViewController(animated: true)
                   }
            
//let rearViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kSideTableViewController) as? SideMenuViewController
//        let revealController = SWRevealViewController(nibName: HomeViewController, bundle: tabController)
//       self.objRevealViewController = revealController!
//       let storyboard = UIStoryboard(name: kMain, bundle: nil)
//       let objViewController = storyboard.instantiateViewController(withIdentifier: kHomeViewController) as? HomeViewController
//       let loginNav = UINavigationController(rootViewController: objViewController!)
//       self.window?.backgroundColor = UIColor.white
//       self.window?.rootViewController = loginNav
       
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: kHomeViewController) as! HomeViewController
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = initialViewControlleripad
                    self.window?.makeKeyAndVisible()
        
        let vc = HomeViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        navigationController.setNavigationBarHidden(true, animated: true)

        
        
//
//          window = UIWindow(frame: UIScreen.main.bounds)
//        navController = UINavigationController.init(rootViewController: homeVC!)
//
//           navController?.isNavigationBarHidden =
//               ((navController?.navigationBar.isTranslucent = false) != nil)
//
//           self.window?.rootViewController = navController
//           self.window?.backgroundColor = .white
//           self.window?.makeKeyAndVisible()
    
    }
    
    
    
    ///..........................///

// MARK: - Linking delegate methods

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return JitsiMeet.sharedInstance().application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
         GIDSignIn.sharedInstance().handle(url)
        ApplicationDelegate.shared.application(
                   app,
                   open: url,
                   options: options
               )
        return JitsiMeet.sharedInstance().application(app, open: url, options: options)
    }
}


