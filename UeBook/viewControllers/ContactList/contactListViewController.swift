//
//  contactListViewController.swift
//  UeBook
//
//  Created by Admin on 21/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class contactListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{


    var chatArr = [AllUserListClass]()

    
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
    
    @IBOutlet weak var tableView: UITableView!
    var userId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
           userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
               Register_API_Method()
       
               tableView.rowHeight = 100
               tableView.delegate = self
               tableView.dataSource = self
               
        // Do any additional setup after loading the view.
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

    @objc func fabTapped(_ button: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: kChatUSViewController) as! ChatUSViewController
                       //nextViewController.valueNote = "1"

        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated:true, completion:nil)
        print("button tapped")
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
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ContactTableViewCell
        
        let escapedString = chatArr[indexPath.row].url
        
        let fullURL = kImageUploadURL + escapedString!
        let url = URL(string:fullURL)!

        
        
        cell?.userName.text = chatArr[indexPath.row].name
        cell?.userPublisherType.text = chatArr[indexPath.row].publisher_type
        DispatchQueue.main.async {
                           
            
            self.getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                cell?.imageView?.image = #imageLiteral(resourceName: "scam_dum.png")
                return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                
                cell?.imageView?.image = UIImage(data: data)
            
                }
            }
        }
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
          
          let next = self.storyboard?.instantiateViewController(withIdentifier: "ChatUserDetail") as! ChatUserDetail
                 self.present(next, animated: true, completion: nil)
      }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func Register_API_Method()
    {
       

        let dictionary: NSDictionary = [
            "user_id" : userId
            
        ]
        ServiceManager.POSTServerRequest(String(kuser_list), andParameters: dictionary as! [String : String], success: {response in
            
            print("response-------",response!)
          //  self.HideLoader()
            if response is NSDictionary {
                let msg = response?["message"] as? String
                let userList = response?["userList"] as? NSArray
                let statusCode = response?["error"] as? Int
               
                
                
                
                if userList == nil || userList?.count == 0 {
                    
                    //self.noDataFoundLbl.isHidden = false
                    self.tableView.isHidden = true
                 }
                else {
                    self.chatArr.removeAll()
                    self.tableView.isHidden = false

                    for dataCategory in userList! {
                        
                        self.chatArr.append(AllUserListClass(getAllUserListData: dataCategory as! NSDictionary))
                    }
                    self.tableView.reloadData()
                }
                
                
                
                
                
                if statusCode == 1 {
                  //  self.AlertVC(alertMsg:msg!)
                }
                else if statusCode == 0
                {
               }
           }
        }, failure: { error in
           // self.HideLoader()
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
