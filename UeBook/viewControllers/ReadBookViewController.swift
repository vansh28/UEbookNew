//
//  ReadBookViewController.swift
//  UeBook
//
//  Created by Admin on 27/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ReadBookViewController:  PagerController, PagerDataSource, PagerDelegate {
    private lazy var FirstVC: UploadBookViewController = {
              return UploadBookViewController(nibName: "UploadBookViewController", bundle: nil)
          }()
    
    
    override func viewDidLoad() {
      
       
        super.viewDidLoad()
        self.dataSource = self
               self.delegate = self
               
//             self.setupPager(
//               tabNames: ["First Tab", "Second tab", "Third tab"," Four tab","five tap","Six Tab",])
                    
                       customizeTab()
        // Do any additional setup after loading the view.
    }
    func customizeTab() {
        indicatorColor = .blue
        tabsViewBackgroundColor = UIColor.gray.withAlphaComponent(0.1)
        contentViewBackgroundColor = UIColor.gray.withAlphaComponent(0.32)
        
        startFromSecondTab = false
        centerCurrentTab = true
        tabLocation = PagerTabLocation.top
        tabHeight = 49
        tabOffset = 36
        tabWidth = UIScreen.main.bounds.size.width/3
        fixFormerTabsPositions = false
        fixLaterTabsPosition = false
        animation = PagerAnimation.during
        selectedTabTextColor = .blue
        tabsTextColor = .black
        tabTopOffset = 0
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
