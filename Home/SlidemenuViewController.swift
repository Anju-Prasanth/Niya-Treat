//
//  SlidemenuViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 19/12/19.
//  Copyright © 2019 Arun Vijayan. All rights reserved.
//

import UIKit
import MBProgressHUD


@available(iOS 13.0, *)
class SlidemenuViewController: UIViewController {
    @IBOutlet weak var btnlogout: UIButton!
    
    @IBOutlet weak var btnchangenumber: UIButton!
    @IBOutlet weak var btnresendotp: UIButton!
    @IBOutlet weak var btncontinueforotp: UIButton!
    @IBOutlet weak var btncancelforotp: UIButton!
    @IBOutlet weak var txtfldotp: UITextField!
    @IBOutlet weak var lblphonenumberforotp: UILabel!
    @IBOutlet weak var viewotp: UIView!
    @IBOutlet weak var viewprofileeditheight: NSLayoutConstraint!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblnumber: UILabel!
    @IBOutlet weak var lblname: UILabel!
    var username=String()
    var useremail=String()
    var usermobile=String()
    var userid=String()
    var usercatid=String()
    var hud:MBProgressHUD!
    
    @IBOutlet weak var txtfldmobile: UITextField!
    @IBOutlet weak var txtfldemail: UITextField!
    @IBOutlet weak var txtfldname: UITextField!
    @IBOutlet weak var viewprofileedit: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtfldemail.isUserInteractionEnabled=false
        txtfldname.isUserInteractionEnabled=false
        txtfldmobile.isUserInteractionEnabled=false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btncancelforotp.layer.cornerRadius=10
        btncontinueforotp.layer.cornerRadius=10
        btnedit.setTitle("Edit", for: .normal)
        txtfldemail.isUserInteractionEnabled=false
        txtfldname.isUserInteractionEnabled=false
        txtfldmobile.isUserInteractionEnabled=false
        self.btncancel.isHidden=true
        if let usercat=UserDefaults.standard.value(forKey: "usercatid"){
            usercatid=UserDefaults.standard.value(forKey: "usercatid") as! String
            
        }
        if let id=UserDefaults.standard.value(forKey: "userid"){
            if usercatid=="2"||usercatid=="0"{
                viewprofileedit.isHidden=true
                viewprofileeditheight.constant=10
            }else{
                viewprofileedit.isHidden=false
                viewprofileeditheight.constant=134
            }
            if (id as AnyObject).isEmpty==true{
                
            }else{
                btnlogout.setTitle("Logout", for: .normal)
            }
        }else{
            viewprofileedit.isHidden=true
            viewprofileeditheight.constant=0
            btnlogout.setTitle("Login", for: .normal)
        }
        if let user_name=UserDefaults.standard.value(forKey: "username"){
            username=UserDefaults.standard.value(forKey: "username") as! String
            txtfldname.text=username
        }
        if let user_email=UserDefaults.standard.value(forKey: "useremail"){
            useremail=UserDefaults.standard.value(forKey: "useremail") as! String
            txtfldemail.text=useremail
        }
        if let user_mobile=UserDefaults.standard.value(forKey: "usermobile"){
            usermobile=UserDefaults.standard.value(forKey: "usermobile") as! String
            txtfldmobile.text=usermobile
        }
        if let user_id=UserDefaults.standard.value(forKey: "userid"){
            userid=UserDefaults.standard.value(forKey: "userid") as! String
            
        }
        
    }
    
    
    @IBAction func btntermsandcondtion(_ sender: Any) {
        
        let termsandcondition = self.storyboard?.instantiateViewController (withIdentifier: "Terms_conditionViewController") as! Terms_conditionViewController
        
        let nc = revealViewController().frontViewController as! UINavigationController
        nc.pushViewController(termsandcondition, animated: false)
        termsandcondition.termsflag=1
        revealViewController().pushFrontViewController(nc, animated: true)
        
        
    }
    
    
    @IBAction func btnhomeaction(_ sender: Any) {
        
        let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as!  HomepageViewController
        let nc = revealViewController().frontViewController as! UINavigationController
        nc.pushViewController(home, animated: false)
        revealViewController().pushFrontViewController(nc, animated: true)
        
    }
    
    @IBAction func btnmyprofileaction(_ sender: Any) {
        let myprofile = self.storyboard?.instantiateViewController (withIdentifier: "ProfileeditViewController") as!  ProfileeditViewController
        let nc = revealViewController().frontViewController as! UINavigationController
        nc.pushViewController(myprofile, animated: false)
        revealViewController().pushFrontViewController(nc, animated: true)
        
    }
    
    @IBAction func btncancelaction(_ sender: Any) {
        
        txtfldmobile.isUserInteractionEnabled=false
        txtfldemail.isUserInteractionEnabled=false
        txtfldname.isUserInteractionEnabled=false
        btnedit.setTitle("Edit", for: .normal)
        btncancel.isHidden=true
        
        
    }
    @IBAction func btneditaction(_ sender: Any) {
        
        if btnedit.currentTitle=="Save"{
            
            service_profile_edit_otp()
            
            btncancel.isHidden=true
        }else{
            
            btnedit.setTitle("Save", for: .normal)
            txtfldmobile.isUserInteractionEnabled=true
            txtfldemail.isUserInteractionEnabled=true
            txtfldname.isUserInteractionEnabled=true
            btncancel.isHidden=false
        }
        
        
    }
    
    @IBAction func btnlogoutaction(_ sender: Any) {
        if btnlogout.currentTitle=="Login"{
            let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as!  LaunchscreenViewController
            let nc = self.revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(launch, animated: false)
            self.revealViewController().pushFrontViewController(nc, animated: true)
        }else{
            var refreshAlert = UIAlertController(title: "Do you want to Logout?", message: "", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as!  LaunchscreenViewController
                
                
                
                
                UserDefaults.standard.removeObject(forKey: "adultnumber")
                UserDefaults.standard.removeObject(forKey: "childnumber")
                UserDefaults.standard.removeObject(forKey: "roomnumbers")
                UserDefaults.standard.removeObject(forKey: "applyflagroom")
                UserDefaults.standard.removeObject(forKey: "totaladult")
                UserDefaults.standard.removeObject(forKey: "totalchild")
                UserDefaults.standard.removeObject(forKey: "roomcountarray")
                UserDefaults.standard.removeObject(forKey: "applyflag")
                
                
                
                
                
                UserDefaults.standard.removeObject(forKey:"userid")
                UserDefaults.standard.removeObject(forKey:"usercatid")
                UserDefaults.standard.removeObject(forKey:"username")
                UserDefaults.standard.removeObject(forKey:"usergst")
                UserDefaults.standard.removeObject(forKey:"useroffer")
                UserDefaults.standard.removeObject(forKey:"useremail")
                UserDefaults.standard.removeObject(forKey:"paymentstatus")
                UserDefaults.standard.removeObject(forKey: "myarray")
                UserDefaults.standard.removeObject(forKey: "carttotalprice")
                UserDefaults.standard.removeObject(forKey: "partyorderarray")
                // UserDefaults.standard.removeObject(forKey: "nonvegitemarray")
                UserDefaults.standard.removeObject(forKey: "itemnames")
                UserDefaults.standard.removeObject(forKey: "mainmenuitemarraycart")
                UserDefaults.standard.removeObject(forKey: "roomlistarray")
                UserDefaults.standard.removeObject(forKey: "maindictionaryroom")
                UserDefaults.standard.removeObject(forKey: "roomlistdictionary")
                UserDefaults.standard.removeObject(forKey: "productarray")
                UserDefaults.standard.removeObject(forKey: "productlistdictionary")
                UserDefaults.standard.removeObject(forKey: "maindictionary")
                UserDefaults.standard.removeObject(forKey:"roomavailablearry")
                UserDefaults.standard.removeObject(forKey:"useridforapple")
                let nc = self.revealViewController().frontViewController as! UINavigationController
                nc.pushViewController(launch, animated: false)
                self.revealViewController().pushFrontViewController(nc, animated: true)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                
                
                let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as!  HomepageViewController
                let nc = self.revealViewController().frontViewController as! UINavigationController
                nc.pushViewController(home, animated: false)
                self.revealViewController().pushFrontViewController(nc, animated: true)
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    
    
    func service_profile_edit(){
        var usernameedited=String()
        var mobileedited=String()
        if txtfldname.text?.isEmpty==true{
            
        }else{
            usernameedited=txtfldname.text!
        }
        if txtfldmobile.text?.isEmpty==true{
            
        }else{
            mobileedited=txtfldmobile.text!
        }
        // self.showhud()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/profile_edit")else{return}
        let poststring="user_id=\(userid)&mobile=\(mobileedited)&security_token=niya32jfhdu392nfbfdr&user_name=\(usernameedited)"
        var request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
            
            if error != nil{
                print("error",error)
                return
            }
            print("poststring",poststring)
            let responsestring=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            print("respnsedate,\(responsestring)")
            
            do{
                let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers)as? NSDictionary
                if let parseJson = jsonarray{
                    let status=parseJson["status"]as! Bool
                    if status==true{
                        DispatchQueue.main.async {
                            // self.hud.hide(animated: true)
                            self.showToast(message: "Successfully updated", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        }
                        
                    }else{
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        //  self.hud.hide(animated: true)
                        self.showToast(message: "Something went wrong", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                    }
                }
            }
                
            catch {
                print(error)
            }
            
        }.resume()
        
        
    }
    
    
    
    func service_profile_edit_otp(){
        
        var mobileedited=String()
        
        if txtfldmobile.text?.isEmpty==true{
            
        }else{
            mobileedited=txtfldmobile.text!
        }
         self.showhud()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/profile_edit_otp")else{return}
        let poststring="user_id=\(userid)&mobile=\(mobileedited)&security_token=niya32jfhdu392nfbfdr"
        var request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
            
            if error != nil{
                print("error",error)
                return
            }
            print("poststring",poststring)
            let responsestring=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            print("respnsedate,\(responsestring)")
            
            do{
                let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers)as? NSDictionary
                if let parseJson = jsonarray{
                    let status=parseJson["status"]as! Bool
                    let message=parseJson["message"]as! String
                    if status==true{
                        DispatchQueue.main.async {
                             self.hud.hide(animated: true)
                            self.viewotp.isHidden=false
                            self.lblphonenumberforotp.text=mobileedited
                            
                        }
                        
                    }else{
                        DispatchQueue.main.async {
                             self.hud.hide(animated: true)
                            self.viewotp.isHidden=true
                            self.showToast(message: message, font: UIFont.boldSystemFont(ofSize: 12), duration: 2)
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                          self.hud.hide(animated: true)
                        self.showToast(message: "Something went wrong", font: UIFont.boldSystemFont(ofSize: 12), duration: 2)
                    }
                }
            }
                
            catch {
                print(error)
            }
            
        }.resume()
        
        
    }
    
    
    func service_profile_edit_new(){
        var usernameedited=String()
        var mobileedited=String()
        if txtfldname.text?.isEmpty==true{
            
        }else{
            usernameedited=txtfldname.text!
        }
        if txtfldmobile.text?.isEmpty==true{
            
        }else{
            mobileedited=txtfldmobile.text!
        }
         self.showhud()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/profile_edit_new")else{return}
        let poststring="user_id=\(userid)&mobile=\(mobileedited)&security_token=niya32jfhdu392nfbfdr&user_name=\(usernameedited)&otp=\(txtfldotp.text!)"
        var request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
            
            if error != nil{
                print("error",error)
                return
            }
            print("poststring",poststring)
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
                        print("user_id",user_id)
                        let gst=dataarray["gst"] as! String
                        let useremail=dataarray["user_email"] as! String
                        let paymentstatus=dataarray["payment_status"] as! String
                        let mobile=dataarray["mobile"] as! String
                        UserDefaults.standard.set(paymentstatus, forKey:"paymentstatus")
                       // UserDefaults.standard.set(user_id, forKey: "useridfororderhistory")
                        UserDefaults.standard.set("2", forKey: "typeorderhistory")
                        
                       // UserDefaults.standard.set(user_id, forKey:"userid")
                        UserDefaults.standard.set(user_cat, forKey:"usercatid")
                        UserDefaults.standard.set(user_name, forKey:"username")
                        UserDefaults.standard.set(gst, forKey:"usergst")
                        UserDefaults.standard.set(offer, forKey:"useroffer")
                        UserDefaults.standard.set(useremail, forKey:"useremail")
                        UserDefaults.standard.set(mobile, forKey:"usermobile")
                        
                        
                        
                        
                        
                        
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.viewotp.isHidden=true
                            self.showToast(message: message, font: UIFont.boldSystemFont(ofSize: 12), duration: 2)
                            self.btnedit.setTitle("Edit", for: .normal)
                            self.btncancel.isHidden=true
                            self.txtfldmobile.isUserInteractionEnabled=false
                            self.txtfldemail.isUserInteractionEnabled=false
                            self.txtfldname.isUserInteractionEnabled=false
                            
                        }
                        
                    }else{
                        DispatchQueue.main.async {
                             self.hud.hide(animated: true)
                            self.viewotp.isHidden=true
                            self.btnedit.setTitle("Edit", for: .normal)
                            self.btncancel.isHidden=true
                            self.txtfldmobile.isUserInteractionEnabled=false
                            self.txtfldemail.isUserInteractionEnabled=false
                            self.txtfldname.isUserInteractionEnabled=false
                            self.showToast(message: message, font: UIFont.boldSystemFont(ofSize: 12), duration: 2)
                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                          self.hud.hide(animated: true)
                        self.showToast(message: "Something went wrong", font: UIFont.boldSystemFont(ofSize: 12), duration: 2)
                    }
                }
            }
                
            catch {
                print(error)
            }
            
        }.resume()
        
        
    }
    
    
    
    
    
    
    @IBAction func btnprivacypolicy(_ sender: Any) {
        
        let termsandcondition = self.storyboard?.instantiateViewController (withIdentifier: "Terms_conditionViewController") as! Terms_conditionViewController
        
        let nc = revealViewController().frontViewController as! UINavigationController
        nc.pushViewController(termsandcondition, animated: false)
        termsandcondition.termsflag=0
        revealViewController().pushFrontViewController(nc, animated: true)
        
        // self.navigationController?.pushViewController(termsandcondition, animated: true)
        
        
        
    }
    
    @IBAction func btnaboutusaction(_ sender: Any) {
        
        let aboutus = self.storyboard?.instantiateViewController (withIdentifier: "AboutUsViewController") as! AboutUsViewController
        
        let nc = revealViewController().frontViewController as! UINavigationController
        nc.pushViewController(aboutus, animated: false)
        
        revealViewController().pushFrontViewController(nc, animated: true)
        
    }
    
    
    @IBAction func btncontinueaction(_ sender: Any) {
        if txtfldotp.text?.count==0{
            self.showToast(message: "Please enter the otp to continue", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
        }else{
            service_profile_edit_new()
        }
        
        
    }
    
    
    @IBAction func btnresendotpaction(_ sender: Any) {
        service_profile_edit_otp()
    }
    
    
    @IBAction func btncancelforotpaction(_ sender: Any) {
        viewotp.isHidden=true
        btnedit.setTitle("Edit", for: .normal)
        txtfldmobile.isUserInteractionEnabled=false
        txtfldemail.isUserInteractionEnabled=false
        txtfldname.isUserInteractionEnabled=false
    }
    
    @IBAction func btncahngenumberforotpaction(_ sender: Any) {
        viewotp.isHidden=true
        btnedit.setTitle("Edit", for: .normal)
        txtfldmobile.isUserInteractionEnabled=false
        txtfldemail.isUserInteractionEnabled=false
        txtfldname.isUserInteractionEnabled=false
    }
    
    
    func showhud(){
          hud = MBProgressHUD.showAdded(to: self.view, animated: true)
          hud.mode = MBProgressHUDMode.indeterminate
      }
}
