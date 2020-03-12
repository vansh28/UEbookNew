//
//  ChatTapViewPagerViewController.swift
//  UeBook
//
//  Created by Admin on 04/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ChatTapViewPagerViewController: PagerController ,PagerDataSource, PagerDelegate  {
    
    lazy var faButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor(red: (95.0/255), green: (122.0/255), blue: (134.0/255), alpha: 1.0)
        
        button.backgroundColor = color
        // button.setTitle("+", for: .normal)
        button.setImage(#imageLiteral(resourceName: "chat"), for:.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        
        button.addTarget(self, action: #selector(fabTapped(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var FirstVC:ChatUSViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: kChatUSViewController) as! ChatUSViewController
    }()
    
    private lazy var secondVC:GroupChatViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: kGroupChatViewController) as! GroupChatViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.dataSource = self
        self.delegate = self
        
        self.setupPager(
            tabNames: ["  Chat  ", "  Group Chat  "],
            tabControllers: [FirstVC, secondVC])
        customizeTab()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
        nextViewController.indexValue = "0"
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let view = UIApplication.shared.keyWindow {
            view.addSubview(faButton)
            setupButton()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let view = UIApplication.shared.keyWindow, faButton.isDescendant(of: view) {
            faButton.removeFromSuperview()
        }
    }
    
    
    
    func setupButton() {
        NSLayoutConstraint.activate([
            faButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            faButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            faButton.heightAnchor.constraint(equalToConstant: 60),
            faButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        faButton.layer.cornerRadius = 30
        faButton.shadowOpacity = 0.5
        faButton.layer.masksToBounds = true
        //        faButton.layer.borderColor = UIColor.lightGray.cgColor
        //        faButton.layer.borderWidth = 4
    }
    
    @objc func fabTapped(_ button: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kContactListTapViewPagerViewController) as! ContactListTapViewPagerViewController
        
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated:true, completion:nil)
        print("button tapped")
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
