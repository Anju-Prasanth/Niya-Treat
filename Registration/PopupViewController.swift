//
//  PopupViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 18/12/19.
//  Copyright © 2019 Arun Vijayan. All rights reserved.
//

import UIKit
import MBProgressHUD

@available(iOS 13.0, *)
class PopupViewController: UIViewController {
    var username=String()
    var useremail=String()
    var mobile=String()
    var password=String()
    var usertype=String()
    var address=String()
    var gst=String()
    var newpasswordfalg=Int()
    var searchroomflag=Int()
    
    @IBOutlet weak var btncontinueforotp: UIButton!
    @IBOutlet weak var btncancelforotp: UIButton!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var txtfldotp: UITextField!
    var hud:MBProgressHUD!
    
    var device_id=String()
    var device_token=String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btncancelforotp.layer.cornerRadius=10
         btncontinueforotp.layer.cornerRadius=10
        print("newpasswordfalg",newpasswordfalg)
        if newpasswordfalg==0{
            let parent=self.parent as! RegistrationViewController
            username=parent.txtfldentername.text!
            useremail=parent.txtfldenteremail.text!
            mobile=parent.txtfldenterphone.text!
            password=parent.txtfldenterpassword.text!
            usertype=parent.usertype
            print("usertype",usertype)
            if usertype=="4"{
            address=parent.txtviewenteradress.text!
            gst=parent.txtfldentergst.text!
        }
            lblemail.text=parent.email
        }else{
            let parent=self.parent as! ForgotPasswordViewController
           // mobile=parent.
            mobile=parent.txtfldemailid.text!
            lblemail.text=mobile
        }
        
        if let  deviceid=UserDefaults.standard.value(forKey: "device_id"){
            device_id=UserDefaults.standard.value(forKey: "device_id") as! String
        }
        if let devicetoken=UserDefaults.standard.value(forKey: "fcm_token"){
            device_token=UserDefaults.standard.value(forKey: "fcm_token") as! String
        }
        
        
    }
    
    
    
    func service_otp_verification_new(){
        
        self.showhud()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/otp_verification_new")else{return}
        let poststring="mobile=\(mobile)&otp=\(txtfldotp.text!)"
        print("poststring",poststring)
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
                    //  let message=parseJson["message"]as! String
                    if status==true{
                        
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            
                            let cretepassword = self.storyboard?.instantiateViewController (withIdentifier: "CreatepasswordViewController") as! CreatepasswordViewController
                            cretepassword.searchroom_flag=self.searchroomflag
                            self.navigationController?.pushViewController(cretepassword, animated: true)
                        }
                        
                    }else{
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.showToast(message: "Invalid OTP", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                            
                        }
                    }
                }
                
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    
    
    
    
    
    func service_insert_user(){
        self.showhud()
        var postring=String()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/insert_user")else{return}
        if usertype=="4"{
        postring="user_name=\(username)&user_email=\(useremail)&mobile=\(mobile)&password=\(password)&user_type=\(usertype)&address=\(address)&gst=\(gst)&otp=\(txtfldotp.text!)&security_token=niya32jfhdu392nfbfdr&device_id=\(device_id)&device_token=\(device_token)&device_type=2"
        }else{
            postring="user_name=\(username)&user_email=\(useremail)&mobile=\(mobile)&password=\(password)&user_type=\(usertype)&address=\(address)&gst=\(gst)&otp=\(txtfldotp.text!)&security_token=niya32jfhdu392nfbfdr&device_id=\(device_id)&device_token=\(device_token)&device_type=2"
        }
        print("postring",postring)
        var request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = postring.data(using: String.Encoding.utf8)
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
                    let message=parseJson["message"]as! String
                    if status==true{
                        let dataarray=parseJson["data"] as! NSDictionary
                        let user_id=dataarray["user_id"] as! String
                        let user_cat=dataarray["user_cat"] as! String
                        let user_name=dataarray["user_name"] as! String
                        let offer=dataarray["offer"] as! String
                        let mobile=dataarray["mobile"] as! String
                        
                        print("user_id",user_id)
                        let gst=dataarray["gst"] as! String
                        let useremail=dataarray["user_email"] as! String
                        let paymentstatus=dataarray["payment_status"] as! String
                        UserDefaults.standard.set(user_id, forKey:"useridorderhistory")
                        UserDefaults.standard.set("2", forKey:"typeorderhistory")
                        UserDefaults.standard.set(paymentstatus, forKey:"paymentstatus")
                        UserDefaults.standard.set(user_id, forKey:"userid")
                        UserDefaults.standard.set(user_cat, forKey:"usercatid")
                        UserDefaults.standard.set(user_name, forKey:"username")
                        UserDefaults.standard.set(gst, forKey:"usergst")
                        UserDefaults.standard.set(offer, forKey:"useroffer")
                        UserDefaults.standard.set(useremail, forKey:"useremail")
                         UserDefaults.standard.set(mobile, forKey:"usermobile")
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            
                            if self.searchroomflag==1{
                                let searchroom = self.storyboard?.instantiateViewController (withIdentifier: "SearchroomsViewController") as! SearchroomsViewController
                                self.navigationController?.pushViewController(searchroom, animated: true)
                                
                            }else if self.searchroomflag==2{
                                let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
                                self.navigationController?.pushViewController(productlisting, animated: true)
                            }else if self.searchroomflag==3{
                                
                                let expandcollapse = self.storyboard?.instantiateViewController (withIdentifier: "ExpandcollapseViewController") as! ExpandcollapseViewController
                                self.navigationController?.pushViewController(expandcollapse, animated: true)
                                
                            }else{
                                
                                let homepage = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
                                self.navigationController?.pushViewController(homepage, animated: true)
                            }
                        }
                        
                    }else{
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.showToast(message: "Invalid OTP", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                            
                        }
                    }
                }
                
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    @IBAction func btncontinue(_ sender: Any) {
        if newpasswordfalg==1{
            service_otp_verification_new()
        }else{
            service_insert_user()
        }
    }
    
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    @IBAction func btnresendotpaction(_ sender: Any) {
        service_insert_user_otp()
    }
    
    
    @IBAction func btnchangenumberaction(_ sender: Any) {
      
          
            self.view.removeFromSuperview()
           

        
    }
    
    
    @IBAction func btncancelotpaction(_ sender: Any) {
         self.view.removeFromSuperview()
    }
    func service_insert_user_otp(){
            self.showhud()
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/insert_user_otp")else{return}
            var poststring=String()
            if usertype=="4"{
            poststring="user_name=\(username)&user_email=\(useremail)&mobile=\(mobile)&security_token=niya32jfhdu392nfbfdr&gst=\(gst)"
            }else{
                poststring="user_name=\(username)&user_email=\(useremail)&mobile=\(mobile)&security_token=niya32jfhdu392nfbfdr"
            }
           print("poststring",poststring)
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
                                let message=parseJson["message"]as! String
                            if status==true{
                            let dataarray=parseJson["data"] as! NSDictionary
                           
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
                                self.hud.hide(animated: true)
                                
                                }
                                
                            }else{
                                DispatchQueue.main.async {
                                //self.btnsignup.isUserInteractionEnabled==true
                                     self.hud.hide(animated: true)
                                    self.showToast(message: message, font: UIFont.boldSystemFont(ofSize: 12), duration: 2)
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
