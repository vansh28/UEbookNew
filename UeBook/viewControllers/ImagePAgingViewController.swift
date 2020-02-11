//
//  ImagePAgingViewController.swift
//  UeBook
//
//  Created by Admin on 24/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ImagePAgingViewController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var pageControl: UIPageControl!
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
     var images: [String] = ["images","imgfive","imgfour","imgone"]
     let imageCencel = UIImageView()
    let imageBtnLeft = UIImageView()
    @IBOutlet weak var scrollView: UIScrollView!
    var  imagearray = [UIImage]()
    let imageviewValue = UIImageView()
    let imgBtnRight = UIImageView()
    var iValue:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()

     
              
                         
                          imageBtnLeft.image = UIImage(named: "arrowleft")
                          imgBtnRight.image = UIImage(named: "arrowright")
     
                         imageBtnLeft.frame =  CGRect(x:10, y:scrollView.frame.height/2, width: 30,height:30)
                         imgBtnRight.frame =  CGRect(x:scrollView.frame.width-50, y: scrollView.frame.height/2, width: 30,height:30)
       
        
                             let btnleft = UITapGestureRecognizer(target: self, action: #selector(self.buttonActionLeft(_:)))
                              imageBtnLeft.addGestureRecognizer(btnleft)
                               let btnRight = UITapGestureRecognizer(target: self, action: #selector(self.buttonActionRight(_:)))
                               imgBtnRight.addGestureRecognizer(btnRight)
        imgBtnRight.isUserInteractionEnabled = true
     imageBtnLeft.isUserInteractionEnabled = true
     view.addSubview(imgBtnRight)
     view.addSubview(imageBtnLeft)
        
            scrollView.showsHorizontalScrollIndicator = false
                scrollView.isPagingEnabled = true
                
                for index in 0..<images.count {
                    frame.origin.x = scrollView.frame.size.width * CGFloat(index)
                    frame.size = scrollView.frame.size
                    
                   
                              
                    let imageView = UIImageView(frame: frame)
                    imageView.image = UIImage(named: images[index])
                    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                    imageView.addGestureRecognizer(tap)
                    imageView.isUserInteractionEnabled = true

                                 
                    self.scrollView.addSubview(imageView)
                }
               imageCencel.image = UIImage(named: "cancel")
                             imageCencel.frame =  CGRect(x:10, y: 30, width: 30,height:30)
                             
                             let btntap = UITapGestureRecognizer(target: self, action: #selector(self.buttonAction(_:)))
                                        imageCencel.addGestureRecognizer(btntap)
                             imageCencel.isUserInteractionEnabled = true
                             view.addSubview(imageCencel)
                             
                  
                  
               

                scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
                scrollView.delegate = self
             
        imageCencel.isHidden = true
    
   //     scrollviewsImageShort()
     
        
    
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
//    @IBAction func btnCut(_ sender: Any) {
//
//        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//            let page = scrollView.contentOffset.x/scrollView.frame.size.width
//             pageControl.currentPage = Int(page)
//         }
//
//    }
    
    
    func scrollImage()
    {
        scrollView.showsHorizontalScrollIndicator = false
                      scrollView.isPagingEnabled = true
                      
                      for index in 0..<images.count {
                          frame.origin.x = scrollView.frame.size.width * CGFloat(index)
                          frame.size = scrollView.frame.size
                          
                         
                                    
                          let imageView = UIImageView(frame: frame)
                          imageView.image = UIImage(named: images[index])
                          let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                          imageView.addGestureRecognizer(tap)
                          imageView.isUserInteractionEnabled = true

                                       
                          self.scrollView.addSubview(imageView)
                      }
                  

                      scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
                      scrollView.delegate = self
                   
    }
    @objc func buttonActionLeft(_ sender: UITapGestureRecognizer) {
      
        
        
        print("self.scView.contentOffset.x ..\(self.scrollView.contentOffset.x)")
        if ( self.scrollView.contentOffset.x <= self.scrollView.contentSize.width )
        {
            var frame = CGRect()

            frame.origin.x = self.scrollView.contentOffset.x - view.frame.width;
            frame.origin.y = 0;
            frame.size = self.scrollView.frame.size;

            self.scrollView .scrollRectToVisible(frame, animated: true)

        }
    }
          @objc func buttonActionRight(_ sender: UITapGestureRecognizer) {
                
           print("self.scView.contentOffset.x ..\(self.scrollView.contentOffset.x)")
           if ( self.scrollView.contentOffset.x <= self.scrollView.contentSize.width )
           {
               var frame = CGRect()

            frame.origin.x = self.scrollView.contentOffset.x + view.frame.width;
               frame.origin.y = 0;
               frame.size = self.scrollView.frame.size;

               self.scrollView .scrollRectToVisible(frame, animated: true)

           }
             }

    func scrollViewImage(){
        
        imagearray = [#imageLiteral(resourceName: "images"),#imageLiteral(resourceName: "imgfour"),#imageLiteral(resourceName: "imgone"),#imageLiteral(resourceName: "imgtwo"),#imageLiteral(resourceName: "imgthree")]
        for i in 0..<imagearray.count{
            let btnCut = UIButton()
             
              let imageview = UIImageView()
              imageview.image = imagearray[i]
          
          
             let imageBtnLeft = UIImageView()
             let imgBtnRight = UIImageView()
            imageBtnLeft.image = UIImage(named: "arrowleft")
            imgBtnRight.image = UIImage(named: "arrowright")
             
           
            
            imageBtnLeft.frame =  CGRect(x:10, y: scrollView.frame.height/2, width: 30,height:30)
            imgBtnRight.frame =  CGRect(x:scrollView.frame.width-50, y: scrollView.frame.height/2, width: 30,height:30)

            scrollView.contentMode = .scaleAspectFit
            let xpostion = self.view.frame.width * CGFloat(i)

            imageview.frame = CGRect(x:xpostion, y:0, width: self.scrollView.frame.width-8,height: self.scrollView.frame.height)
           
            
//            imageview.borderWidth = 5
//            imageview.borderColor = .black
            
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i+1)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            
            imageview.addGestureRecognizer(tap)
            
           
            
            let btnRight = UITapGestureRecognizer(target: self, action: #selector(self.buttonActionRight(_:)))
            imgBtnRight.addGestureRecognizer(btnRight)

            let btnleft = UITapGestureRecognizer(target: self, action: #selector(self.buttonActionLeft(_:)))
            imageBtnLeft.addGestureRecognizer(btnleft)

              imgBtnRight.isUserInteractionEnabled = true
              imageBtnLeft.isUserInteractionEnabled = true

            imageview.isUserInteractionEnabled = true
          
            
            
            
            
          
            
            scrollView.addSubview(imageview)
           
        
        print ("heloo")
        }
        
    }
    
  


    @objc func buttonAction(_ sender: UITapGestureRecognizer) {
 
      self.scrollView.frame = CGRect(x:0, y: 20, width: self.scrollView.frame.size.width, height:222)
       imageCencel.isHidden = true
        imageBtnLeft.frame =  CGRect(x:10, y:scrollView.frame.height/2, width: 30,height:30)
               imgBtnRight.frame =  CGRect(x:scrollView.frame.width-50, y: scrollView.frame.height/2, width: 30,height:30)
    // scrollViewImage()


    }

    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
       // scrollView.frame = CGRect(800)
        imageCencel.isHidden = false
        let btntap = UITapGestureRecognizer(target: self, action: #selector(self.buttonAction(_:)))
                   imageCencel.addGestureRecognizer(btntap)
        imageCencel.isUserInteractionEnabled = true
        self.scrollView.frame = CGRect(x:0, y: 20, width: self.scrollView.frame.size.width, height:800)
        
        imageBtnLeft.frame =  CGRect(x:10, y:scrollView.frame.height/2, width: 30,height:30)
        imgBtnRight.frame =  CGRect(x:scrollView.frame.width-50, y: scrollView.frame.height/2, width: 30,height:30)
        scrollViewImage()

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
