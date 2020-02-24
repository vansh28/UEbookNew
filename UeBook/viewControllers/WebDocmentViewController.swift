//
//  WebDocmentViewController.swift
//  UeBook
//
//  Created by Admin on 24/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class WebDocmentViewController: UIViewController , WKNavigationDelegate {
    var activityIndicator : NVActivityIndicatorView!

    var DocumentBookUrl = String()
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {

            let stringUrl = "https://" + self.DocumentBookUrl
        let docURl = URL(string:stringUrl)
     
        let xAxis = self.view.center.x // or use (view.frame.size.width / 2) // or use (faqWebView.frame.size.width / 2)
        let yAxis = self.view.center.y
        
        let frame = CGRect(x: xAxis, y: yAxis, width: 45, height: 45)

            self.activityIndicator = NVActivityIndicatorView(frame:frame)
            self.activityIndicator.type = . ballClipRotateMultiple // add your type
            self.activityIndicator.color = UIColor.red // add your color

            self.view.addSubview(self.activityIndicator) // or use  webView.addSubview(activityIndicator)
            self.activityIndicator.startAnimating()
        
            self.webView.navigationDelegate = self
            self.webView.load(URLRequest(url: docURl!))//URL(string: "http://") for web URL

        }
        
        // Do any additional setup after loading the view.
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
     }

    @IBAction func btnBack(_ sender: Any) {
        
         self.dismiss(animated: true, completion: nil)
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
