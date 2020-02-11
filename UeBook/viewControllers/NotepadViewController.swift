//
//  NotepadViewController.swift
//  UeBook
//
//  Created by Admin on 10/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class NotepadViewController: UIViewController , UITableViewDataSource ,UITableViewDelegate{

    class func instance()->UIViewController{
        let colorController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kNotepadViewController)
        let nav = UINavigationController(rootViewController: colorController)
        nav.navigationBar.isTranslucent = false
        return nav
    }
    var count = 0

    lazy var faButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor(red: (95.0/255), green: (122.0/255), blue: (134.0/255), alpha: 1.0)

        button.backgroundColor = color
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)


        button.addTarget(self, action: #selector(fabTapped(_:)), for: .touchUpInside)
        return button
    }()
    var userId = String()
    var notePadArr = [AllNotebyUser]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationHide()

         userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
         Notepad_API_Method()
       

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 94

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
         self.navigationHide()
         Notepad_API_Method()

        
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

    func setupTableView() {
        tableView.backgroundColor = .darkGray
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
                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: kAddNotesViewController) as! AddNotesViewController
                       nextViewController.valueNote = "1"

        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated:true, completion:nil)
        print("button tapped")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return notePadArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotepadCell") as? NotepadTableViewCell
            
            cell?.lblTitle.text =  notePadArr[indexPath.row].title
            cell?.lblDateTime.text = notePadArr[indexPath.row].created_at
            cell?.btnShare.tag = indexPath.row
            
            cell?.btnShare.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)

            
            return cell!
            
        }
    @objc func subscribeTapped(_ sender: UIButton){
        
        
      // use the tag of button as index
        let lineNumbers = [notePadArr[sender.tag].title! , notePadArr[sender.tag].description!]
        let multiLineTemplate = """
        \(lineNumbers[0])
        \(lineNumbers[1])
        
        """
        let textToShareValue = multiLineTemplate
       // let youtuber = textToShareValue
        
        let textToShare = textToShareValue
        
           if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
               let objectsToShare: [Any] = [textToShare, myWebsite]
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
               activityVC.popoverPresentationController?.sourceView = sender
               self.present(activityVC, animated: true, completion: nil)
           }
        
        
        
        
            
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                     let note_id = notePadArr[indexPath.row].id
                     let strtitle  = notePadArr[indexPath.row].title
                     let strDescription = notePadArr[indexPath.row].description
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: kAddNotesViewController) as! AddNotesViewController
                             
                    nextViewController.note_id = note_id!
                    nextViewController.strNoteTitle = strtitle!
                    nextViewController.strNoteDescription = strDescription!
                    nextViewController.valueNote = "2"
                    nextViewController.modalPresentationStyle = .overFullScreen
                    self.present(nextViewController, animated:true, completion:nil)
                }


        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                         URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
                     }
           func Notepad_API_Method() {
               
               
               let parameters: NSDictionary = [
                  "user_id": userId
                 ]
               

               ServiceManager.POSTServerRequest(String(kgetAllNotebyUser), andParameters: parameters as! [String : String], success: {response in
                   print("response-------",response!)
                   //self.HideLoader()
                   if response is NSDictionary {
                      // let statusCode = response?["error"] as? Int
                       let message = response? ["message"] as? String
                       let BookDetailList = response?["data"] as? NSArray

                        print("response-------",response!)
                              
                                if BookDetailList == nil || BookDetailList?.count == 0 {
                                   
                                   self.tableView.isHidden = true
                                  
                                   let label = UILabel(frame: CGRect(x: 120, y:self.tableView.frame.size.height/2, width: 200, height: 21))
                                   let color = UIColor(red: (95.0/255), green: (122.0/255), blue: (134.0/255), alpha: 1.0)

                                   label.textColor = color
                                 //  label.backgroundColor = .gray
                                   label.font = UIFont.boldSystemFont(ofSize:20.0)
                                  // label.center = CGPoint(x: 160, y: 285)
                                   label.textAlignment = .left
                                   label.text = "No Notepad List"
                                   self.view.addSubview(label)
                       
                                }
                                 else
                                {
                                        self.notePadArr.removeAll()
                                        self.tableView.isHidden = false
                                        
                                        for dataCategory in BookDetailList! {
                                            
                                            self.notePadArr.append(AllNotebyUser(getAllNotebyUser: dataCategory as! NSDictionary))
                                            print(self.notePadArr.count)
                                            
                                        }
                                        self.tableView.reloadData()
                                    }
                       
                               
                       
                           
                       
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
