//
//  OrderDetailsViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 29/04/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class OrderDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var btnreorder: UIButton!
    @IBOutlet weak var detailstableviewheight: NSLayoutConstraint!
    @IBOutlet weak var lblstatusname: UILabel!
    @IBOutlet weak var lblcreteddate: UILabel!
    @IBOutlet weak var lblordercode: UILabel!
    @IBOutlet weak var tableviewfoodorderdetails: UITableView!
    var order_id=String()
    var productarray=[[String:String]]()
    var imageurl=String()
    var ordercode=String()
    var createddate=String()
    var status=String()
    var grand_total=String()
    var review_submitted=String()
    var reviewentered=String()
    var review=ReviewTableViewCell()
    var activity_food=String()
    var productnamearray=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback

        lblordercode.text=ordercode
        lblcreteddate.text="Date: "+createddate
        lblstatusname.text="Status: "+status
        if activity_food=="1"{
            btnreorder.isHidden=false
            btnreorder.layer.cornerRadius=10
            btnreorder.layer.borderColor=UIColor.systemOrange.cgColor
            btnreorder.layer.borderWidth=1
        }else{
             btnreorder.isHidden=true
        }
        
        service_food_history_detail()
      
   
    }
    
    func backButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        //        button.setImage(UIImage(named: imageName), for: .normal)
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width:20, height: 20)
        button.backgroundColor = UIColor.clear
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    @objc func back(sender: UIBarButtonItem) {
     
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
   func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section==0{
    return productarray.count
    }else if section==1{
        return 1
    }else{
        return 1
    }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if productarray.count>0{
//            self.detailstableviewheight?.constant=CGFloat((productarray.count*205)+150)
//        }else{
//        self.detailstableviewheight?.constant = 0
//        }
        if indexPath.section==0{
        
            
            let details = (tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as? DetailsTableViewCell)!
            if indexPath.row==0{
                if #available(iOS 11.0, *) {
                    details.Outerview.layer.cornerRadius=10
                    details.Outerview.layer.maskedCorners=[.layerMinXMinYCorner, .layerMaxXMinYCorner]
                } else {
                    // Fallback on earlier versions
                }
            }else{
            }
            if productarray.count>0{
            let item=productarray[indexPath.row]
            details.lblproductname.text=item["product_name"] as! String
            details.lblprice.text="Price: " + String(item["price"] as! String)
            details.lblquantity.text="Quantity: " + String(item["qty"] as! String)
            details.lbltotal.text="Total: "+String(item["total"] as! String)+" INR"
            let url = URL(string:imageurl+String(item["product_image"] as! String))
            details.imageviewproduct.kf.indicatorType = .activity
            details.imageviewproduct.kf.setImage(with: url)
            details.imageviewproduct.contentMode = .scaleToFill
            }
            
            return details
            
        }else if indexPath.section==1{
          
            let price = (tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell", for: indexPath) as? PriceTableViewCell)!
            price.lblgrandtotal.text="Total                "+grand_total+" INR"
            let value=((Int(grand_total)!)*100)/105
            print("value",value)
            
            let tax=(value*5)/100
            print("tax",tax)
            price.lbltaxcharge.text = "Tax Charge        "+String(tax)+" INR"
            return price
            
        }else{
             review = (tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell)!
           
            if status == "Delivered"{
                if review_submitted==""{
                    review.isHidden=false
                    review.lblwriteareview.text="Write a review"
//                   review.txtviewreview.text=""
                    review.txtviewreview.isUserInteractionEnabled=true
                     review.btnsubmitt.isHidden=false
                    review.txtviewreview.layer.cornerRadius=10
                    review.txtviewreview.layer.borderWidth=1
                    review.txtviewreview.layer.borderColor=UIColor.lightGray.cgColor
                }else{
                    review.lblwriteareview.text="Your Order Review"
                    review.txtviewreview.text=review_submitted
                     review.txtviewreview.isUserInteractionEnabled=false
                     review.btnsubmitt.isHidden=true
                }
            }else{
                review.isHidden=true
            }
            review.btnsubmitt.addTarget(self, action: #selector(btnreviewsubmittapped), for: .touchUpInside)
            
            print("reviewentered",reviewentered)
            return review
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0{
            return 205
        }else if indexPath.section==1{
           return 72
        }else{
            return 165
        }
    }
    
    @objc func btnreviewsubmittapped(){
        reviewentered=review.txtviewreview.text
        service_user_review()
    }
    
    
    
    func service_user_review(){
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/user_review")else{return}
               let poststring="order_id=\(order_id)&type=2&review=\(reviewentered)&security_token=niya32jfhdu392nfbfdr"
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
                                                                                  
                                        self.showToast(message: "Review submitted successfully", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                            
                                                                                }
                                    }else{
                                        DispatchQueue.main.async {
                                                                                                                         
                                        self.showToast(message: "Something went wrong", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                            self.review_submitted=self.reviewentered
                                            self.tableviewfoodorderdetails.reloadData()
                                        }
                                    }
                                   
                                  

                         }else{
                                         DispatchQueue.main.async {
                                           
                                           self.showToast(message: "Something went wrong", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                         }
                                         }
                                     }
                                 
                                                  catch {
                                                  print(error)
                                                  }
                                                                                
                                         }.resume()
                  
    }
    func service_food_history_detail(){
    
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/food_history_detail")else{return}
        let poststring="order_id=\(order_id)&security_token=niya32jfhdu392nfbfdr"
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
                            let data=parseJson["data"]as! NSDictionary
                            
                            
                            self.productarray=data["products"] as! [[String:String]]
                            self.imageurl=data["image_url"] as! String
//                            for value in self.productarray{
//                                let item=value as [String:Any]
//                                let productname=item["product_name"] as! String
//                                let productid=item["product_name"] as! String
//                            }
                            print("orderlistarray",self.productarray)
                            if self.productarray.count>0{
                                DispatchQueue.main.async {
                                   
                                    self.tableviewfoodorderdetails.reloadData()
                                    
                                }
                            }
                           

                  }else{
                                  DispatchQueue.main.async {
                                    
                                    self.showToast(message: "Error in fetching details", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                  }
                                  }
                              }
                          
                                           catch {
                                           print(error)
                                           }
                                                                         
                                  }.resume()
           
     
                       }
    
    
    
    @IBAction func btnreorderaction(_ sender: Any) {
        
        showpopup()
        
        
    }
    func showpopup(){
       // self.definesPresentationContext=true
        
       let takeawaypopvc = self.storyboard?.instantiateViewController (withIdentifier: "TakeawaypopupViewController") as! TakeawaypopupViewController
          
                  takeawaypopvc.modalPresentationStyle = .overCurrentContext
                  takeawaypopvc.modalTransitionStyle = .crossDissolve
                takeawaypopvc.foodtype=Int(activity_food)!
                 takeawaypopvc.reorderflag=1
                takeawaypopvc.orderid=order_id
            takeawaypopvc.reorderproductsarray=self.productarray
        
                  UserDefaults.standard.set(Int(activity_food), forKey: "activity")
         UserDefaults.standard.set(Int(activity_food), forKey: "foodtype")
                  self.navigationController?.present(takeawaypopvc, animated: true,completion: nil)
    }
    
}
