//
//  LoginViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 16/12/19.
//  Copyright © 2019 Arun Vijayan. All rights reserved.
//

import UIKit
import GoogleSignIn
import MBProgressHUD


extension UIViewController {

    func showToast(message : String, font: UIFont , duration: Double) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/4 - 85, y: self.view.frame.size.height-100, width: UIScreen.main.bounds.width-30, height: 40))
    //toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.backgroundColor = UIColor.darkGray
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 5;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 7, delay: 1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }




@available(iOS 13.0, *)
class LoginViewController: UIViewController {

   
    @IBOutlet weak var btnaccepttrms: UIButton!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var txtfldenteremail: UITextField!
    
    @IBOutlet weak var txtfldenterpassword: UITextField!
    @IBOutlet weak var viewlogin: UIView!
    var device_id=String()
    var device_token=String()
    
    var searchroom_flag=Int()
    var hud:MBProgressHUD!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font : UIFont(name: "ProximaNova-Bold", size: 14)! // Note the !
        ]

        txtfldenteremail.attributedPlaceholder = NSAttributedString(string: "Enter Mail id", attributes:attributes)
        txtfldenterpassword.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes:attributes)

        self.viewlogin.frame = CGRect(x: 0, y: 490, width: 377, height: 178)
       
        
        
       
       
    }
    override func viewWillAppear(_ animated: Bool){
    super.viewWillAppear(animated)
       UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
            self.viewlogin.frame = CGRect(x: 0, y: 200, width: 377, height: 178)
        }) { finished in
        }
        view.addSubview(viewlogin)
         self.navigationController?.isNavigationBarHidden = true
        
        if let  deviceid=UserDefaults.standard.value(forKey: "device_id"){
            device_id=UserDefaults.standard.value(forKey: "device_id") as! String
        }
        if let devicetoken=UserDefaults.standard.value(forKey: "fcm_token"){
            device_token=UserDefaults.standard.value(forKey: "fcm_token") as! String
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
          }
    
    
    
    @IBAction func btntermsaction(_ sender: Any) {
        if btnaccepttrms.currentImage==UIImage(named: "bag"){
            btnaccepttrms.setImage(UIImage(named:"icons8-chevron-right-30"), for: .normal)
        }else{
            btnaccepttrms.setImage(UIImage(named:"icons8-chevron-right-30"), for: .normal)
        }
        
    }
    
    @IBAction func btnbackaction(_ sender: Any) {
          self.navigationController?.popViewController(animated: true)
    }
    
    
    func service_user_login(){
        self.showhud()
           guard let url=NSURL(string :"https://niyaregency.com/api/Data/user_login")else{return}
        let poststring="email=\(txtfldenteremail.text!)&password=\(txtfldenterpassword.text!)&security_token=niya32jfhdu392nfbfdr&device_id=\(device_id)&device_token=\(device_token)&device_type=2"
            var request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.httpBody = poststring.data(using: String.Encoding.utf8)
            let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
    print("poststring",poststring)
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
                    if status==true{
                    let dataarray=parseJson["data"] as! NSDictionary
                        let user_id=dataarray["user_id"] as! String
                        let user_cat=dataarray["user_cat"] as! String
                        let user_name=dataarray["user_name"] as! String
                        let offer=dataarray["offer"] as! String
                        print("user_id",user_id)
                        let gst=dataarray["gst"] as! String
                        let useremail=dataarray["user_email"] as! String
                         let paymentstatus=dataarray["payment_status"] as! String
                        let mobile=dataarray["mobile"] as! String
                        UserDefaults.standard.set(paymentstatus, forKey:"paymentstatus")
                        UserDefaults.standard.set(user_id, forKey: "useridfororderhistory")
                         UserDefaults.standard.set("2", forKey: "typeorderhistory")
                        
                        UserDefaults.standard.set(user_id, forKey:"userid")
                        UserDefaults.standard.set(user_cat, forKey:"usercatid")
                        UserDefaults.standard.set(user_name, forKey:"username")
                        UserDefaults.standard.set(gst, forKey:"usergst")
                        UserDefaults.standard.set(offer, forKey:"useroffer")
                        UserDefaults.standard.set(useremail, forKey:"useremail")
                         UserDefaults.standard.set(mobile, forKey:"usermobile")
                        
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            if self.searchroom_flag==1{
                        let searchroom = self.storyboard?.instantiateViewController (withIdentifier: "SearchroomsViewController") as! SearchroomsViewController
                                                   
                        self.navigationController?.pushViewController(searchroom, animated: true)
                            }else if self.searchroom_flag==2{
                            let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
                                                                                  
                            self.navigationController?.pushViewController(productlisting, animated: true)
                            }else if self.searchroom_flag==3{
                                let expandcollapse = self.storyboard?.instantiateViewController (withIdentifier: "ExpandcollapseViewController") as! ExpandcollapseViewController
                                                                                                                 
                                    self.navigationController?.pushViewController(expandcollapse, animated: true)
                            }else{
                                let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
                                    self.navigationController?.pushViewController(home, animated: true)
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                              self.hud.hide(animated: true)
                            self.showToast(message: "Invalid email or password", font: UIFont.boldSystemFont(ofSize: 14),duration: 2)
                        }
                        }
                    }
                }
                                 catch {
                                 print(error)
                                 }
                                                               
                        }.resume()
                    }
    
    
    
    
    @IBAction func btnsigninaction(_ sender: Any) {
        if txtfldenteremail.text==""||txtfldenteremail.text==nil{
            self.showToast(message: "Please enter registered email id", font: UIFont.boldSystemFont(ofSize: 14),duration: 2)
            
        }else  if txtfldenterpassword.text==""||txtfldenterpassword.text==nil{
                   self.showToast(message: "Please enter password", font: UIFont.boldSystemFont(ofSize: 14),duration: 2)
            
//        }else  if
//            btnaccepttrms.currentImage==UIImage(named: "bag"){
//            self.showToast(message: "Please accept terms&conditions to continue", font: UIFont.boldSystemFont(ofSize: 14),duration: 2)
            
        }else{
            service_user_login()
        }
    }
    
    func showhud(){
                        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                           hud.mode = MBProgressHUDMode.indeterminate
                       }
    
    @IBAction func btnforgotpassword(_ sender: Any) {
        let forgotpassword = self.storyboard?.instantiateViewController (withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        
        self.navigationController?.pushViewController(forgotpassword, animated: true)
    }
    
}
