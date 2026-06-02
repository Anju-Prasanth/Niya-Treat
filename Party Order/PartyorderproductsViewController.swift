//
//  PartyorderproductsViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 27/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import MBProgressHUD

@available(iOS 13.0, *)
class PartyorderproductsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var btnviewcart: UIButton!
    @IBOutlet weak var tableviewpartyorder: UITableView!
    
    var cell=PartyorderTableViewCell()
    
    
    var mainmenuidarray=[String]()
    var submenuidarray=[String]()
    var mainmenunamearray=[String]()
    var mainmenupricearray=[String]()
    var menudescriptionarray=[String]()
    var dict2=[[String:String]]()
    var mainitemmenuarray=[[String:String]]()
    var hud:MBProgressHUD!
    var userid=String()
    var nonvegitemarray=[[String:String]]()
    var additemflag=Int()
    var partyorderselectedarray=[String:Any]()
    var addedidtocart=String()
    var menutoken=String()
    var mainidtodelete=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        self.tableviewpartyorder.register(UINib(nibName: "PartyorderTableViewCell", bundle: nil), forCellReuseIdentifier: "PartyorderTableViewCell")
        if #available(iOS 13.0, *){
            self.isModalInPresentation = true
        }
        service_party_products()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        
        
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
        title = " Party Order"
        
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 20.0)
        lbl.textColor =  UIColor.darkGray
        lbl.textAlignment = .left
        navigationItem.titleView=lbl
        
        if let useridvalue = UserDefaults.standard.value(forKey: "userid") {
            userid=UserDefaults.standard.value(forKey:"userid") as! String
            
        }
        //                        if let nonvegarray=UserDefaults.standard.array(forKey: "nonvegitemarray"){
        //                            if nonvegarray.isEmpty==true{
        //                                                         
        //                                                           
        //                                        }else{
        //                                nonvegitemarray=UserDefaults.standard.array(forKey: "nonvegitemarray") as! [[String:String]]
        //                            }
        //                        }
        
        
        if let array=UserDefaults.standard.array(forKey: "mainmenuitemarraycart"){
            if array.isEmpty==true{
                // btnviewcart.isHidden=true
                
            }else{
                mainitemmenuarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String:String]]
                //  btnviewcart.isHidden=false
            }
        }
        print("mainitemmenuarray",mainitemmenuarray)
        
        if let partyorderseleced=UserDefaults.standard.value(forKey: "partyorderselectedarray"){
            partyorderselectedarray=UserDefaults.standard.value(forKey: "partyorderselectedarray") as! [String : Any]
        }
        
         if let addedid=UserDefaults.standard.value(forKey: "addedidtocart"){
        
            btnviewcart.isHidden=false
        }else{
            btnviewcart.isHidden=true
        }
        
        if let addedid=UserDefaults.standard.value(forKey: "addedidtocart"){
            addedidtocart=addedid as! String
        }
        
        if let menu_token=UserDefaults.standard.value(forKey: "menutoken"){
            
            menutoken=menu_token as! String
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
        print("addedid",UserDefaults.standard.value(forKey: "addedidtocart"))
        if let addedid=UserDefaults.standard.value(forKey: "addedidtocart"){
            var refreshAlert = UIAlertController(title: "Your cart will be cleared.Do you really wish to continue?", message: "", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let sw = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                
                self.view.window?.rootViewController = sw
                
                let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "HomepageViewController") as! HomepageViewController
                
                
                let navigationController = UINavigationController(rootViewController: destinationController)
                
                
                
                sw.pushFrontViewController(navigationController, animated: true)
                
                
                
                
               // self.dismiss(animated: false, completion: nil)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                
                
                
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
            
            
        }else{
            
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let sw = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            
            self.view.window?.rootViewController = sw
            
            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "HomepageViewController") as! HomepageViewController
            
            
            let navigationController = UINavigationController(rootViewController: destinationController)
            
            
            
            sw.pushFrontViewController(navigationController, animated: true)
            
            
           // self.dismiss(animated: false, completion: nil)
            
            
            
        }
    }
    
    
    
    
    
    
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainmenunamearray.count
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = (tableView.dequeueReusableCell(withIdentifier: "PartyorderTableViewCell", for: indexPath) as? PartyorderTableViewCell)!
        cell.lblmenuname.text=mainmenunamearray[indexPath.row]
        cell.lblprice.text="₹ "+mainmenupricearray[indexPath.row]
        cell.lbldescription.text=menudescriptionarray[indexPath.row]
        cell.lbldescription.sizeToFit()
        cell.btnview.tag=indexPath.row
        cell.btnview.addTarget(self, action: #selector(btnviewaction(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 157
    }
    @objc func btnviewaction(sender:UIButton){
        if let id=UserDefaults.standard.value(forKey: "userid"){
            let expansion = self.storyboard?.instantiateViewController (withIdentifier: "ExpandcollapseViewController") as!  ExpandcollapseViewController
            expansion.id=mainmenuidarray[sender.tag]
            expansion.list=submenuidarray[sender.tag]
            expansion.mainmenuname=mainmenunamearray[sender.tag]
            expansion.mainmenuprice=mainmenupricearray[sender.tag]
            
            
            self.navigationController?.pushViewController(expansion, animated: true)
        }else{
            
            let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                
                let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
                launch.searchroomflag=3
                self.navigationController?.pushViewController(launch, animated: true)
                
            }))
            
            self.present(alert, animated: true)
            
            
            
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //         let expansion = self.storyboard?.instantiateViewController (withIdentifier: "DemoTableViewController") as!  DemoTableViewController
        //         expansion.id=mainmenuidarray[indexPath.row]
        //         expansion.list=submenuidarray[indexPath.row]
        //        self.navigationController?.pushViewController(expansion, animated: true)
        // if let id=UserDefaults.standard.value(forKey: "userid"){
        print("partyorderselectedarray",partyorderselectedarray)
        if partyorderselectedarray.isEmpty==true{
            
            
            let expansion = self.storyboard?.instantiateViewController (withIdentifier: "ExpandcollapseViewController") as!  ExpandcollapseViewController
            expansion.id=mainmenuidarray[indexPath.row]
            expansion.list=submenuidarray[indexPath.row]
            expansion.mainmenuname=mainmenunamearray[indexPath.row]
            expansion.mainmenuprice=mainmenupricearray[indexPath.row]
            expansion.additemflag=additemflag
            //            UserDefaults.standard.removeObject(forKey: "idforpartyorder")
            //            UserDefaults.standard.removeObject(forKey: "listforpartyorder")
            //         UserDefaults.standard.removeObject(forKey: "mainmenunamepartyorder")
            
            
            self.navigationController?.pushViewController(expansion, animated: true)
        }else{
            
            if let addedid=UserDefaults.standard.value(forKey: "addedidtocart"){
                if mainmenuidarray[indexPath.row]==addedid as! String{
                    
                    let expansion = self.storyboard?.instantiateViewController (withIdentifier: "ExpandcollapseViewController") as!  ExpandcollapseViewController
                    expansion.id=mainmenuidarray[indexPath.row]
                    expansion.list=submenuidarray[indexPath.row]
                    expansion.mainmenuname=mainmenunamearray[indexPath.row]
                    expansion.mainmenuprice=mainmenupricearray[indexPath.row]
                    expansion.additemflag=additemflag
                    
                    self.navigationController?.pushViewController(expansion, animated: true)
                    
                    
                }else{
                    
                    var refreshAlert = UIAlertController(title: "Do you really wish to replace existing menu in cart", message: "", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                        self.mainidtodelete=addedid as! String
                        self.service_delete_party_insert()
                        let expansion = self.storyboard?.instantiateViewController (withIdentifier: "ExpandcollapseViewController") as!  ExpandcollapseViewController
                        expansion.id=self.mainmenuidarray[indexPath.row]
                        expansion.list=self.submenuidarray[indexPath.row]
                        expansion.mainmenuname=self.mainmenunamearray[indexPath.row]
                        expansion.mainmenuprice=self.mainmenupricearray[indexPath.row]
                        expansion.additemflag=self.additemflag
                        //            UserDefaults.standard.removeObject(forKey: "idforpartyorder")
                        //            UserDefaults.standard.removeObject(forKey: "listforpartyorder")
                        
                        UserDefaults.standard.removeObject(forKey: "partyorderselectedarray")
                        UserDefaults.standard.removeObject(forKey: "addedidtocart")
                        UserDefaults.standard.removeObject(forKey: "idforpartyorder")
                              UserDefaults.standard.removeObject(forKey: "listforpartyorder")
                              UserDefaults.standard.removeObject(forKey: "mainmenunamepartyorder")
                        
                        self.navigationController?.pushViewController(expansion, animated: true)
                    }))
                    
                    refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
            }else{
                
                let expansion = self.storyboard?.instantiateViewController (withIdentifier: "ExpandcollapseViewController") as!  ExpandcollapseViewController
                expansion.id=mainmenuidarray[indexPath.row]
                expansion.list=submenuidarray[indexPath.row]
                expansion.mainmenuname=mainmenunamearray[indexPath.row]
                expansion.mainmenuprice=mainmenupricearray[indexPath.row]
                expansion.additemflag=additemflag
                //            UserDefaults.standard.removeObject(forKey: "idforpartyorder")
                //            UserDefaults.standard.removeObject(forKey: "listforpartyorder")
                //         UserDefaults.standard.removeObject(forKey: "mainmenunamepartyorder")
                
                
                self.navigationController?.pushViewController(expansion, animated: true)
                
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        
        //        let expansion = self.storyboard?.instantiateViewController (withIdentifier: "TestpartyorderViewController") as!  TestpartyorderViewController
        //                expansion.id=mainmenuidarray[indexPath.row]
        //                expansion.list=submenuidarray[indexPath.row]
        // expansion.mainmenuname=mainmenunamearray[indexPath.row]
        // expansion.mainmenuprice=mainmenupricearray[indexPath.row]
        
        
        //               self.navigationController?.pushViewController(expansion, animated: true)
        //        }else{
        //
        //            let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
        //            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
        //
        //                let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
        //                launch.searchroomflag=3
        //                self.navigationController?.pushViewController(launch, animated: true)
        //
        //            }))
        //
        //            self.present(alert, animated: true)
        //
        //
        //
        //        }
        
        
    }
    
    
    
    
    func service_delete_party_insert(){
        
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/delete_party_insert")else{return}
        
        let poststring="mcategory_id=\(mainidtodelete)&menu_token=\(menutoken)"
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
                            //                               self.service_party_checkout()
                            //                               self.tableviewyourcart.reloadData()
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
    
    
    
    func service_party_products(){
        self.showhud()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/party_products")else{return}
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
                    let products=parseJson["products"]as! NSDictionary
                    
                    let totalproducts=products["products"] as! NSArray
                    for value in totalproducts{
                        let item:[String:Any]=value as! [String:Any]
                        let grp_main_menu_id=item["grp_main_menu_id"] as! String
                        let grp_sub_category_id=item["grp_sub_category_id"] as! String
                        let grp_main_menu_name=item["grp_main_menu_name"] as! String
                        let grp_main_menu_price=item["grp_main_menu_price"] as! String
                        let grp_main_menu_description=item["grp_main_menu_description"] as! String
                        self.mainmenuidarray.append(grp_main_menu_id)
                        self.submenuidarray.append(grp_sub_category_id)
                        self.mainmenunamearray.append(grp_main_menu_name)
                        self.mainmenupricearray.append(grp_main_menu_price)
                        self.menudescriptionarray.append(grp_main_menu_description)
                        //dict2.append(item as! [String : String])
                        
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tableviewpartyorder.reloadData()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.showToast(message: "Something went wrong", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                    }
                }
            }
                
            catch {
                print(error)
            }
            
        }.resume()
        
        
    }
    
    @IBAction func btnviewcartaction(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "orderlistarray")
        
        if userid.isEmpty==true||userid==""||userid==nil{
            showToast(message: "Please login to continue", font: UIFont.boldSystemFont(ofSize: 14),duration: 2)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let sw = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            
            self.view.window?.rootViewController = sw
            
            let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
            
            
            let navigationController = UINavigationController(rootViewController: destinationController)
            
            
            
            sw.pushFrontViewController(navigationController, animated: true)
            
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
