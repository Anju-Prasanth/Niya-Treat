//
//  ForgotPasswordViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 22/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var btnalreadyhaveanaccount: UIButton!
    @IBOutlet weak var btnsendotp: UIButton!
    
    @IBOutlet weak var txtfldemailid: UITextField!
    var otp=Int()
    var email=String()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
           let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                NSAttributedString.Key.font : UIFont(name: "ProximaNova-Bold", size: 14)! // Note the !
            ]

            txtfldemailid.attributedPlaceholder = NSAttributedString(string: "Enter Phone Number", attributes:attributes)
         
    }
    
    override func viewWillAppear(_ animated: Bool){
       super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
             super.viewWillAppear(animated)
           self.navigationController?.isNavigationBarHidden = false
             }
    
   
    @IBAction func btnalreadyanaccountaction(_ sender: Any) {
        
        let login = self.storyboard?.instantiateViewController (withIdentifier: "LoginViewController") as! LoginViewController
                                   
        self.navigationController?.pushViewController(login, animated: true)
    }
    @IBAction func btnbackaction(_ sender: Any) {
             self.navigationController?.popViewController(animated: true)
       }
    
    @IBAction func btnsendotpaction(_ sender: Any) {
       if (txtfldemailid.text == ""){

        self.showToast(message: "Please enter your phone number", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)

        }
        else if(txtfldemailid.text!.count < 10)||(txtfldemailid.text!.count > 10){
         self.showToast(message: "Please enter a valid Phone Number", font: UIFont.boldSystemFont(ofSize: 13), duration: 2)
              
        }
        else{
            
            service_forgot_password_new()
        
    }
    }
        
        
        func isValidEmail(testStr:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
    
    
    
    
//    func service_insert_user_otp(){
//
//            guard let url=NSURL(string :"https://niyaregency.com/api/Data/insert_user_otp")else{return}
//                let poststring="user_name=&user_email=\(txtfldemailid.text!)&mobile=&security_token=niya32jfhdu392nfbfdr"
//                       var request = NSMutableURLRequest(url: url as URL)
//                       request.httpMethod = "POST"
//                       request.httpBody = poststring.data(using: String.Encoding.utf8)
//                       let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
//
//                           if error != nil{
//                               print("error",error)
//                               return
//                           }
//                           let responsestring=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//
//                           print("respnsedate,\(responsestring)")
//
//                           do{
//                           let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers)as? NSDictionary
//                            if let parseJson = jsonarray{
//                            let status=parseJson["status"]as! Bool
//                            if status==true{
//                            let dataarray=parseJson["data"] as! NSDictionary
//                            self.otp=dataarray.value(forKey: "otp") as! Int
//                            self.email=dataarray.value(forKey: "user_email") as! String
//                            DispatchQueue.main.async {
//                           // self.lblemail.text=self.email
//    //                        self.viewpopup.isHidden=false
//    //                           // UIScreen.main.brightness = CGFloat(0.2)
//    //                            self.btnsignup.isUserInteractionEnabled==false
//    //                            self.dimview.backgroundColor=UIColor.black
//    //                            self.dimview.alpha = 0.2
//    //
//    //                        UIView.animate(withDuration: 1) {
//    //                        self.viewpopup.center.y -= self.viewpopup.frame.height-250
//    //                            }
//    //
//    //                            }
////                                self.service_insert_user_otp()
//                                self.showpopup()
//                                }
//
//                            }else{
//                                DispatchQueue.main.async {
//                                //self.btnsignup.isUserInteractionEnabled==true
//                                    self.showToast(message: "Email id/Mobile number already exist!!", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
//                                }
//                                }
//                            }
//
//                           }
//                            catch {
//                            print(error)
//                            }
//
//                                   }.resume()
//                               }
               

           
        
            
            func showpopup(){
                
                let popvc=self.storyboard?.instantiateViewController(withIdentifier: "popup")as! PopupViewController
                self.addChild(popvc)
                popvc.newpasswordfalg=1
                
                popvc.view.frame=self.view.frame
                self.view.addSubview(popvc.view)
                popvc.didMove(toParent: self)
                
                
            }
    
    
    
    func service_forgot_password_new(){
       
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/forgot_password_new")else{return}
                let poststring="mobile=\(txtfldemailid.text!)"
                       var request = NSMutableURLRequest(url: url as URL)
                       request.httpMethod = "POST"
                       request.httpBody = poststring.data(using: String.Encoding.utf8)
                       let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
               
                           if error != nil{
                               print("error",error)
                               return
                           }
                           let responsestring=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                           
                           print("respnsedate,\(responsestring)")
                        
                           do{
                           let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers)as? NSDictionary
                            if let parseJson = jsonarray{
                            let status=parseJson["status"]as! Bool
                            let message=parseJson["message"] as! String
                            if status==true{
//                            let dataarray=parseJson["data"] as! NSDictionary
//                            self.otp=dataarray.value(forKey: "otp") as! Int
//                            self.email=dataarray.value(forKey: "user_email") as! String
                            DispatchQueue.main.async {
                           // self.lblemail.text=self.email
    //                        self.viewpopup.isHidden=false
    //                           // UIScreen.main.brightness = CGFloat(0.2)
    //                            self.btnsignup.isUserInteractionEnabled==false
    //                            self.dimview.backgroundColor=UIColor.black
    //                            self.dimview.alpha = 0.2
    //
    //                        UIView.animate(withDuration: 1) {
    //                        self.viewpopup.center.y -= self.viewpopup.frame.height-250
    //                            }
    //
    //                            }
//                                 self.service_insert_user_otp()
                                self.showpopup()
                                }
                                
                            }else{
                                DispatchQueue.main.async {
                                //self.btnsignup.isUserInteractionEnabled==true
                                    self.showToast(message: message, font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                }
                                }
                            }
                    
                           }
                            catch {
                            print(error)
                            }
                                                                          
                                   }.resume()
                               }
               

       

}
