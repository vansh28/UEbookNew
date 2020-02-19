//
//  HomeViewController.swift
//  UeBook
//
//  Created by Admin on 23/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    class func instance()->UIViewController{
           let colorController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kHomeViewController)
           let nav = UINavigationController(rootViewController: colorController)
           nav.navigationBar.isTranslucent = false
           return nav
       }
    var popularBookArr = [AllpopularBook]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private let itemsPerRow: CGFloat = 1
    private let sectionInsets = UIEdgeInsets(top: 0.0,
                                             left: 0.0,
                                             bottom: 0.0,
                                             right: 0.0)
    var value = 0
    private let spacing:CGFloat = 1
    
    var screenWidth: CGFloat!
    var screenSize: CGRect!
    
    let reuseIdentifier = "Cell" // also enter this string as the cell identifier in the storyboard
    
    var arrayGallerySingle : [UIImage] = [#imageLiteral(resourceName: "4-home-1"),#imageLiteral(resourceName: "4-home-1"),#imageLiteral(resourceName: "4-home-1"),#imageLiteral(resourceName: "4-home"),#imageLiteral(resourceName: "4-home-1"),#imageLiteral(resourceName: "4-home-1")]
    
    var vbPlayerName : [String] = ["dddddd","drink ","burger","Julia","Fanta ","Coacola","Burger","Alicia ","Alexandra","Julia","Alicia ","fires"]
    var vbPrice : [String] = ["25","100 ","350","25","23 ","40","100","45 ","110","120","25 ","40"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationHide()

        GetAllPopularBook_API_Method()
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: collectionView.bounds.width/3, height: (collectionView.bounds.width/2)) // Here manage the number of cell in row.
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationHide()
        GetAllPopularBook_API_Method()
        
       
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:view.bounds.width / 3, height:view.bounds.width / 2)
    }
    func GetAllPopularBook_API_Method()
    {
        
        
        let dictionary: NSDictionary = [:]
        ServiceManager.POSTServerRequest(String(kgetAllpopularBook), andParameters: dictionary as! [String : String], success: {response in
            
            print("response-------",response!)
            //  self.HideLoader()
            if response is NSDictionary {
                let msg = response?["message"] as? String
                let popularBookList = response?["data"] as? NSArray
                let statusCode = response?["error"] as? Int
                
                
                
                
                if popularBookList == nil || popularBookList?.count == 0 {
                    
                    //self.noDataFoundLbl.isHidden = false
                    self.collectionView.isHidden = true
                }
                else {
                    self.popularBookArr.removeAll()
                    self.collectionView.isHidden = false
                    
                    for dataCategory in popularBookList! {
                        
                        self.popularBookArr.append(AllpopularBook(getAllpopularBookData: dataCategory as! NSDictionary))
                        
                        
                    }
                    self.collectionView.reloadData()
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
    @IBAction func btWriteYourBook(_ sender: Any) {
        let BookdetailVC = self.storyboard?.instantiateViewController(withIdentifier: kUploadBookViewController) as! UploadBookViewController

               
                BookdetailVC.modalPresentationStyle = .overFullScreen

        //        self.navigationController?.pushViewController(BookdetailVC, animated: true)
                self.present(BookdetailVC, animated: true, completion: nil)
        
    }
    
    @IBAction func btnReadYourBook(_ sender: Any) {
        let BookdetailVC = self.storyboard?.instantiateViewController(withIdentifier: kReadBookViewController) as! ReadBookViewController

                      
                       BookdetailVC.modalPresentationStyle = .overFullScreen

               //        self.navigationController?.pushViewController(BookdetailVC, animated: true)
                       self.present(BookdetailVC, animated: true, completion: nil)
                       
                     //  print("You selected cell #\(indexPath.item)!")
    }
    
   
    
    @IBAction func btnChat(_ sender: Any) {
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.popularBookArr.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! HomeCollectionViewCell
        
        
        cell.imageView.layer.cornerRadius = 10
        
        cell.lblBookName.text =     popularBookArr [indexPath.row].book_title
        cell.lblWriteName.text =    popularBookArr[indexPath.row].author_name
        cell.layer.masksToBounds = true

        
        
        let escapedString = popularBookArr[indexPath.row].thubm_image
        let fullURL = "http://" + escapedString!
        let url = URL(string:fullURL)!
        
        
        DispatchQueue.main.async {
            
            
            self.getData(from: url) { data, response, error in
                guard let data = data, error == nil else {
                    cell.imageView?.image = #imageLiteral(resourceName: "scam_dum.png")
                    return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() {
                   cell.imageView?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "noimage") )

                   // cell.imageView?.image = UIImage(data: data)
                    
                }
            }
        }
        
        
        return cell
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // self.present(next, animated: true, completion: nil)
        
        let bookId = self.popularBookArr[indexPath.row].id
        let BookdetailVC = self.storyboard?.instantiateViewController(withIdentifier: kBookDescriptionViewController) as! BookDescriptionViewController
       BookdetailVC.modalPresentationStyle = .overFullScreen
        BookdetailVC.bookId = bookId!
        print(BookdetailVC.bookId)
        
//        self.navigationController?.pushViewController(BookdetailVC, animated: true)
        self.present(BookdetailVC, animated: true, completion: nil)
        
        print("You selected cell #\(indexPath.item)!")
    }
    
    
}


//     extension HomeViewController : UICollectionViewDelegateFlowLayout {

//          func collectionView(_ collectionView: UICollectionView,
//                              layout collectionViewLayout: UICollectionViewLayout,
//                              sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let numberOfItemsPerRow:CGFloat = 3
//           let spacingBetweenCells:CGFloat = 0
//
//            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//            let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
//
//            let availableWidth = view.frame.width - totalSpacing
//            let widthPerItem = availableWidth / itemsPerRow
//            //screenSize = collectionView.frame.width
//
//            return CGSize(width: widthPerItem/3, height: 225)
//          }
////
//             func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//                return CGSize(width: 115, height: CGFloat(200))
//            }
//}
////
//
//          func collectionView(_ collectionView: UICollectionView,
//                              layout collectionViewLayout: UICollectionViewLayout,
//                              insetForSectionAt section: Int) -> UIEdgeInsets {
//            return sectionInsets
//          }
//
//
//          func collectionView(_ collectionView: UICollectionView,
//                              layout collectionViewLayout: UICollectionViewLayout,
//                              minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return 0
//          }
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//               return 0.0
//           }
//        }

/*
 // MARK: - Navigation
 @IBAction func btnReadYourBook(_ sender: Any) {
 }
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


