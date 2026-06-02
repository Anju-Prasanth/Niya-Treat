//
//  ProductdetailsViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 28/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import Kingfisher

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ProductdetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var lblcartprice: UILabel!
    @IBOutlet weak var tableviewproductdetails: UITableView!
    var product_id=String()
    var imageurl=String()
   var productidarray=[String]()
    var productnamearray=[String]()
   var pricearray=[Int]()
   var typearray=[String]()
    var product_imagearray=[String]()
    var product_quantityarray=[Int]()
    var product_name=String()
    var tempvalue=1
    var price=Int()
    var price_value=Int()
    var numbers=["1"]
    var cartpricearray=[Int]()
    var newcartpricearray=[Int]()
    var newnumbersarray=[String]()
    var newprice=Int()
    var newaddtocartflagarray=[Int]()
    var newproductidarray=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("newcartpricearray",newcartpricearray)
         lblcartprice.text="Add to cart "+"₹ "+String(price_value)
        self.navigationItem.hidesBackButton = true
         let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
         navigationItem.leftBarButtonItem = btnsback
         self.tableviewproductdetails.register(UINib(nibName: "ProductdetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductdetailsTableViewCell")
        service_product_details()
       
    }
    

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
    
                              
    if (UserDefaults.standard.array(forKey: "price") as! [Int]).count != 0{
    newcartpricearray=UserDefaults.standard.array(forKey: "price") as! [Int]
        print("newcartpricearray",newcartpricearray)
    }
    if (UserDefaults.standard.array(forKey: "productid") as! [String] ).count !=  0{
    newproductidarray=UserDefaults.standard.array(forKey: "productid") as! [String]
        }
       
        
                              let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
                              title = " "+product_name
                             
                              lbl.text = title
                              lbl.font = UIFont.systemFont(ofSize: 20.0)
                            lbl.textColor =  UIColor.darkGray
                              lbl.textAlignment = .left
                              navigationItem.titleView=lbl
                              
                            
         
                                   
                              
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
    
                       
           
          
          
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return productnamearray.count
             }
             
             func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let productdetails = (tableView.dequeueReusableCell(withIdentifier: "ProductdetailsTableViewCell", for: indexPath) as? ProductdetailsTableViewCell)!
                productdetails.btnremovefromcart.isHidden=true
                productdetails.lblproductname.text=productnamearray[indexPath.row]
                productdetails.lblprice.text="₹ "+String(pricearray[indexPath.row])
                // productdetails.lblprice.text="₹ "+String(pricearray[indexPath.row])
                //price=pricearray[0]
                productdetails.lblnumbers.text=numbers[indexPath.row]
                if typearray[indexPath.row]=="1"{
                     productdetails.lbltype.text="Veg"
                    productdetails.imageviewtype.image=UIImage(named:"Ellipse 419")
                }else{
                     productdetails.lbltype.text="Non-Veg"
                    productdetails.imageviewtype.image=UIImage(named:"Ellipse 419-1")
                   
                }
                let url = URL(string:product_imagearray[indexPath.row])
                           productdetails.imageviewproduct.kf.indicatorType = .activity
                           productdetails.imageviewproduct.kf.setImage(with: url)
                           productdetails.imageviewproduct.contentMode = .scaleToFill
               productdetails.btnplus.addTarget(self, action: #selector(btnplus(sender:)), for: .touchUpInside)
                 productdetails.btnminus.addTarget(self, action: #selector(btnminus(sender:)), for: .touchUpInside)
                productdetails.btnplus.tag=indexPath.row
                productdetails.btnminus.tag=indexPath.row
                               
                return productdetails
              
             }
          
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          
               return 700
          
                
             }
    
    @objc func btnplus(sender:UIButton){
        if tempvalue<product_quantityarray[sender.tag]{
        tempvalue=tempvalue+1
           // price_value+=pricearray[sender.tag]
            print("newcartpricearray[sender.tag]",newcartpricearray[sender.tag])
            price_value=price_value+pricearray[sender.tag]
            //newprice=pricearray[sender.tag]+newcartpricearray[sender.tag]
           // newcartpricearray[sender.tag]=newprice
             numbers[sender.tag]=String(tempvalue)
            newaddtocartflagarray[sender.tag]=1
        }else{
            self.showToast(message: "Quantity exceeds the available quantity", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
        }
        for i in 0...productidarray.count-1{
            if productidarray.contains(product_id){
                newcartpricearray.remove(at: i)
                newcartpricearray.insert(price_value, at: i)
            }
        }
        UserDefaults.standard.set(newcartpricearray, forKey: "price")
    
        lblcartprice.text="Add to cart "+"₹ "+String(price_value)
        self.tableviewproductdetails.reloadData()
        
    }
    @objc func btnminus(sender:UIButton){
        
       if tempvalue==1{
       
        }else{
           tempvalue=tempvalue-1
       // price_value-=pricearray[sender.tag]
        price_value-=newcartpricearray[sender.tag]
        newprice=pricearray[sender.tag]+newcartpricearray[sender.tag]
        newcartpricearray[sender.tag]=newprice
         numbers[sender.tag]=String(tempvalue)
         newaddtocartflagarray[sender.tag]=1
        }
       
        lblcartprice.text="Add to cart "+"₹ "+String(price_value)
        self.tableviewproductdetails.reloadData()
    }

    func service_product_details(){
            
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
                        self.imageurl=parseJson["image_url"] as! String
                        for item in Products{
                            let value:[String:Any]=item as! [String:Any]
                            let productid=value["product_id"] as! String
                            let productname=value["product_name"] as! String
                            let price=(value["price"] as! NSString).integerValue
                            let type=value["type"] as! String
                            let product_image=value["product_image"] as! String
                            let product_quantity=(value["product_quantity"] as! NSString).integerValue
                            self.productidarray.append(productid)
                             self.productnamearray.append(productname)
                             self.pricearray.append(price)
                             self.typearray.append(type)
                             self.product_imagearray.append(self.imageurl+product_image)
                            self.product_quantityarray.append(product_quantity)
                        }
                  DispatchQueue.main.async {
                    self.tableviewproductdetails.reloadData()
                        }
                        
                    }else{
                        DispatchQueue.main.async {
                            self.showToast(message: "Invalid email or password", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        }
                        }
                    }
                
                                 catch {
                                 print(error)
                                 }
                                                               
                        }.resume()
                    }
    
    
    @IBAction func btnaddtocartaction(_ sender: Any) {
        let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
        cartpricearray.append(price_value)
        print("newcartpricearray",newcartpricearray)
         print("newaddtocartflagarray",newaddtocartflagarray)
        UserDefaults.standard.set(newcartpricearray, forKey: "cartprice")
        UserDefaults.standard.set(newaddtocartflagarray, forKey: "addtocart")
        UserDefaults.standard.set(numbers,forKey: "number")
        //newcartpricearray=UserDefaults.standard.array(forKey: "cartprice") as! [Int]
        //newnumbersarray=UserDefaults.standard.array(forKey: "number") as! [String]
         //productlisting.addtocartflag=1
        
        self.navigationController?.pushViewController(productlisting, animated: true)
    }
    
    
    
    
}
