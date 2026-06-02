//
//  Productdetailsdemoviewcontroller.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 29/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import Kingfisher
import  MBProgressHUD




@available(iOS 13.0, *)
class Productdetailsdemoviewcontroller: UIViewController {
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var imageviewtype: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbltype: UILabel!
    @IBOutlet weak var imageviewproduct: UIImageView!
    @IBOutlet weak var lblpricecart: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    
    @IBOutlet weak var btnremovefromcart: UIButton!
    var product_id=String()
    var price_value=Int()
    
    var product_name=String()
    var price=Int()
    var tempvalue=1
    var dict=[[String:String]]()
    var dict4=[[String:String]]()
    var myarray=[[String:String]]()
    var image_url=String()
    var totalimage=String()
    var type=String()
    var productquantity=Int()
    var quantityincreased=1
    var product_image=String()
    var cartprice=Int()
    var hud:MBProgressHUD!
    var doordeliveryproductArray=[[String:Any]]()
    var foodcatgryid=String()
    var subArraysubproducts = [[String:Any]]()
    var doordeliveryproductArrayvegonly=[[String:Any]]()
    var productidarrayselected=[String:Int]()
    var cartflag=Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("myarray",myarray)
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        //        UserDefaults.standard.removeObject(forKey: "myarray")
        if let array=UserDefaults.standard.array(forKey: "myarray"){
            if array.isEmpty==true{
                for values in dict{
                    let item:[String:String]=values as [String:String]
                    print("item",item)
                    print("item[product_id]",item["product_id"])
                    if item["product_id"]==product_id{
                        price_value=(item["price"] as! NSString).integerValue
                        btnremovefromcart.isHidden=true
                        // quantityincreased=tempvalue
                        
                    }else{
                        
                    }
                }
            }else{
                myarray=UserDefaults.standard.array(forKey: "myarray") as! [[String : String]]
                print("myarray",myarray)
                
                for values in myarray{
                    let item:[String:String]=values as [String:String]
                    print("item",item)
                    print("item[product_id]",item["id"])
                    if item["id"]==product_id{
                        price_value=(item["totalprice"] as! NSString).integerValue
                        quantityincreased=(item["quantityincreased"] as! NSString).integerValue
                        btnremovefromcart.isHidden=false
                    }else{
                        
                    }
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        //        if let array=UserDefaults.standard.array(forKey: "newarray"){
        //            if array.isEmpty==true{
        //
        //            }else{
        //                 cartnewarray=(UserDefaults.standard.array(forKey: "newarray")) as! [String]
        //                print("cartnewarray",cartnewarray)
        //                 print("newproductidarray",newproductidarray)
        //                 print("newproductidarray",newproductidarray)
        
        //                for value in newproductidarray{
        //                    for item in cartnewarray{
        //                        if value==item{
        //                            let i=newproductidarray.firstIndex(of: value)
        //                            price_value=newcartpricearray[i!]
        //                        }
        //                        }
        //
        //
        //        }
        //            }
        // }
        //        for value in newproductidarray{
        //                if value==product_id{
        //                    index=newproductidarray.firstIndex(of: value)!
        //            price_value=newcartpricearray[index]
        //                   // dict.updateValue(price_value, forKey: "price")
        //                }else{
        //
        //            }
        //       print("dict",dict)
        //            for values in dict{
        //                let item:[String:String]=values as [String:String]
        //                print("item",item)
        //                print("item[product_id]",item["product_id"])
        //                if item["product_id"]==product_id{
        //                price_value=(item["price"] as! NSString).integerValue
        //                }else{
        //
        //                }
        //            }
        print("price_value",price_value)
        lblname.text=product_name
        lblqty.text=String(quantityincreased)
        lblpricecart.text="Add to cart "+"₹ "+String(price_value)
        lblprice.text="₹ "+String(price_value)
        // service_product_details()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        service_product_details()
        self.navigationController?.navigationBar.barTintColor = .white
        //self.navigationController?.navigationBar.isTranslucent = false
        
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
        
        title = product_name
        
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 20.0)
        lbl.textColor =  UIColor.darkGray
        lbl.textAlignment = .left
        navigationItem.titleView=lbl
        
        
//        if let doordeliveryarray = UserDefaults.standard.array(forKey: "doordeliveryproductArray") {
//
//            doordeliveryproductArray=UserDefaults.standard.array(forKey: "doordeliveryproductArray") as! [[String : Any]]
//
//        }
//        if let doordeliveryarrayveg = UserDefaults.standard.array(forKey: "doordeliveryproductArrayvegonly") {
//
//                   doordeliveryproductArrayvegonly=UserDefaults.standard.array(forKey: "doordeliveryproductArrayvegonly") as! [[String : Any]]
//
//               }
        
        if let productidselectd = UserDefaults.standard.value(forKey: "productidarrayselected") {
                          
                          productidarrayselected=UserDefaults.standard.value(forKey: "productidarrayselected") as! [String : Int]
                          
                      }
        
        
        
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
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func btnminusaction(_ sender: Any) {
        
        
        
        for (key,value) in productidarrayselected{
                   if key==product_id{
                   productidarrayselected.removeValue(forKey: product_id)
                   
                  let count=value-1
                   productidarrayselected.updateValue(count, forKey: product_id)
               }
               }
                   UserDefaults.standard.set(productidarrayselected, forKey: "productidarrayselected")
        
//        var section=Int()
//          var row=Int()
//          for i in 0...doordeliveryproductArray.count-1{
//
//              let item=doordeliveryproductArray[i]
//
//              if item["food_category_id"] as! String==foodcatgryid{
//                  let index=i
//                  section = index
//              }
//          }
//          let  item = self.doordeliveryproductArray[section]
//          self.subArraysubproducts=item["sub"] as! [[String:Any]]
//          for i in 0...subArraysubproducts.count-1{
//              let item=subArraysubproducts[i]
//
//              if item["product_id"] as! String==product_id{
//                  let index=i
//                  row = index
//              }
//          }
//
//          var selected=self.subArraysubproducts[row]
//          selected["count"] = (selected["count"]  as! Int) - 1
//          self.subArraysubproducts[row]=selected
//
//          print("subArraysubproducts",self.subArraysubproducts)
//
//          self.doordeliveryproductArray[section]["sub"]=self.subArraysubproducts
//          print("doordeliveryproductArray",self.doordeliveryproductArray)
//
//
//
//          UserDefaults.standard.set(doordeliveryproductArray, forKey: "doordeliveryproductArray")
//
//
//
//
//
        
          
        
        
        
        
        if quantityincreased==1{
            
        }else{
            quantityincreased=quantityincreased-1
            price_value=price_value-price
            //             quantityincreased=tempvalue
            lblqty.text=String(quantityincreased)
        }
        lblprice.text="₹ "+String(price_value)
        lblpricecart.text="Add to cart "+"₹ "+String(price_value)
    }
    
    @IBAction func btnplusaction(_ sender: Any){
        
        for (key,value) in productidarrayselected{
            if key==product_id{
            productidarrayselected.removeValue(forKey: product_id)
            
           let count=value+1
            productidarrayselected.updateValue(count, forKey: product_id)
        }
        }
            UserDefaults.standard.set(productidarrayselected, forKey: "productidarrayselected")
        
//        var section=Int()
//        var row=Int()
//        for i in 0...doordeliveryproductArray.count-1{
//            
//            let item=doordeliveryproductArray[i]
//            
//            if item["food_category_id"] as! String==foodcatgryid{
//                let index=i
//                section = index
//            }
//        }
//        let  item = self.doordeliveryproductArray[section]
//        self.subArraysubproducts=item["sub"] as! [[String:Any]]
//        for i in 0...subArraysubproducts.count-1{
//            let item=subArraysubproducts[i]
//            
//            if item["product_id"] as! String==product_id{
//                let index=i
//                row = index
//            }
//        }
//        
//        var selected=self.subArraysubproducts[row]
//        selected["count"] = (selected["count"]  as! Int) + 1
//        self.subArraysubproducts[row]=selected
//        
//        print("subArraysubproducts",self.subArraysubproducts)
//        
//        self.doordeliveryproductArray[section]["sub"]=self.subArraysubproducts
//        print("doordeliveryproductArray",self.doordeliveryproductArray)
//        
//      
//        
//        UserDefaults.standard.set(doordeliveryproductArray, forKey: "doordeliveryproductArray")
//        
//        
//        
//        if doordeliveryproductArrayvegonly.count>0{
//               
//               
//               for i in 0...doordeliveryproductArrayvegonly.count-1{
//                            
//                            let item=doordeliveryproductArrayvegonly[i]
//                            
//                            if item["food_category_id"] as! String==foodcatgryid{
//                                let index=i
//                                section = index
//                            }
//                        }
//                        let  item = self.doordeliveryproductArrayvegonly[section]
//                        self.subArraysubproducts=item["sub"] as! [[String:Any]]
//                    if subArraysubproducts.count>0{
//                        for i in 0...subArraysubproducts.count-1{
//                            let item=subArraysubproducts[i]
//                            
//                            if item["product_id"] as! String==product_id{
//                                let index=i
//                                row = index
//                            }
//                        }
//                        
//                        var selected=self.subArraysubproducts[row]
//                        selected["count"] = (selected["count"]  as! Int) + 1
//                        self.subArraysubproducts[row]=selected
//                        
//                        print("subArraysubproducts",self.subArraysubproducts)
//                        
//                        self.doordeliveryproductArrayvegonly[section]["sub"]=self.subArraysubproducts
//                        print("doordeliveryproductArrayvegonly",self.doordeliveryproductArrayvegonly)
//                        
//                      
//                        
//                        UserDefaults.standard.set(doordeliveryproductArrayvegonly, forKey: "doordeliveryproductArrayvegonly")
//            
//                   self.doordeliveryproductArray[section]["sub"]=self.subArraysubproducts
//                print("doordeliveryproductArray",self.doordeliveryproductArray)
//              
//            
//              
//               UserDefaults.standard.set(doordeliveryproductArray, forKey: "doordeliveryproductArray")
//            
//            }
//               
//               
//               
//               }
//               
//               
//               
//               
//               
//        
//        
//        
//        
//        
        
        
        
        
        
        
        
        
        
        
        print("price",price)
        if quantityincreased<productquantity{
            quantityincreased=quantityincreased+1
            price_value=price_value+price
            print("price_value",price_value)
            //             quantityincreased=tempvalue
            lblqty.text=String(quantityincreased)
        }else{
            self.showToast(message: "Quantity exceeds the available quantity", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
        }
        
        //            for values in dict{
        //                       let i=dict.index(of:values)
        //                       print("i",i)
        //                       var item:[String:String]=values as [String:String]
        //                           if item["product_id"]==product_id{
        //
        //                              item["price"]=String(price_value)
        //                               print("item[price]",item["price"])
        //                               print("item",item)
        //                               print("i",i)
        //                               dict.remove(at: i!)
        //                               //let i=self.dict.index(of: item)
        //                              // print("i",i)
        //           //                    dict.remove(at: item)
        //           //                    print("dict",dict)
        //                               dict.append(item)
        //                               print("dict",dict)
        //
        //                           }else{
        //
        //                           }
        //            }
        //
        //
        
        //         quantityincreased=tempvalue
        lblprice.text="₹ "+String(price_value)
        lblpricecart.text="Add to cart "+"₹ "+String(price_value)
        
        
    }
    
    
    
    
    func service_product_details(){
        self.showhud()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/product_details")else{return}
        let poststring="product_id=\(product_id)&security_token=niya32jfhdu392nfbfdr&"
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
                    let Products=parseJson["Products"] as! NSArray
                    self.image_url=parseJson["image_url"] as! String
                    for item in Products{
                        let value:[String:Any]=item as! [String:Any]
                        let productid=value["product_id"] as! String
                        let productname=value["product_name"] as! String
                        self.price=(value["price"] as! NSString).integerValue
                        self.type=value["type"] as! String
                        let product_image=value["product_image"] as! String
                        self.productquantity=(value["product_quantity"] as! NSString).integerValue
                        self.totalimage=self.image_url+product_image
                    }
                    print("productquantity",self.productquantity)
                    DispatchQueue.main.async {
                        print("self.totalimage",self.totalimage)
                        self.hud.hide(animated: true)
                        
                        
                        let url = URL(string:self.totalimage)
                        self.imageviewproduct.kf.indicatorType = .activity
                        self.imageviewproduct.kf.setImage(with: url)
                        
                        
                        if self.type=="1"{
                            self.lbltype.text="Veg"
                            self.imageviewtype.image=UIImage(named:"Ellipse 419")
                        }else{
                            self.lbltype.text="Non-Veg"
                            self.imageviewtype.image=UIImage(named:"Ellipse 419-1")
                            
                        }
                    }
                    
                    
                }else{
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.showToast(message: " ", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                    }
                }
            }
                
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    @IBAction func btnaddtocart(_ sender: Any) {
        
        
        var items=[String:String]()
        items.updateValue(foodcatgryid, forKey: "foodcatgryid")
        items.updateValue(product_id, forKey: "id")
        items.updateValue(String(price), forKey: "actualprice")
        items.updateValue(String(price_value), forKey: "totalprice")
        items.updateValue(String(quantityincreased), forKey: "quantityincreased")
        items.updateValue(product_name, forKey: "productname")
        
        print("items",items)
        if myarray.isEmpty==true{
            dict4.append(items as! [String : String])
            UserDefaults.standard.set(dict4, forKey: "myarray")
        }else{
            for values in myarray{
                let i=myarray.index(of:values)
                var item:[String:String]=values as [String:String]
                if item["id"]==product_id{
                    myarray.remove(at: i!)
                }
            }
            
            myarray.append(items)
            UserDefaults.standard.set(myarray, forKey: "myarray")
        }
        
        
        myarray=UserDefaults.standard.array(forKey: "myarray") as! [[String : String]]
        
        
        print("myarray",myarray)
        print("dict4",dict4)
        
        for values in myarray{
            let item:[String:String]=values as [String:String]
            cartprice+=(item["totalprice"]as! NSString).integerValue
            print("cartprice",cartprice)
        }
        UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
        
        
        if cartflag==1{
            let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
            
            self.navigationController?.pushViewController(yourcart, animated: true)
            
        }else{
        
        let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
        
        self.navigationController?.pushViewController(productlisting, animated: true)
        }
    }
    
    @IBAction func btnremovecartaction(_ sender: Any) {
        print("product_id",product_id)
        
        
        
        
//        var section=Int()
//          var row=Int()
//          for i in 0...doordeliveryproductArray.count-1{
//
//              let item=doordeliveryproductArray[i]
//
//              if item["food_category_id"] as! String==foodcatgryid{
//                  let index=i
//                  section = index
//              }
//          }
//          let  item = self.doordeliveryproductArray[section]
//          self.subArraysubproducts=item["sub"] as! [[String:Any]]
//          for i in 0...subArraysubproducts.count-1{
//              let item=subArraysubproducts[i]
//
//              if item["product_id"] as! String==product_id{
//                  let index=i
//                  row = index
//              }
//          }
//
//          var selected=self.subArraysubproducts[row]
//          selected["count"] = 0
//          self.subArraysubproducts[row]=selected
//
//          print("subArraysubproducts",self.subArraysubproducts)
//
//          self.doordeliveryproductArray[section]["sub"]=self.subArraysubproducts
//          print("doordeliveryproductArray",self.doordeliveryproductArray)
//
//
//
//          UserDefaults.standard.set(doordeliveryproductArray, forKey: "doordeliveryproductArray")
//
//
//
        
        
        for (key,value) in productidarrayselected{
                   if key==product_id{
                   productidarrayselected.removeValue(forKey: product_id)
                   
                  let count=0
                   productidarrayselected.updateValue(count, forKey: product_id)
               }
               }
                   UserDefaults.standard.set(productidarrayselected, forKey: "productidarrayselected")
        
        
        
        
        
        
        for values in myarray{
            let i=myarray.index(of:values)
            var item:[String:String]=values as [String:String]
            if item["id"]==product_id{
                myarray.remove(at: i!)
                
            }
            
        }
        
        UserDefaults.standard.set(myarray, forKey: "myarray")
        print("myarray",myarray)
        
        for values in myarray{
            let item:[String:String]=values as [String:String]
            cartprice+=(item["totalprice"]as! NSString).integerValue
            print("cartprice",cartprice)
        }
        UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
        
        
        if cartflag==1{
            
            let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
                   
                   self.navigationController?.pushViewController(yourcart, animated: true)
        }
        else{
        let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
        
        self.navigationController?.pushViewController(productlisting, animated: true)
        }
    }
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    
    
}
