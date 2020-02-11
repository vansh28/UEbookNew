//
//  Service.swift
//  UeBook
//
//  Created by Admin on 21/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import UIKit
import Alamofire

class ServiceManager: NSObject {

        class func POSTServerRequest(_ queryString: String,andParameters payload: [String: String], success: @escaping (_ response: AnyObject?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
                let formattedSearchString = queryString.replacingOccurrences(of: " ", with:"")
                let urlString = String(format:"%@", formattedSearchString)
                let parameters = payload
                
                print("urlString-----",urlString)
                print("parameters-----",parameters)
                
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    
                    for (key, value) in parameters {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                    
                }, to:urlString)
                { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (Progress) in
                            print("Upload Progress: \(Progress.fractionCompleted)")
                        })
                        
                        upload.responseJSON { response in
                            UIApplication.shared.endIgnoringInteractionEvents()
                            //SKActivityIndicator.dismiss()
                            
                            //self.delegate?.showSuccessAlert()
                            print("Response_Result:--\(response.result)")
                            
                            print(response.request as Any)  // original URL request
                            print(response.response as Any) // URL response
                            print(response.data as Any)     // server data
                            
                            
                            do {
                                if let jsonResult = try JSONSerialization.jsonObject(with: response.data!, options: []) as? NSDictionary {
                                    
                                    success(jsonResult )
                                }
                            } catch let error as NSError
                            {
                                print(error.localizedDescription)
                            }
                        }
                        
                    case .failure(let encodingError):
                        UIApplication.shared.endIgnoringInteractionEvents()
                       // SKActivityIndicator.dismiss()
                        print(encodingError)
                        failure(encodingError as NSError?)
                        
                    }
                }
            }
            
            //  Method for Get request
            
            class func methodGETServerRequest(_ queryString: String, success: @escaping (_ response: AnyObject?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
                
                let formattedSearchString = queryString.replacingOccurrences(of: " ", with:"")
                let urlString = String(format:"%@",formattedSearchString)
                
                Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default)
                    .downloadProgress { progress in
                        print("Progress: \(progress.fractionCompleted)")
                    }
                    .validate { request, response, data in
                        // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                        return .success
                    }
                    .responseJSON { response in
                        debugPrint(response)
                        switch response.result {
                            
                        case .success:
                            print(response)
                            print(response.timeline)
                            
                            do {
                                if let jsonResult = try JSONSerialization.jsonObject(with: response.data!, options: []) as? AnyObject {
                                    
                                    success(jsonResult )
                                    
                                }
                            } catch let error as NSError {
                                print(error.localizedDescription)
                            }
                            
                        case .failure(let error):
                            
                            failure(error as NSError?)
                            
                        }
                }
            }
            
            
            // Method for post request with image
            
            //    class func POSTServerRequestWithImage(_ queryString: String, andcheck: String, andParameters payload: [String: String],andImage uploadImage:(UIImage), success: @escaping (_ response: AnyObject?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
            //        let formattedSearchString = queryString.replacingOccurrences(of: " ", with:"")
            //        let urlString = String(format:"%@", formattedSearchString)
            //        let parameters = payload
            //        var imageParam : String? = nil
            //
            //        print("urlString-----",urlString)
            //        print("parameters-----",parameters)
            //
            //        if andcheck == "First"
            //        {
            //            imageParam = "profile_image"
            //        }
            //        else if andcheck == "Second"
            //        {
            //            imageParam = "image"
            //        }
            //        else
            //        {
            //            print("Do nothing")
            //        }
            //
            //        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //            multipartFormData.append(UIImageJPEGRepresentation(uploadImage, 0.5)!, withName: imageParam!, fileName: "logoOnLogin", mimeType: "image/jpeg")
            //            for (key, value) in parameters {
            //                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            //            }
            //
            //        }, to:urlString)
            //        { (result) in
            //            switch result {
            //            case .success(let upload, _, _):
            //
            //                upload.uploadProgress(closure: { (Progress) in
            //                    print("Upload Progress: \(Progress.fractionCompleted)")
            //                })
            //
            //                upload.responseJSON { response in
            //
            //                    do {
            //                        if let jsonResult = try JSONSerialization.jsonObject(with: response.data!, options: []) as? NSDictionary {
            //
            //                            success(jsonResult )
            //
            //                        }
            //                    } catch let error as NSError {
            //                        print(error.localizedDescription)
            //                    }
            //                }
            //
            //            case .failure(let encodingError):
            //                //self.delegate?.showFailAlert()
            //                print(encodingError)
            //                failure(encodingError as NSError?)
            //
            //            }
            //        }
            //    }
            class func POSTServerRequestWithImage(_ queryString: String,andParameters payload: [String: String],andImage uploadImage:(UIImage), imagePara:String, success: @escaping (_ response: AnyObject?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
                let formattedSearchString = queryString.replacingOccurrences(of: " ", with:"")
                let urlString = String(format:"%@", formattedSearchString)
                let parameters = payload
                
                print("urlString-----",urlString)
                print("parameters-----",parameters)
                
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    multipartFormData.append(uploadImage.jpegData(compressionQuality: 0.50)!, withName: imagePara, fileName: "image.jpeg", mimeType: "image/jpeg")
                    for (key, value) in parameters {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                    
                }, to:urlString)
                { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (Progress) in
                            print("Upload Progress: \(Progress.fractionCompleted)")
                        })
                        
                        upload.responseJSON { response in
                            
                            print("Response_Result:--\(response.result)")
                            do {
                                if let jsonResult = try JSONSerialization.jsonObject(with: response.data!, options: []) as? NSDictionary {
                                    
                                    success(jsonResult )
                                }
                            } catch let error as NSError {
                                print(error.localizedDescription)
                                
                            }
                        }
                        
                    case .failure(let encodingError):
                        
                        print(encodingError)
                        failure(encodingError as NSError?)
                        
                    }
                }
            }
        }
