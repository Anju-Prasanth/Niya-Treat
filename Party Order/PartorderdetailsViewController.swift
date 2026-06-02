//
//  PartorderdetailsViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 06/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class PartorderdetailsViewController: UIViewController {
    var carttotalprice=Int()
    var detailpagearray=[[String:String]]()

    @IBOutlet weak var btnaddtocart: UIButton!
    @IBOutlet weak var lblquantity: UILabel!
    @IBOutlet weak var lblnoofperson: UILabel!
    @IBOutlet weak var lblactualprice: UILabel!
    @IBOutlet weak var lblmenuname: UILabel!
    var menuname=String()
    var actualprice=Int()
    var quty=Int()
    var increasedprice=Int()
    var price=Int()
    var cartprice=Int()
    var newpartyorderarray=[[String:String]]()
    var partyordernumberofpeople=String()
    var nonvegitemarray=[[String:String]]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
                      let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
                      navigationItem.leftBarButtonItem = btnsback

        carttotalprice = UserDefaults.standard.value(forKey: "carttotalprice") as! Int
      
       
            if let partyorderarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart"){
                          if partyorderarray.isEmpty==true{
                              
                          }else{
                              detailpagearray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String : String]]
                            for value in detailpagearray{
                                let item:[String:String]=value as! [String:String]
                                if item["mainmenuitem"]==menuname{
                                    lblmenuname.text=menuname
                                    //quantityincreased=(item["quantity"]as! NSString).integervalue
                                    lblquantity.text=String(quty)
                                    lblactualprice.text=item["actualprice"]
                                    actualprice=(item["actualprice"] as! NSString).integerValue
                                    btnaddtocart.setTitle("Add to cart ₹ "+item["mainmenuitemprice"]!, for: .normal)
                                    price=(item["mainmenuitemprice"] as! NSString).integerValue
                                    
                                    
                                }
                               
                                
                            }
                                  
                                  
                              }
                            
                          }
        if let partyorderarray=UserDefaults.standard.array(forKey: "partyorderarray"){
        if partyorderarray.isEmpty==true{
            
        }else{
            newpartyorderarray=UserDefaults.standard.array(forKey: "partyorderarray") as! [[String : String]]
                      }
        }
        print("newpartyorderarray",newpartyorderarray)
        
        if let numberpeople=UserDefaults.standard.value(forKey: "partyorderpeoplenumbers"){
            partyordernumberofpeople=UserDefaults.standard.value(forKey: "partyorderpeoplenumbers") as! String
             lblnoofperson.text="No of Person :" + String(partyordernumberofpeople)
        }
//        if let nonvegarray=UserDefaults.standard.array(forKey: "nonvegitemarray"){
//        if nonvegarray.isEmpty==true{
//            
//        }else{
//            nonvegitemarray=UserDefaults.standard.array(forKey: "nonvegitemarray") as! [[String : String]]
//              
//            }
//        }
        
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
                               // Perform your custom actions
                               // ...
                               // Go back to the previous ViewController
                               self.navigationController?.popViewController(animated: true)
                           }
                           
                  
           
                
    
    @IBAction func btnminustapped(_ sender: Any) {
        if quty==1{
            
        }else{
            quty=quty-1
            increasedprice=price*quty
            lblquantity.text=String(quty)
        }
          lblquantity.text=String(quty)
         btnaddtocart.setTitle("Add to cart ₹ "+String(increasedprice), for: .normal)
        
    }
    

    @IBAction func btnplustapped(_ sender: Any) {
       quty=quty+1
        increasedprice=price*quty
        lblquantity.text=String(quty)
        btnaddtocart.setTitle("Add to cart ₹ "+String(increasedprice), for: .normal)
    }
    

    @IBAction func btnremovecart(_ sender: Any) {
        let yourcart = self.storyboard?.instantiateViewController(withIdentifier: "YourcartViewController") as! YourcartViewController
               
               for values in detailpagearray{
                   let i=detailpagearray.index(of:values)
                   var item:[String:String]=values as [String:String]
                   if item["mainmenuitem"]==menuname{
                       detailpagearray.remove(at: i!)
                    
            
             }
        }
        print("detailpagearray",detailpagearray)
        for value in newpartyorderarray{
                let index=newpartyorderarray.index(of:value)
                 var item:[String:String]=value as [String:String]
                     if item["mainitemname"]==menuname{
                     newpartyorderarray.remove(at: index!)
             }
               
        }
         print("newpartyorderarray",newpartyorderarray)
              
           UserDefaults.standard.set(newpartyorderarray, forKey: "partyorderarray")
         UserDefaults.standard.set(detailpagearray, forKey: "mainmenuitemarraycart")
        
                print("detailpagearray",detailpagearray)
        
        
        
        for value in nonvegitemarray{
                let index=nonvegitemarray.index(of:value)
                 var item:[String:String]=value as [String:String]
                     if item["nonvegmainmenuname"]==menuname{
                     nonvegitemarray.remove(at: index!)
             }
               
        }
        UserDefaults.standard.set(nonvegitemarray, forKey: "nonvegitemarray")
        
        
        
        
               
               for values in detailpagearray{
               let item:[String:String]=values as [String:String]
               cartprice+=(item["mainmenuitemprice"]as! NSString).integerValue
               print("cartprice",cartprice)
               }
               UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
               self.navigationController?.pushViewController(yourcart, animated: true)
           }
           
           
    @IBAction func btnaddtocartaction(_ sender: Any) {
        
        let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
              
        
        for values in detailpagearray{
            let i=detailpagearray.index(of:values)
            var item:[String:String]=values as [String:String]
            if item["mainmenuitem"]==menuname{
                detailpagearray.remove(at: i!)
        }
        }
               var items=[String:String]()
              // items.updateValue(product_id, forKey: "id")
              // items.updateValue(String(price), forKey: "actualprice")
               items.updateValue(String(increasedprice), forKey: "mainmenuitemprice")
               items.updateValue(String(quty), forKey: "quantity")
               items.updateValue(menuname, forKey: "mainmenuitem")
             items.updateValue(String(actualprice), forKey: "actualprice")
//               print("items",items)
//               if myarray.isEmpty==true{
//               dict4.append(items as! [String : String])
//               UserDefaults.standard.set(dict4, forKey: "myarray")
//               }else{
//                   for values in myarray{
//                       let i=myarray.index(of:values)
//                       var item:[String:String]=values as [String:String]
//                       if item["id"]==product_id{
//                           myarray.remove(at: i!)
//                   }
//                   }
//
               detailpagearray.append(items)
               UserDefaults.standard.set(detailpagearray, forKey: "mainmenuitemarraycart")
             // }
               
              
               detailpagearray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String : String]]
               
            
//               print("myarray",myarray)
//               print("dict4",dict4)
           
           for values in detailpagearray{
           let item:[String:String]=values as [String:String]
           cartprice+=(item["mainmenuitemprice"]as! NSString).integerValue
           print("cartprice",cartprice)
           }
           UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
          
           self.navigationController?.pushViewController(yourcart, animated: true)
        
    
}
    
    
}
