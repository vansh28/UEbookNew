//
//  ImageZoomInZoomOutViewController.swift
//  UeBook
//
//  Created by Admin on 28/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ImageZoomInZoomOutViewController: UIViewController ,UIScrollViewDelegate ,UIGestureRecognizerDelegate{
    
    
    
    //var params = SelectionParameters()
    var image: UIImage? = nil
    private var croppedImage: UIImage? = nil

    var currentTransform: CGAffineTransform? = nil
    var pinchStartImageCenter: CGPoint = CGPoint(x: 0, y: 0)
    let maxScale: CGFloat = 4.0
    let minScale: CGFloat = 1.0
    var currentScale: CGFloat = 1.0
    var pichCenter: CGPoint = CGPoint(x: 0, y: 0)
    
    var width:CGFloat = 0
    var height:CGFloat = 0
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    

    @IBOutlet weak var ImgeView: UIImageView!

    
    @IBOutlet weak var btnBack: UIButton!
    let scrollImg: UIScrollView = UIScrollView()
    @IBOutlet weak var lblName: UILabel!
    var name = String()
    var imageurl :URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        let vWidth = self.view.frame.width
        let vHeight = self.view.frame.height
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x: 10, y:80, width: vWidth-40, height: vHeight-120)
        scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()

        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        lblName.text = name
       // view!.addSubview(scrollImg)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        tap.numberOfTapsRequired = 2
        ImgeView.addGestureRecognizer(tap)
        ImgeView!.layer.cornerRadius = 11.0
        ImgeView!.clipsToBounds = false
        ImgeView.image = image
       // scrollImg.addSubview(ImgeView!)
        DispatchQueue.main.async {
            
            
            self.getData(from: self.imageurl) { data, response, error in
                guard let data = data, error == nil else {
                    self.ImgeView.image = #imageLiteral(resourceName: "noimage")
                    return }
                print(response?.suggestedFilename ?? self.imageurl.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() {
                    // imgView
                    //self.BookImage.image = UIImage(data: data)
                    self.ImgeView?.af_setImage(withURL:self.imageurl , placeholderImage:#imageLiteral(resourceName: "noimage") )
                    
                }
            }
        }

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        let scale = min(scrollImg.zoomScale * 2, scrollImg.maximumZoomScale)

        if scale != scrollImg.zoomScale { // zoom in
            let point = recognizer.location(in: ImgeView)

            let scrollSize = scrollImg.frame.size
            let size = CGSize(width: scrollSize.width / scrollImg.maximumZoomScale,
                              height: scrollSize.height / scrollImg.maximumZoomScale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollImg.zoom(to:CGRect(origin: origin, size: size), animated: true)
        } else if scrollImg.zoomScale == 1 { //zoom out
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: ImgeView)), animated: true)
        }
    }

    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = ImgeView.frame.size.height / scale
        zoomRect.size.width  = ImgeView.frame.size.width  / scale
        let newCenter = scrollImg.convert(center, from: ImgeView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
          URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
      }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.ImgeView
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
