//
//  PartyorderdetailsViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 30/04/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class PartyorderdetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var lblnoofpeople: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblcreateddate: UILabel!
    @IBOutlet weak var lblordercode: UILabel!
    @IBOutlet weak var tableviewpartyorderdetails: UITableView!
    var order_id=String()
       var productarray=[[String:Any]]()
       var imageurl=String()
       var ordercode=String()
       var createddate=String()
       var status=String()
       var grand_total=String()
    var pax=String()
    var review_submitted=String()
     var reviewentered=String()
    var review1=PartyreviewTableViewCell()
    var normalproducts=[[String:Any]]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
      lblordercode.text=ordercode
      lblcreateddate.text="Date: "+createddate
      lblstatus.text="Status: "+status
        lblnoofpeople.text="No: of people: "+pax
       service_party_history_detail()
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
        if normalproducts.count>0{
            return 4
        }else{
            return 3
        }
     }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if normalproducts.count>0{
           if section==0{
             return productarray.count
           }else if section==1{
            return normalproducts.count
           }else if section==2{
            return 1
           }else{
            return 1
            }
        }
        else{
     if section==0{
     return productarray.count
     }else if section==1{
         return 1
     }else{
        return 1
        }
            }
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        if productarray.count>0{
        //            self.detailstableviewheight?.constant=CGFloat((productarray.count*205)+150)
        //        }else{
        //        self.detailstableviewheight?.constant = 0
        //        }
        if normalproducts.count>0{
            if indexPath.section==0{
                
                let details = (tableView.dequeueReusableCell(withIdentifier: "PartydetailsTableViewCell", for: indexPath) as? PartydetailsTableViewCell)!
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
                    details.lblproductname.text=item["grp_main_menu_name"] as! String
                    details.lblprice.text="Price: " + String(item["grp_main_menu_price"] as! String)
                    details.lbldescrption.text=item["grp_main_menu_description"] as! String
                    details.lbltotal.text="Total: "+String(item["total"] as! String)+" INR"
                    
                }
                
                return details
                
            }else if indexPath.section==1{
                let menudoor = (tableView.dequeueReusableCell(withIdentifier: "PartywithdoormenuTableViewCell", for: indexPath) as? PartywithdoormenuTableViewCell)!
                // price.lbltotalprice.text="Total: "+grand_total+" INR"
                let item=normalproducts[indexPath.row] as [String:Any]
                menudoor.lbldoormenu.text=item["product_name"] as! String
                menudoor.lblprice.text="Price :" + String(item["price"] as! String)
                menudoor.lblqtity.text="Qty :" + String(item["qty"] as! String)
                menudoor.lbltotal.text="Total :" + String(item["total"] as! String)
              let totalimage=imageurl+String(item["product_image"] as! String)
                let url = URL(string:totalimage)
                       menudoor.imageviewdoormenu.kf.indicatorType = .activity
                       menudoor.imageviewdoormenu.kf.setImage(with: url)
                       menudoor.imageviewdoormenu.contentMode = .scaleToFill
                return menudoor
                
            }else if indexPath.section==2{
                
                let price = (tableView.dequeueReusableCell(withIdentifier: "PartypriceTableViewCell", for: indexPath) as? PartypriceTableViewCell)!
                // price.lbltotalprice.text="Total: "+grand_total+" INR"
                
                price.lbltotalprice.text="Total                "+grand_total+" INR"
                let value=((Int(grand_total)!)*100)/105
                print("value",value)
                
                let tax=Double(value*5)/100
                print("tax",tax)
                price.lbltaxcharge.text = "Tax Charge        "+String(tax.rounded())+" INR"
                
                return price
                
            }else{
                
                review1 = (tableView.dequeueReusableCell(withIdentifier: "PartyreviewTableViewCell", for: indexPath) as? PartyreviewTableViewCell)!
                
                
                
                if status == "Delivered"{
                    if review_submitted==""{
                        review1.isHidden=false
                        review1.lblwriteareview.text="Write a review"
                        // review.txtviewpartyreview.text=""
                        review1.txtviewpartyreview.isUserInteractionEnabled=true
                        review1.btnsubmitt.isHidden=false
                        
                        review1.txtviewpartyreview.layer.cornerRadius=10
                        review1.txtviewpartyreview.layer.borderWidth=1
                        review1.txtviewpartyreview.layer.borderColor=UIColor.lightGray.cgColor
                    }else{
                        review1.lblwriteareview.text="Your Order Review"
                        review1.txtviewpartyreview.text=review_submitted
                        review1.txtviewpartyreview.isUserInteractionEnabled=false
                        review1.btnsubmitt.isHidden=true
                        
                    }
                }else{
                    review1.isHidden=true
                }
                review1.btnsubmitt.addTarget(self, action: #selector(btnreviewsubmittapped), for: .touchUpInside)
                // reviewentered=review.txtviewpartyreview.text
                
                
                return review1
            }
            
            
            
            
        }else{
            if indexPath.section==0{
                
                let details = (tableView.dequeueReusableCell(withIdentifier: "PartydetailsTableViewCell", for: indexPath) as? PartydetailsTableViewCell)!
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
                    details.lblproductname.text=item["grp_main_menu_name"] as! String
                    details.lblprice.text="Price: " + String(item["grp_main_menu_price"] as! String)
                    details.lbldescrption.text=item["grp_main_menu_description"] as! String
                    details.lbltotal.text="Total: "+String(item["total"] as! String)+" INR"
                    
                }
                
                return details
                
            }else if indexPath.section==1{
                
                let price = (tableView.dequeueReusableCell(withIdentifier: "PartypriceTableViewCell", for: indexPath) as? PartypriceTableViewCell)!
                // price.lbltotalprice.text="Total: "+grand_total+" INR"
                
                price.lbltotalprice.text="Total                "+grand_total+" INR"
                let value=((Int(grand_total)!)*100)/105
                print("value",value)
                
                let tax=(value*5)/100
                print("tax",tax)
                price.lbltaxcharge.text = "Tax Charge        "+String(tax)+" INR"
                
                return price
                
            }else{
                
                review1 = (tableView.dequeueReusableCell(withIdentifier: "PartyreviewTableViewCell", for: indexPath) as? PartyreviewTableViewCell)!
                
                
                
                if status == "Delivered"{
                    if review_submitted==""{
                        review1.isHidden=false
                        review1.lblwriteareview.text="Write a review"
                        // review.txtviewpartyreview.text=""
                        review1.txtviewpartyreview.isUserInteractionEnabled=true
                        review1.btnsubmitt.isHidden=false
                        
                        review1.txtviewpartyreview.layer.cornerRadius=10
                        review1.txtviewpartyreview.layer.borderWidth=1
                        review1.txtviewpartyreview.layer.borderColor=UIColor.lightGray.cgColor
                    }else{
                        review1.lblwriteareview.text="Your Order Review"
                        review1.txtviewpartyreview.text=review_submitted
                        review1.txtviewpartyreview.isUserInteractionEnabled=false
                        review1.btnsubmitt.isHidden=true
                        
                    }
                }else{
                    review1.isHidden=true
                }
                review1.btnsubmitt.addTarget(self, action: #selector(btnreviewsubmittapped), for: .touchUpInside)
                // reviewentered=review.txtviewpartyreview.text
                
                
                return review1
            }
        }
    }
            
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            if normalproducts.count>0{
                if indexPath.section==0{
                return 160
                }else if indexPath.section==1{
                return 165
                }else if indexPath.section==2{
                return 72
               }else{
                return 175
                }
            }
            else{
            
            
            
            if indexPath.section==0{
                return 160
            }else if indexPath.section==1{
               return 72
            }else{
                return 175
            }
            }
        }
        
    
    
    
    
    
    @objc func btnreviewsubmittapped(){
         reviewentered=review1.txtviewpartyreview.text
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
                                            self.review_submitted=self.reviewentered
                                                self.tableviewpartyorderdetails.reloadData()
                                                                                   }
                                       }else{
                                           DispatchQueue.main.async {
                                                                                                                            
                                           self.showToast(message: "Something went wrong", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
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
    
    
    func service_party_history_detail(){
    
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/food_history_party_detail")else{return}
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
                            
                            
                            self.productarray=data["products"] as! [[String:Any]]
                            self.imageurl=data["image_url"] as! String
                            self.normalproducts=data["normal_products"] as! [[String:Any]]
                            print("orderlistarray",self.productarray)
                            if self.productarray.count>0{
                                DispatchQueue.main.async {
                                   
                                    self.tableviewpartyorderdetails.reloadData()
                                    
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
    
    
    
    
    
    

}
