//
//  ProductslistingViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 24/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper
import Alamofire
import Kingfisher
import MBProgressHUD

@available(iOS 13.0, *)
class ProductslistingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,productdetailsdelegate,OptionButtonsDelegate{
    
    
    @IBOutlet weak var btncartcount: UIButton!
    @IBOutlet weak var lbltotalcartprice: UILabel!
    
    @IBOutlet weak var btnviewcart: UIButton!
    
    @IBOutlet weak var collectionviewtopbar: UICollectionView!
    @IBOutlet weak var collectionviewsubcategory: UICollectionView!
    var totalproducts1:[totalproducts] = []
    var sub=[[String:Any]]()
    
    
    var cell2=TopbarCollectionViewCell()
    
    
    var categorynamearray=[String]()
    var categoryidarray=[String]()
    var starttimearray=[String]()
    var endtimearray=[String]()
    var scrlabel=UILabel()
    
    let buttonPadding:CGFloat = 10
    var xOffset:CGFloat = 10
    
    var statusbarheight:CGFloat!
    var navigationbarheight:CGFloat!
    var selectedIndex=100
    var activityid=Int()
    var selectediindexsection=100
    var noofitems=String()
    var formattedDate=String()
    var starttime=String()
    var dict1=[[String:String]]()
    
    var productimage=String()
    var food_type=Int()
    var carttotalprice=Int()
    var vegflag=0
    var vegsubarray=[[String:Any]]()
    var categoryid=String()
    var imageurl=String()
    var formatteddate1=Date()
    var item=String()
    var hud:MBProgressHUD!
    var userid=String()
    var doordeliveryproductArray=[[String:Any]]()
    var subArray=[[String:Any]]()
    var selectedproductArray=[[String:Any]]()
    var foodcategoryid=String()
    var subArraysubproducts=[[String:Any]]()
    var categoriesArray=[[String:Any]]()
    var sectiontapped=Int()
    var dict4=[[String:String]]()
    var myarray=[[String:String]]()
    var cartprice=Int()
    var doordeliveryproductArrayvegonly=[[String:Any]]()
    var subArraysubproductsvegonly=[[String:Any]]()
    var productidarrayselected=[String:Int]()
    var cartflag=Int()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        food_type=UserDefaults.standard.value(forKey: "foodtype") as! Int
        
        btncartcount.layer.masksToBounds = true
        btncartcount.layer.cornerRadius = btncartcount.frame.width/2
        btncartcount.layer.borderWidth=2
        btncartcount.layer.borderColor = UIColor.white.cgColor
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        let vegswitch=vegButton(title: "Veg Only")
        // navigationItem.rightBarButtonItem=vegswitch
        // let vegonly=vegButton(imageName: "Icon feather-arrow-left", selector: #selector(veg))
        //  navigationItem.rightBarButtonItem = vegonly
        
        
        print("categorynamearray",categorynamearray)
        self.collectionviewtopbar.register(UINib(nibName: "TopbarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopbarCollectionViewCell")
        
        
        
        
        
        
        let today_date = Date()
        let format = DateFormatter()
        format.dateFormat = "HH:mm:ss"
        format.timeZone = .current
        formattedDate = format.string(from: today_date)
        formatteddate1=format.date(from: formattedDate)!
        print("formattedDate",formattedDate)
        //        UserDefaults.standard.removeObject(forKey: "vegonly")
        //        vegflag=UserDefaults.standard.value(forKey: "vegonly") as! Int
        
        let button3 = UIButton(type: .system)
        
        button3.setTitle("veg only", for: .normal)
        button3.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button3.tintColor=UIColor.darkGray
        button3.sizeToFit()
        button3.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        let barButtonItem3 = UIBarButtonItem(customView: button3)
        
        
        let button4 = UIButton(type: .system)
        button4.setImage(UIImage (named: "Icon awesome-search-1"), for: .normal)
        
        button4.tintColor=UIColor.darkGray
        
        button4.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        button4.addTarget(self, action: #selector(searchitem), for: .touchUpInside)
        let barButtonItem4 = UIBarButtonItem(customView: button4)
        
        self.navigationItem.rightBarButtonItems = [barButtonItem4,vegswitch,barButtonItem3]
        
        
        service_getsrollbarcategories()
        //service_alamofire_veg()
        
        
    }
    
    
    
    
    @objc func switchValueDidChange(sender: UISwitch!)
    {
        if sender.isOn{
            
            
            service_data_products_all_veg()
            
            
        } else{
            
            service_data_products_all()
            
        }
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        service_data_products_all()
        
        
        if let productidarray = UserDefaults.standard.value(forKey: "productidarrayselected"){
            productidarrayselected=UserDefaults.standard.value(forKey: "productidarrayselected") as! [String:Int]
        }
        
        
        
        
        if let image = UserDefaults.standard.value(forKey: "imageurl"){
            imageurl=UserDefaults.standard.value(forKey: "imageurl") as! String
        }
        
        
        if let useridvalue = UserDefaults.standard.value(forKey: "userid") {
            userid=UserDefaults.standard.value(forKey:"userid") as! String
            
        }
        
        if let array=UserDefaults.standard.array(forKey: "myarray"){
            if array.isEmpty==true{
                btnviewcart.isHidden=true
            }else{
                myarray=UserDefaults.standard.array(forKey: "myarray") as! [[String : String]]
                btnviewcart.isHidden=false
                btncartcount.setTitle(String(array.count), for: .normal)
                if let totalpriceincart=UserDefaults.standard.value(forKey: "carttotalprice"){
                    if totalpriceincart==nil{
                    }else{
                        carttotalprice=UserDefaults.standard.value(forKey: "carttotalprice") as! Int
                        
                        lbltotalcartprice.text="₹ "+String(carttotalprice)
                    }
                    
                    
                }
            }
        }
        
        
        self.navigationController?.navigationBar.barTintColor = .white
        //self.navigationController?.navigationBar.isTranslucent = false
        
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
        if food_type==1{
            title = " Door Delivery"
        }else if food_type==3{
            title = " Table Booking"
        }else if food_type==4{
            title = " Take Away"
        }
        
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 20.0)
        lbl.textColor =  UIColor.darkGray
        lbl.textAlignment = .left
        navigationItem.titleView=lbl
        
        
        
        //                    if UserDefaults.standard.value(forKey: "roomtype") == 0{
        //                        roomtype=1
        //                    }else{
        //                        roomtype=UserDefaults.standard.value(forKey: "roomtype") as! Int
        //                    }
        
        
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
        if cartflag==1{
            let cart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
            
          
            
            self.navigationController?.pushViewController(cart, animated: true)
        }else{
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                   
                                   let sw = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                   
                                   self.view.window?.rootViewController = sw
                                   
                                   let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "HomepageViewController") as! HomepageViewController
                                   
                                   
                                   let navigationController = UINavigationController(rootViewController: destinationController)
                                   
                                   
                                   
                                   sw.pushFrontViewController(navigationController, animated: true)
            
       // self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    func vegButton(title:String) -> UIBarButtonItem {
        let switchControl = UISwitch(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 30)))
        switchControl.isOn = false
        switchControl.onTintColor = UIColor.green
        
        switchControl.setOn(false, animated: false)
        
        
        switchControl.addTarget(self, action: #selector(switchValueDidChange(sender:)), for: .valueChanged)
        return UIBarButtonItem(customView: switchControl)
    }
    
    @objc func searchitem(){
        let search = self.storyboard?.instantiateViewController (withIdentifier: "SearchproductsViewController") as! SearchproductsViewController
        
        search.vegflag=vegflag
        
        self.navigationController?.pushViewController(search, animated: true)
        
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        if collectionView==collectionviewsubcategory{
            //            if vegflag==1{
            //                return  doordeliveryproductArrayvegonly.count
            //            }else{
            return doordeliveryproductArray.count
            
            
        }else{
            return 1
        }
        //        return
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView==collectionviewsubcategory{
            var item=[String:Any]()
            // var sub=[[String:Any]]()
            //            if vegflag==1{
            //                item=doordeliveryproductArrayvegonly[section]
            //                let sub=item["sub"] as! [[String:Any]]
            //
            //                return sub.count
            //
            //
            //            }else{
            item=doordeliveryproductArray[section]
            let sub=item["sub"] as! [[String:Any]]
            return sub.count
            //            }
            
            
            
        }else{
            return categorynamearray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView==collectionviewsubcategory{
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SubcategoryCollectionViewCell",for: indexPath) as! SubcategoryCollectionViewCell
            var item=[String:Any]()
            var subProduct=[String:Any]()
            
            item=doordeliveryproductArray[indexPath.section]
            let sub=item["sub"] as! [[String:Any]]
            
            subProduct=sub[indexPath.row]
            cell1.lblnameofproduct.text=subProduct["product_name"] as! String
            cell1.lblprice.text="₹ "+String(subProduct["price"] as! String)
            
            if subProduct["type"] as! String=="1"{
                cell1.lblvegnonveg.text="Veg"
                cell1.imageviewvegnonveg.image=UIImage(named:"Ellipse 419")
            }else{
                cell1.lblvegnonveg.text="Non-Veg"
                cell1.imageviewvegnonveg.image=UIImage(named:"Ellipse 419-1")
                
            }
            let totalimage=imageurl+String(subProduct["product_image"] as! String)
            let url = URL(string:totalimage)
            cell1.imageviewproduct.kf.indicatorType = .activity
            cell1.imageviewproduct.kf.setImage(with: url)
            cell1.imageviewproduct.contentMode = .scaleToFill
            
            
            
            cell1.lblnotavailable.isHidden=true
            
            // cell1.backgroundColor=UIColor.lightGray
//            cell1.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//            cell1.layer.shadowRadius = 10.0
//            cell1.layer.shadowOpacity = 0.3
            cell1.layer.cornerRadius=10
            
            if indexPath.section==0{
                if food_type==1||food_type==4{
                    cell1.lblnotavailable.isHidden=false
                    cell1.isUserInteractionEnabled=false
//                    cell1.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                    cell1.cardview.isHidden=false
                    
                   // cell1.cardview.modalPresentationStyle = .custom
                   // cell1.cardview.isOpaque = false
                   
                   // cell1.cardview.backgroundColor = UIColor.black.withAlphaComponent(0.2)
//                    cell1.cardview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//                    cell1.cardview.layer.shadowRadius = 10.0
//                    cell1.cardview.layer.shadowOpacity = 0.3
                    cell1.cardview.layer.cornerRadius=10
//                    cell1.cardview.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                }else{
                    cell1.lblnotavailable.isHidden=true
                    cell1.isUserInteractionEnabled=true
                     cell1.cardview.isHidden=true
//                    cell1.backgroundColor = UIColor.black.withAlphaComponent(0.04)
//                    cell1.cardview.backgroundColor = UIColor.black.withAlphaComponent(0.04)
                }
                
            }else{
                cell1.lblnotavailable.isHidden=true
                cell1.isUserInteractionEnabled=true
                 cell1.cardview.isHidden=true
//                cell1.backgroundColor = UIColor.black.withAlphaComponent(0.04)
//                cell1.cardview.backgroundColor = UIColor.black.withAlphaComponent(0.04)
            }
            
            
            let dateAsStringstarttime = item["start_time"] as! String
            let dateAsStringendtime = item["end_time"] as! String
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let startdate=dateFormatter.date(from: dateAsStringstarttime)
            let enddate=dateFormatter.date(from: dateAsStringendtime)
            print("dateAsStringstarttime",dateAsStringstarttime)
            print("dateAsStringstarttime",dateAsStringstarttime)
            var result: ComparisonResult? = nil
            var result2: ComparisonResult? = nil
            result = formatteddate1.compare(startdate!)
            result2=formatteddate1.compare(enddate!)
            if result == .orderedDescending {
                if result2 == .orderedDescending {
                    if indexPath.section==0{
                        cell1.lblnotavailable.isHidden=false
                        cell1.isUserInteractionEnabled=false
                        cell1.cardview.isHidden=false
//                        cell1.backgroundColor = UIColor.black.withAlphaComponent(0.1)

                    }else{

                        cell1.lblnotavailable.isHidden=true
                        cell1.isUserInteractionEnabled=true
                         cell1.cardview.isHidden=true
                    }
                }
            } else if result == .orderedAscending {
                if result2 == .orderedAscending{
                    print("date2 is later than date1")
                    cell1.lblnotavailable.isHidden=false
                    cell1.isUserInteractionEnabled=false
                    cell1.cardview.isHidden=false
//                    cell1.backgroundColor = UIColor.black.withAlphaComponent(0.1)

                }
            } else {
                print("date1 is equal to date2")
                cell1.lblnotavailable.isHidden=true
                cell1.isUserInteractionEnabled=true
                cell1.cardview.isHidden=true
            }
            cell1.delegate=self
            if subProduct["count"] as! Int==0{
                cell1.btnadd.isHidden=false
                cell1.viewadd.isHidden=true
                
            }else{
                cell1.btnadd.isHidden=true
                cell1.viewadd.isHidden=false
                cell1.lblcount.text=(subProduct["count"] as! NSNumber).stringValue
            }
            
            
            
            cell1.indexPath=indexPath
            
            //           cell1.btnadd.addTarget(self, action: #selector(btnplustapped(sender:)), for: .touchUpInside)
            return cell1
            
        }else{
            
            cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "TopbarCollectionViewCell", for: indexPath) as! TopbarCollectionViewCell
            
            categoryid=categoryidarray[indexPath.row]
            cell2.lblcategoryname.text=categorynamearray[indexPath.row].uppercased()
            cell2.lblcategoryname.sizeToFit()
            cell2.lblscrolldirection.sizeToFit()
            //cell2.lblcategoryname.textColor = .red
            cell2.lblscrolldirection.backgroundColor = .red
            
            if selectedIndex==indexPath.row{
                cell2.lblcategoryname.textColor = .red
                cell2.lblscrolldirection.isHidden=false
                cell2.lblscrolldirection.backgroundColor = .red
            }else if selectedIndex==100{
                cell2.lblcategoryname.textColor = .red
                cell2.lblscrolldirection.isHidden=true
            }else{
                cell2.lblcategoryname.textColor = .darkGray
                cell2.lblscrolldirection.isHidden=true
            }
            
            return cell2
            
        }
    }
    func closeFriendsTapped(at index: IndexPath) {
        self.subArraysubproducts.removeAll()
        self.subArraysubproductsvegonly.removeAll()
        
        var foodcatgryid=String()
        var selected=[String:Any]()
        var item = [String:Any]()
        let row=index.row
        let section=index.section
        var myrow=Int()
        
        //        if vegflag==1{
        //            item = self.doordeliveryproductArrayvegonly[section]
        //            foodcatgryid=item["food_category_id"] as! String
        //            self.subArraysubproductsvegonly=item["sub"] as! [[String:Any]]
        //            if self.subArraysubproductsvegonly.count>0{
        //                selected=self.subArraysubproductsvegonly[row]
        //                selected["count"] = (selected["count"]  as! Int) + 1
        //                self.subArraysubproductsvegonly[row]=selected
        //            }
        //            self.doordeliveryproductArrayvegonly[section]["sub"]=self.subArraysubproductsvegonly
        //            UserDefaults.standard.set(doordeliveryproductArrayvegonly, forKey: "doordeliveryproductArrayvegonly")
        //
        //            let  item = self.doordeliveryproductArray[section]
        //            self.subArraysubproducts=item["sub"] as! [[String:Any]]
        //            for i in 0...subArraysubproducts.count-1{
        //                let item=subArraysubproducts[i]
        //                if item["product_id"] as! String==selected["product_id"]as! String{
        //                               let index=i
        //                               myrow = index
        //                           }
        //                       }
        //
        //
        //            var selected=self.subArraysubproducts[myrow]
        //            selected["count"] = (selected["count"]  as! Int) + 1
        //            self.subArraysubproducts[myrow]=selected
        //
        //            print("subArraysubproducts",self.subArraysubproducts)
        //
        //            self.doordeliveryproductArray[section]["sub"]=self.subArraysubproducts
        //            print("doordeliveryproductArray",self.doordeliveryproductArray)
        //
        //             UserDefaults.standard.set(doordeliveryproductArray, forKey: "doordeliveryproductArray")
        
        
        //        }else{
        item = self.doordeliveryproductArray[section]
        
        foodcatgryid=item["food_category_id"] as! String
        self.subArraysubproducts=item["sub"] as! [[String:Any]]
        if self.subArraysubproducts.count>0{
            selected=self.subArraysubproducts[row]
            selected["count"] = (selected["count"]  as! Int) + 1
            let selectedproductid=selected["product_id"] as! String
            if self.productidarrayselected[selectedproductid]==nil{
                
                productidarrayselected.updateValue(selected["count"] as! Int, forKey: selectedproductid)
            }else{
                for (key,value) in self.productidarrayselected{
                    if key==selectedproductid as! String{
                        productidarrayselected.removeValue(forKey: selectedproductid)
                        
                        // selected["count"] = value+1
                        productidarrayselected.updateValue(selected["count"] as! Int, forKey: selectedproductid)
                    }else{
                        // selected["count"] = value+1
                        productidarrayselected.updateValue(selected["count"] as! Int, forKey: selectedproductid)
                    }
                }
            }
            
            
            
            
            // selected["count"] = (selected["count"]  as! Int) + 1
            self.subArraysubproducts[row]=selected
            
            self.doordeliveryproductArray[section]["sub"]=self.subArraysubproducts
        }
       UserDefaults.standard.set(self.productidarrayselected, forKey: "productidarrayselected")
        
        collectionviewsubcategory.reloadData()
        
        
        let product_id=selected["product_id"] as! String
        let price=(selected["price"] as! NSString).integerValue
        let count=selected["count"] as! Int
        var price_value=Int()
        price_value=price*count
        print("price_value",price_value)
        let product_name=selected["product_name"] as! String
        
        var items=[String:String]()
        items.updateValue(foodcatgryid, forKey: "foodcatgryid")
        items.updateValue(product_id, forKey: "id")
        items.updateValue(String(price), forKey: "actualprice")
        items.updateValue(String(price_value), forKey: "totalprice")
        items.updateValue(String(count), forKey: "quantityincreased")
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
        cartprice=0
        for values in myarray{
            let item:[String:String]=values as [String:String]
            cartprice+=(item["totalprice"]as! NSString).integerValue
            print("cartprice",cartprice)
        }
        UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
        
        
        if let array=UserDefaults.standard.array(forKey: "myarray"){
            if array.isEmpty==true{
                btnviewcart.isHidden=true
            }else{
                btnviewcart.isHidden=false
                btncartcount.setTitle(String(array.count), for: .normal)
                if let totalpriceincart=UserDefaults.standard.value(forKey: "carttotalprice"){
                    if totalpriceincart==nil{
                    }else{
                        carttotalprice=UserDefaults.standard.value(forKey: "carttotalprice") as! Int
                        
                        lbltotalcartprice.text="₹ "+String(carttotalprice)
                    }
                    
                    
                }
            }
        }
        
        
       
        
    }
    
    
    func btnminustapped(at index: IndexPath) {
        
        var foodcatgryid=String()
        var selected=[String:Any]()
        var item = [String:Any]()
        let row=index.row
        let section=index.section
        item = self.doordeliveryproductArray[section]
         
         foodcatgryid=item["food_category_id"] as! String
         self.subArraysubproducts=item["sub"] as! [[String:Any]]
         if self.subArraysubproducts.count>0{
             selected=self.subArraysubproducts[row]
             selected["count"] = (selected["count"]  as! Int) - 1
             let selectedproductid=selected["product_id"] as! String
             if self.productidarrayselected[selectedproductid]==nil{
                 
                 productidarrayselected.updateValue(selected["count"] as! Int, forKey: selectedproductid)
             }else{
                 for (key,value) in self.productidarrayselected{
                     if key==selectedproductid as! String{
                         productidarrayselected.removeValue(forKey: selectedproductid)
                         
                         // selected["count"] = value+1
                         productidarrayselected.updateValue(selected["count"] as! Int, forKey: selectedproductid)
                     }else{
                         // selected["count"] = value+1
                         productidarrayselected.updateValue(selected["count"] as! Int, forKey: selectedproductid)
                     }
                 }
             }
             
             
             
             
             // selected["count"] = (selected["count"]  as! Int) + 1
             self.subArraysubproducts[row]=selected
             
             self.doordeliveryproductArray[section]["sub"]=self.subArraysubproducts
         }
        
          UserDefaults.standard.set(self.productidarrayselected, forKey: "productidarrayselected")
        
        collectionviewsubcategory.reloadData()
        
        let product_id=selected["product_id"] as! String
        let price=(selected["price"] as! NSString).integerValue
        let count=selected["count"] as! Int
        var price_value=Int()
        price_value=price*count
        print("price_value",price_value)
        let product_name=selected["product_name"] as! String
        
        
        var items=[String:String]()
        items.updateValue(foodcatgryid, forKey: "foodcatgryid")
        items.updateValue(product_id, forKey: "id")
        items.updateValue(String(price), forKey: "actualprice")
        items.updateValue(String(price_value), forKey: "totalprice")
        items.updateValue(String(count), forKey: "quantityincreased")
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
            print("myarray",myarray)
            
            if count==0{
                
            }else{
                
                myarray.append(items)
            }
            
            UserDefaults.standard.set(myarray, forKey: "myarray")
        }
        
        
        myarray=UserDefaults.standard.array(forKey: "myarray") as! [[String : String]]
        
        
        print("myarray",myarray)
        print("dict4",dict4)
        cartprice=0
        for values in myarray{
            let item:[String:String]=values as [String:String]
            cartprice+=(item["totalprice"]as! NSString).integerValue
            print("cartprice",cartprice)
        }
        UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
        
        
        if let array=UserDefaults.standard.array(forKey: "myarray"){
            if array.isEmpty==true{
                btnviewcart.isHidden=true
            }else{
                btnviewcart.isHidden=false
                btncartcount.setTitle(String(array.count), for: .normal)
                if let totalpriceincart=UserDefaults.standard.value(forKey: "carttotalprice"){
                    if totalpriceincart==nil{
                    }else{
                        carttotalprice=UserDefaults.standard.value(forKey: "carttotalprice") as! Int
                        
                        lbltotalcartprice.text="₹ "+String(carttotalprice)
                    }
                    
                    
                }
            }
        }
        
        
        
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if collectionView==collectionviewsubcategory{
            
            if let id=UserDefaults.standard.value(forKey: "userid"){
                //            selectediindexsection=indexPath.item
                //                selectedIndex = indexPath.item
                ////                let item=doordeliveryproductArray[indexPath.section]
                ////                let sub=item["sub"] as! [[String:Any]]
                ////
                ////                let subProduct=sub[indexPath.row]
                //
                //                let subProduct=totalproducts1[indexPath.section].sub![indexPath.item]
                //                var item=[String:String]()
                //                item.updateValue(subProduct.product_name!, forKey: "product_name")
                //                item.updateValue(subProduct.product_id!, forKey: "product_id")
                //                item.updateValue(subProduct.price!, forKey: "price")
                //                item.updateValue(subProduct.product_quantity!, forKey: "product_quantity")
                //                item.updateValue(subProduct.type!, forKey: "type")
                //                item.updateValue(subProduct.product_image!, forKey: "product_image")
                //                dict1.append(item)
                //
                //                let details = self.storyboard?.instantiateViewController (withIdentifier: "Productdetailsdemoviewcontroller") as! Productdetailsdemoviewcontroller
                //
                //                details.product_id=subProduct.product_id!
                //                details.product_name=subProduct.product_name!
                //                details.price_value=(subProduct.price as! NSString).integerValue
                //
                //                details.dict=dict1
                //
                //
                //                details.product_image=imageurl+subProduct.product_image!
                //
                //
                //
                //                self.navigationController?.pushViewController(details, animated: true)
            }else{
                
                let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                    
                    let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
                    launch.searchroomflag=2
                    self.navigationController?.pushViewController(launch, animated: true)
                    
                }))
                
                self.present(alert, animated: true)
                
            }
            
            
            
        }else{
            selectedIndex = indexPath.item
            // item=totalproducts1[indexPath.section].sub![indexPath.item]
            print("selectedIndex",selectedIndex)
            scrollToFirstRow()
            self.collectionviewtopbar.reloadData()
        }
        
    }
    
    func scrollToFirstRow() {
        print("selectedIndex",selectedIndex)
        let indexPath = NSIndexPath(item: 0, section: selectedIndex)
        self.collectionviewsubcategory.scrollToItem(at: indexPath as IndexPath, at: .top, animated: true)
        
        //        self.collectionviewsubcategory?.scrollToItem(at:IndexPath(item: selectediindexsection, section: selectedIndex), at: .top, animated: false)
    }
    
    
    
    
    func collectionscrollToFirstRow() {
        let indexPath = NSIndexPath(item: selectedIndex, section: 0)
        self.collectionviewtopbar.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
        
        collectionviewtopbar.reloadData()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView==collectionviewsubcategory{
            scrollingFinish()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView==collectionviewsubcategory{
            scrollingFinish()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            if scrollView==collectionviewsubcategory{
                scrollingFinish()
            }
        }
    }
    
    func scrollingFinish() {
        print("Scroll Finished!")
        var indexPath=IndexPath()
        for cell in collectionviewsubcategory.visibleCells {
            indexPath = collectionviewsubcategory.indexPath(for: cell)!
            print(indexPath)
        }
        let firstVisibleIndexPath = self.collectionviewsubcategory.indexPathsForVisibleItems[0]
        selectedIndex=indexPath.section
        // selectedIndex=firstVisibleIndexPath.item
        print("selectedIndex",selectedIndex)
        collectionscrollToFirstRow()
        
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        if collectionView==collectionviewsubcategory{
            //                let screenSize: CGRect = UIScreen.main.bounds
            //                 let screenWidth = screenSize.width
            
            return CGSize(width: CGFloat((collectionviewsubcategory.frame.size.width/2)-5), height: CGFloat(220))
            //                return CGSize(width: screenSize.width/2, height: 200)
        }else{
            
            // return CGSize (width: 200, height: 61)
            //return CGSize(width:200.0,height:61.0)
            return CGSize(width:collectionviewtopbar.frame.size.width/2-10,height:60.0)
        }
    }
    
    
    
    func productidvalue(productid: String,productname:String,pricevalue:Int,dict1:[[String:String]],productimage:String){
        let details = self.storyboard?.instantiateViewController (withIdentifier: "Productdetailsdemoviewcontroller") as! Productdetailsdemoviewcontroller
        
        details.product_id=productid
        details.product_name=productname
        details.price_value=pricevalue
        
        details.dict=dict1
        
        
        details.product_image=productimage
        
        
        
        self.navigationController?.pushViewController(details, animated: true)
        
    }
    
    
    
    func service_getsrollbarcategories(){
        // self.showhud()
        let url = URL(string: "https://niyaregency.com/api/Data/category/niya32jfhdu392nfbfdr")!
        var request  = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if(error != nil)
            {
                
                
                print(error!)
                return;
            }
            
            // let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary{
                    print("json",json)
                    let status=json["status"]
                    let categories=json["categories"]as! [[String:Any]]
                    self.categoriesArray.append(contentsOf:categories)
                    for values in categories{
                        let item:[String:Any]=values as! [String:Any]
                        self.foodcategoryid=item["food_category_id"] as! String
                        let categoryname=item["category_name"]as! String
                        let starttime=item["start_time"]as! String
                        let endtime=item["end_time"]as! String
                        self.categorynamearray.append(categoryname)
                        self.categoryidarray.append(self.foodcategoryid)
                        self.starttimearray.append(starttime)
                        self.endtimearray.append(endtime)
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        //self.hud.hide(animated: true)
                        self.collectionviewtopbar.reloadData()
                        
                    }
                    
                }
            } catch  {
                
                print(error)
                
            }
        }
        task.resume()
    }
    
    
    //    func service_data_products(){
    //
    //     let url = NSURL(string:"https://niyaregency.com/api/Data/products")
    //
    //    let poststring="security_token=niya32jfhdu392nfbfdr&category_id=\(foodcategoryid)&activity_id=1"
    //        var request = NSMutableURLRequest(url: url as! URL)
    //    request.httpMethod = "POST"
    //    request.httpBody = poststring.data(using: String.Encoding.utf8)
    //    let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
    //
    //        if error != nil{
    //            print("error",error)
    //            return
    //        }
    //        print("poststring",poststring)
    //        let responsestring=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
    //
    //        print("respnsedate,\(responsestring)")
    //
    //            do {
    //
    //                if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary{
    //                    print("json",json)
    //                     let status=json["status"]as! Bool
    //                     if status==true{
    //                    let products = json["products"] as! [String:Any]
    //                    self.imageurl=json["image_url"] as! String
    //                    let totalproducts=products["products"] as! [[String:Any]]
    //                        self.subArraysubproducts.append(contentsOf: totalproducts)
    //
    //                    DispatchQueue.main.async {
    //                        //self.hud.hide(animated: true)
    //                        self.collectionviewsubcategory.reloadData()
    //
    //                    }
    //
    //                }
    //                }
    //            } catch  {
    //
    //                print(error)
    //
    //            }
    //        }
    //        task.resume()
    //    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Sectionheaderview", for: indexPath) as! Sectionheaderview
            var item=[String:Any]()
//            if vegflag==1{
//                item=doordeliveryproductArrayvegonly[indexPath.section]
//            }else{
                item=doordeliveryproductArray[indexPath.section]
//            }
            let sub=item["sub"] as! [[String:Any]]
            
            if indexPath.section==0{
                sectionHeader.lblline.isHidden=true
            }else{
                sectionHeader.lblline.isHidden=false
            }
            // sectionHeader.lblmaincategory.text = totalproducts1[indexPath.section].category_name
            // sectionHeader.lblnumberofitem.text = String(totalproducts1[indexPath.section].sub!.count)+" items"
            sectionHeader.lblmaincategory.text = item["category_name"] as! String
            sectionHeader.lblnumberofitem.text = String(sub.count)+" items"
            return sectionHeader
        } else { //No footer in this case but can add option for that
            return UICollectionReusableView()
        }
    }
    
    
    
    
    
    
    
    func service_alamofire_veg(){
        self.showhud()
        var url=String()
        let params:[String : AnyObject] = ["security_token":"niya32jfhdu392nfbfdr" as AnyObject]
        if vegflag==0{
            url = "https://niyaregency.com/api/Data/products_all"
        }else{
            print("params:",params)
            url = "https://niyaregency.com/api/Data/products_all_veg"
        }
        AF.request(url, method: .post, parameters:params,encoding: URLEncoding.default, headers: nil).responseString {
            response in
            
            switch response.result {
            case .success:
                if let jsonStr = response.value{
                    let responseObj = Mapper<UserResponse>().map(JSONString:jsonStr)
                    
                    if let status = responseObj?.status{
                        
                        if status{
                            if let responseObject = responseObj?.products{
                                // completion(true, AppAlertMsg.NetWorkAlertMessage,responseObject)
                                print("responseObject",responseObject)
                                self.imageurl=(responseObject.image_url!)
                                self.totalproducts1=(responseObj?.products!.products)!
                                //                                    self.productArray.append(contentsOf:totalproducts )
                                //                                    for index in 0...self.productArray.count - 1 {
                                //                                        var item = self.productArray[index]
                                //                                        self.subArray=item["sub"] as! [[String:Any]]
                                //                                        // self.productArray[index] = item
                                //                                        for i in 0...self.subArray.count-1{
                                //                                            var selected=self.subArray[i]
                                //                                            selected["isselected"] = 0
                                //                                            self.subArray[i]=selected
                                //
                                //                                        }
                                //                                        print("subArray",self.subArray)
                                //
                                //                                        self.productArray[index]["sub"]=self.subArray
                                // let sub=totalproducts1.
                                DispatchQueue.main.async {
                                    self.hud.hide(animated: true)
                                    self.collectionviewsubcategory.reloadData()
                                }
                                //                                for dataList in self.totalproducts1 {
                                //                                    print(dataList)
                                //                                    let obj = Model(dict: dataList)
                                //                                    self.arrList.append(obj)
                                //                                    self.collection.reloadData()
                                //                                }
                                
                            }else{
                                print("noresult")
                            }
                        }
                    }else{
                        // completion(false, AppAlertMsg.NetWorkAlertMessage,nil)
                    }
                    break
                }
            case .failure(let error):
                //completion(false, AppAlertMsg.NetWorkAlertMessage,nil)
                print(error)
                
            }
        }
        
    }
    
    
    func service_data_products_all_veg(){
        let url = NSURL(string:"https://niyaregency.com/api/Data/products_all_veg")!
        
        
        let poststring="security_token=niya32jfhdu392nfbfdr"
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
                        let products = parseJson["products"] as! [String:Any]
                        self.imageurl=products["image_url"] as! String
                        let totalproducts=products["products"] as! [[String:Any]]
                        self.doordeliveryproductArray.removeAll()
                        self.doordeliveryproductArray.append(contentsOf:totalproducts )
                       
                        print("productidarrayselected",self.productidarrayselected)
                        
                        for index in 0...self.doordeliveryproductArray.count - 1 {
                            var item = self.doordeliveryproductArray[index]
                            self.subArraysubproductsvegonly=item["sub"] as! [[String:Any]]
                            print("subArraysubproductsvegonly",self.subArraysubproductsvegonly)
                            if self.subArraysubproductsvegonly.count>0{
                                for i in 0...self.subArraysubproductsvegonly.count-1{
                                    var selected=self.subArraysubproductsvegonly[i]
                                    selected["count"] = 0
                                    
                                    self.subArraysubproductsvegonly[i]=selected
                                    
                                    
                                    let selectedproductid=selected["product_id"] as! String
                                    //                                    if self.productidarrayselected[selectedproductid]==nil{
                                    //                                        selected["count"] = 0
                                    //                                        self.productidarrayselected.updateValue(selected["count"] as! Int, forKey: selectedproductid)
                                    //                                    }else{
                                    for (key,value) in self.productidarrayselected{
                                        if key==selectedproductid {
                                            selected["count"] = value
                                            self.subArraysubproductsvegonly[i]=selected
                                        }else{
                                            selected["count"] = value
                                        }
                                    }
                                    //                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                                print("subArraysubproductsvegonly",self.subArraysubproductsvegonly)
                                self.doordeliveryproductArray[index]["sub"]=self.subArraysubproductsvegonly
                                
                            }
                        }
                        print("productidarrayselected",self.productidarrayselected)
                        UserDefaults.standard.set(self.productidarrayselected, forKey: "productidarrayselected")
                        
                        DispatchQueue.main.async {
                            
                            self.collectionviewsubcategory.reloadData()
                        }
                        
                        
                    }else{
                        
                    }
                }
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    
    
    
    func service_data_products_all(){
        
        
        let url = NSURL(string:"https://niyaregency.com/api/Data/products_all")!
        
        
        let poststring="security_token=niya32jfhdu392nfbfdr"
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
                        let products = parseJson["products"] as! [String:Any]
                        self.imageurl=products["image_url"] as! String
                        let totalproducts=products["products"] as! [[String:Any]]
                        self.doordeliveryproductArray.removeAll()
                        self.doordeliveryproductArray.append(contentsOf:totalproducts )
                        
                        
                        for index in 0...self.doordeliveryproductArray.count - 1 {
                            var item = self.doordeliveryproductArray[index]
                            self.subArraysubproducts=item["sub"] as! [[String:Any]]
                            // self.productArray[index] = item
                            if self.subArraysubproducts.count>0{
                                for i in 0...self.subArraysubproducts.count-1{
                                    var selected=self.subArraysubproducts[i]
                                    selected["count"] = 0
                                    
                                    self.subArraysubproducts[i]=selected
                                    
                                    let selectedproductid=selected["product_id"] as! String
                                    //                                if self.productidarrayselected[selectedproductid]==nil{
                                    //                                    selected["count"] = 0
                                    //                                    self.productidarrayselected.updateValue(selected["count"] as! Int, forKey: selectedproductid)
                                    //                                }else{
                                    for (key,value) in self.productidarrayselected{
                                        if key==selectedproductid as! String{
                                            selected["count"] = value
                                            self.subArraysubproducts[i]=selected
                                        }else{
                                            selected["count"] = value
                                        }
                                    }
                                    //                                }
                                    
                                    //                                self.subArraysubproducts[i]=selected
                                    
                                }
                                print("subArraysubproducts",self.subArraysubproducts)
                                
                                self.doordeliveryproductArray[index]["sub"]=self.subArraysubproducts
                                
                            }
                        }
                        UserDefaults.standard.set(self.productidarrayselected, forKey: "productidarrayselected")
                        //                        UserDefaults.standard.set(self.imageurl, forKey: "imageurl")
                        
                        print("productidarrayselected",self.productidarrayselected)
                        DispatchQueue.main.async {
                            
                            self.collectionviewsubcategory.reloadData()
                        }
                        
                        
                    }else{
                        
                    }
                }
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    
    @IBAction func btnviewcartaction(_ sender: Any) {
        
        if userid.isEmpty==true||userid==""||userid==nil{
            showToast(message: "Please login to continue", font: UIFont.boldSystemFont(ofSize: 14),duration: 2)
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let sw = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            
            self.view.window?.rootViewController = sw
            
            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
            destinationController.searchroomflag=2
            
            let navigationController = UINavigationController(rootViewController: destinationController)
            
            
            
            sw.pushFrontViewController(navigationController, animated: true)
            
            //           let launchscreen = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
            //
            //
            //                self.navigationController?.pushViewController(launchscreen, animated: true)
            
        }else{
            
            let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
            
            
            self.navigationController?.pushViewController(yourcart, animated: true)
            
        }
    }
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
}
