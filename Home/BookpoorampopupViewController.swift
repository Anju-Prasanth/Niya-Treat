//
//  BookpoorampopupViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 02/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import MBProgressHUD

class BookpoorampopupViewController: UIViewController {

    @IBOutlet weak var txtfldemail: UITextField!
    @IBOutlet weak var txtfldphone: UITextField!
    @IBOutlet weak var txtfldname: UITextField!
    var hud:MBProgressHUD!
    override func viewDidLoad() {
        super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        txtfldemail.layer.borderWidth=1
        txtfldemail.layer.borderColor = UIColor.lightGray.cgColor
        txtfldemail.layer.cornerRadius=5
        txtfldphone.layer.borderWidth=1
        txtfldphone.layer.borderColor = UIColor.lightGray.cgColor
        txtfldphone.layer.cornerRadius=5
        txtfldname.layer.borderWidth=1
        txtfldname.layer.borderColor = UIColor.lightGray.cgColor
        txtfldname.layer.cornerRadius=5
      
    }
    

    @IBAction func submittaction(_ sender: Any) {
        if txtfldname.text?.isEmpty==true||txtfldphone.text?.isEmpty==true||txtfldemail.text?.isEmpty==true{
            self.showToast(message: "Please enter the details", font: UIFont.boldSystemFont(ofSize: 14),duration: 2)
        }else{
            service_bookpooram()
        }
        
    }
   

    @IBAction func btntappedotsidecation(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
        
    }
    func service_bookpooram(){
//        self.showhud()
              guard let url=NSURL(string :"https://niyaregency.com/api/Data/book_pooram")else{return}
        let poststring="name=\(txtfldname.text!)&email=\(txtfldemail.text!)&mobile=\(txtfldphone.text!)"
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
                    let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .allowFragments)as? [String:AnyObject]
//                       if let parseJson = jsonarray{
                    let status=jsonarray!["status"] as! Bool
                          if status==true{
                             DispatchQueue.main.async {
//                                self.hud.hide(animated: true)
                                self.showToast(message: "Mail send successfully", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                self.dismiss(animated: true, completion: nil)
                        }
                       
                        }
//                       }else{
//                              DispatchQueue.main.async {
//                              self.showToast(message: "Error in fetching details", font: UIFont.boldSystemFont(ofSize: 14))
//                              }
//                              }
                   }
                      
                                       catch {
                                       print(error)
                                       }
                                                                     
                              }.resume()
                          }
          
    
    func showhud(){
                                    hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                                    hud.mode = MBProgressHUDMode.indeterminate
                                }
    

    }
    
    
    

