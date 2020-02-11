//
//  Viedo&ChatViewController.swift
//  UeBook
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import JitsiMeet

class Viedo_ChatViewController: UITabBarController {
    
    
    @IBOutlet weak var btnViedoCall: UIButton!
    
    fileprivate var pipViewCoordinator: PiPViewCoordinator?
      fileprivate var jitsiMeetView: JitsiMeetView?
     override func viewDidLoad() {
        super.viewDidLoad()
        let busPhone = "9876543210"
        if let url = URL(string: "tel://\(busPhone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let rect = CGRect(origin: CGPoint.zero, size: size)
        pipViewCoordinator?.resetBounds(bounds: rect)
    }
    
    @IBAction func btnCallViedo(_ sender: Any) {
        // create and configure jitsimeet view
                             let jitsiMeetView = JitsiMeetView()
                             jitsiMeetView.delegate = self
                             self.jitsiMeetView = jitsiMeetView
                             let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                                 builder.welcomePageEnabled = true
                             }
                             jitsiMeetView.join(options)

                             // Enable jitsimeet view to be a view that can be displayed
                             // on top of all the things, and let the coordinator to manage
                             // the view state and interactions
                             pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
                             pipViewCoordinator?.configureAsStickyView(withParentView: view)

                             // animate in
                             jitsiMeetView.alpha = 0
                             pipViewCoordinator?.show()
    }
    
    
   
 

            fileprivate func cleanUp() {
                jitsiMeetView?.removeFromSuperview()
                jitsiMeetView = nil
                pipViewCoordinator = nil
            }
        }

        extension Viedo_ChatViewController: JitsiMeetViewDelegate {
            func conferenceTerminated(_ data: [AnyHashable : Any]!) {
                DispatchQueue.main.async {
                    self.pipViewCoordinator?.hide() { _ in
                        self.cleanUp()
                    }
                }
            }

            func enterPicture(inPicture data: [AnyHashable : Any]!) {
                DispatchQueue.main.async {
                    self.pipViewCoordinator?.enterPictureInPicture()
                }
            }
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


