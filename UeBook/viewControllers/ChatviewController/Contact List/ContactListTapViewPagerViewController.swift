//
//  ContactListTapViewPagerViewController.swift
//  UeBook
//
//  Created by Admin on 05/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ContactListTapViewPagerViewController: PagerController ,PagerDataSource, PagerDelegate  {

    private lazy var FirstVC:contactListViewController = {
           return self.storyboard?.instantiateViewController(withIdentifier:kcontactListViewController) as! contactListViewController
       }()

    private lazy var secondVC:TelephoneBookViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: kTelephoneBookViewController) as! TelephoneBookViewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
               
               self.setupPager(
                   tabNames: ["  Friend  ", "Telephone Book    "],
                   tabControllers: [FirstVC, secondVC])
               customizeTab()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func btnBack(_ sender: Any) {
//        let next = self.storyboard?.instantiateViewController(withIdentifier: kChatTapViewPagerViewController) as! ChatTapViewPagerViewController
//                      self.present(next, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    func customizeTab() {
           indicatorColor = .red
          let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
           tabsViewBackgroundColor = myColor
        contentViewBackgroundColor = .white
           
           startFromSecondTab = false
           centerCurrentTab = true
           tabLocation = PagerTabLocation.top
           tabHeight = 35
           tabOffset = 35
           tabWidth = UIScreen.main.bounds.size.width/2
           fixFormerTabsPositions = false
           fixLaterTabsPosition = false
           animation = PagerAnimation.during
           selectedTabTextColor = .white
    
           tabsTextColor = .white
           tabTopOffset = 50.0
           indicatorHeight = 2.0
           isRTL = false
       }

    func didChangeTabToIndex(_ pager: PagerController, index: Int){
        print("selected tab index is \(index)")
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
