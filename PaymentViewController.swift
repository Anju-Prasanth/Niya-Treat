//
//  PaymentViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 07/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import Razorpay
import MBProgressHUD



@available(iOS 13.0, *)

class PaymentViewController: UIViewController,RazorpayPaymentCompletionProtocol{
   
    

    var razorpay: RazorpayCheckout!
    var totalprice=Int()
    var phonenumber=String()
    var email=String()
    var serviceflag=Int()
    var hud:MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showhud()
        
        razorpay = RazorpayCheckout.initWithKey("rzp_live_7Kikh1cRTIvI0z", andDelegate: self)
    }
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//        DispatchQueue.main.async{
//            self.hud.hide(animated: true)
//        }
            self.showPaymentForm()
    }
    
    
    internal func showPaymentForm(){
        
        let option: [String:Any] = [
            "amount":totalprice*100, //This is in currency subunits. 100 = 100 paise= INR 1.
                    "currency": "INR",//We support more that 92 international currencies.
                    "description": "Niya Regency Online payment",
                    "image": "https://niyaregency.com/assets/img/logo.jpg",
                    "name": "Niya Treat",
                    "prefill": [
                        "contact": phonenumber,
                        "email": email
                    ],
                    "theme": [
                        "color": " "
                    ]
                ]
        DispatchQueue.main.async{
                           self.hud.hide(animated: true)
                       }
       // razorpay.open(option, display: self)
        razorpay.open(option, displayController: self)
    }
    
    
    func onPaymentError(_ code: Int32, description str: String) {
      
           let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertController.Style.alert)
           // Payment gateway is busy at this time. Please try after a few minutes.
           alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: {action in
            if self.serviceflag==1{
                    
                    let reviewbooking = self.storyboard?.instantiateViewController (withIdentifier: "ReviewbookingViewController") as! ReviewbookingViewController
                   let navController = UINavigationController(rootViewController: reviewbooking)
                
                
                    self.present(navController, animated: true, completion: nil)
                    }else{
                        let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
                      let navController = UINavigationController(rootViewController: yourcart)
                        self.present(navController, animated: true)
                    }
                
                    
               
            }))
              
                    self.present(alertController, animated: true)
                     // self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
           }
           
       
       
       func onPaymentSuccess(_ payment_id: String) {
           let alertController = UIAlertController(title: "SUCCESS", message: "Payment Id \(payment_id)", preferredStyle: UIAlertController.Style.alert)
                  print("payment_id",payment_id)
                 // self.paymentid = payment_id
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: {action in
            if self.serviceflag==1{
            
            let reviewbooking = self.storyboard?.instantiateViewController (withIdentifier: "ReviewbookingViewController") as! ReviewbookingViewController
                 reviewbooking.transactionid=payment_id
                let navController = UINavigationController(rootViewController: reviewbooking)
                self.present(navController, animated: true)
            
            }else{
                let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
                yourcart.trasactioniddoordelivery=payment_id
                let navController = UINavigationController(rootViewController: yourcart)
                self.present(navController, animated: true)
            }
        
            
        }))
          
                self.present(alertController, animated: true)
                 // self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
       }
    
    func showhud(){
    hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.mode = MBProgressHUDMode.indeterminate
        }

}

