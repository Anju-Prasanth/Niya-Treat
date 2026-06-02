//
//  ExpandcollapseViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 14/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper
import Alamofire
import MBProgressHUD


@available(iOS 13.0, *)
class ExpandcollapseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var btnaddtocart: UIButton!
    @IBOutlet weak var viewpappad: UIView!
    @IBOutlet weak var tableviewexpandcollapse: UITableView!
    
    var productsexpandable:[totalproductsexpandable]=[]
    var id=String()
    var list=String()
    var mainmenuprice=String()
    var mainmenuname=String()
    var menutoken=String()
    var partyinsertarray=[[String:String]]()
    var dict_partyproducts=[String:Any]()
    var dict_partymain=[String:Any]()
    var partyorderarray=[[String:String]]()
    var itemsubidarray=[String]()
    var dictpassedpartyorder=[[String:String]]()
    var mainid=String()
    var subid=String()
    var subitemname=String()
    var countvalue=Int()
    var mainmenuitemarray=[[String:String]]()
    var cartprice=Int()
    var numberofpeoplepartyorder=Int()
    var subidarrayback=[[String:String]]()
    var tempvalue=0
    var cell=ExpandedarrayTableViewCell()
    
    var sectionStats = [Bool]()
    var selectedIndex=100
    var headerView=UIView()
    var selectedindexpath=IndexPath()
    var selectedindex=IndexPath()
    var hud:MBProgressHUD!
    var nonvegitemarray=[[String:String]]()
    var nonvegcountvalue=Int()
    var subcategoryname=String()
    var selectionflag=String()
    var prefix=Int()
    var selectedmenu=String()
    var index=Int()
    var buttonchnageforselecedindex=100
    var productArray=[[String:Any]]()
    var subArray=[[String:Any]]()
    var flagarray=[Int]()
    var selectedButtons=[Bool]()
    var totalcount=Int()
    var mycount=Int()
    var selectedproductArray=[[String:Any]]()
    var selectedAddress = String()
    var selectedsection=Int()
    var selectedrow=Int()
    var partorder_items=[String:[String:Any]]()
    var additemflag=Int()
    var partyorderselectedarray=[String:Any]()
    var subArraysubproducts=[[String:Any]]()
    var cartflag=Int()
    var mainidtodelete=String()
    var headerCell=HeaderexpandedTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
        viewpappad.layer.cornerRadius=10
        
        viewpappad.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewpappad.layer.shadowRadius = 5.0
        viewpappad.layer.shadowOpacity = 0.1
        self.tableviewexpandcollapse.tableHeaderView=headerView
         if #available(iOS 13.0, *){
                self.isModalInPresentation = true
               }
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let partyorderid=UserDefaults.standard.value(forKey: "idforpartyorder"){
            id=partyorderid as! String
        }

        if let listpartyorder=UserDefaults.standard.value(forKey: "listforpartyorder"){
            list=listpartyorder as! String
        }
        if let mainmenu=UserDefaults.standard.value(forKey: "mainmenunamepartyorder"){
                   mainmenuname=mainmenu as! String
        }
        
        if let addedid=UserDefaults.standard.value(forKey: "addedidtocart"){
            if id==addedid as! String{
                btnaddtocart.setTitle("Update", for: .normal)
                
            }else{
                btnaddtocart.setTitle("Add to Cart", for: .normal)
            }
                  
               }
        
       service_party_products_all()
        
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
        title = mainmenuname
        
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 20.0)
        lbl.textColor =  UIColor.darkGray
        lbl.textAlignment = .left
        navigationItem.titleView=lbl
        
        
        if let menu_token=UserDefaults.standard.value(forKey: "menutoken"){
            if (menu_token as AnyObject).isEmpty==true{
                
            }else{
                menutoken=UserDefaults.standard.value(forKey: "menutoken") as! String
            }
        }
        
        
        
        
        //        if let partorderitems=UserDefaults.standard.value(forKey: "selecteditemsinpartyorder"){
        //            partorder_items=UserDefaults.standard.value(forKey: "selecteditemsinpartyorder") as! [String : [String : Any]]
        //            if partorder_items[id] != nil{
        //            for (key,value) in partorder_items{
        //                if key==id{
        //                    subidarrayback=value["partyselectedarray"] as! [[String : String]]
        //                    productArray=value["productArray"] as! [[String : Any]]
        //                    partyinsertarray=value["partyinsertedarray"] as! [[String : String]]
        //                    self.sectionStats = [Bool](repeating: false, count: self.productArray.count)
        //                    var item=[String:String]()
        //
        //                    for value in partyinsertarray{
        //                     let index=partyinsertarray.index(of:value)
        //                       item=value
        //                        partyinsertarray.remove(at: index!)
        ////                        if additemflag==1{
        ////                         item.updateValue("", forKey: "menu_token")
        ////                        }else{
        //                             item.updateValue(menutoken, forKey: "menu_token")
        ////                        }
        //
        //
        //
        //                        partyinsertarray.insert(item, at: index!)
        //
        //                    }
        //
        ////                        item.removeValue(forKey: "menu_token")
        ////                        item.add("menu_token",menutoken)
        //
        //
        //                }else{
        //                   // fetchProductApi()
        //                }
        //            }
        //            }else{
        //               service_party_products_all()
        //            }
        //
        //        }else{
        //             service_party_products_all()
        //        }
       
        if let partyorderseleced=UserDefaults.standard.value(forKey: "partyorderselectedarray"){
            partyorderselectedarray=UserDefaults.standard.value(forKey: "partyorderselectedarray") as! [String : Any]
            
            
        }
        print("partyorderselectedarray",partyorderselectedarray)
        
        if let menu_token=UserDefaults.standard.value(forKey: "menutoken"){
            if (menu_token as AnyObject).isEmpty==true{
                
            }else{
                menutoken=UserDefaults.standard.value(forKey: "menutoken") as! String
            }
        }
        
        if let partyordernumberofpeople=UserDefaults.standard.value(forKey: "partyorderpeoplenumbers"){
            if (partyordernumberofpeople as AnyObject).isEmpty==true{
                
            }else{
                numberofpeoplepartyorder=(UserDefaults.standard.value(forKey: "partyorderpeoplenumbers") as! NSString).integerValue
            }
        }
        
        
        if let array=UserDefaults.standard.array(forKey: "partyorderarray"){
            if array.isEmpty==true{
                
            }else{
                
                partyorderarray=UserDefaults.standard.array(forKey: "partyorderarray") as! [[String : String]]
                
                
            }
        }
        print("partyorderarray",partyorderarray)
        if let itemsubid=UserDefaults.standard.array(forKey: "itemsubids"){
            if itemsubid.isEmpty==true{
                
            }else{
                itemsubidarray=UserDefaults.standard.array(forKey: "itemsubids") as! [String]
                
                
            }
        }
        
        if let menuitemarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart"){
            if menuitemarray.isEmpty==true{
                
            }else{
                mainmenuitemarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String:String]]
                
                
            }
            
        }
        
        if let array=UserDefaults.standard.value(forKey: "partyinsertarray"){
            if (array as AnyObject).isEmpty==true{
                
            }else{
                partyinsertarray=UserDefaults.standard.value(forKey: "partyinsertarray") as! [[String : String]]
            }
        }
        if let subidarray=UserDefaults.standard.value(forKey: "subidarrayback"){
            if (subidarray as AnyObject).isEmpty==true{
                
            }else{
                subidarrayback=UserDefaults.standard.value(forKey: "subidarrayback") as! [[String : String]]
                
            }
        }
        
        print("subidarrayback",subidarrayback)
        
    }
    
    
    
    
    func backButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        //        button.setImage(UIImage(named: imageName), for: .normal)
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width:30, height: 30)
        button.backgroundColor = UIColor.clear
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        
                
               
            partyorderselectedarray.updateValue(productArray, forKey: id)
            UserDefaults.standard.set(partyorderselectedarray,forKey: "partyorderselectedarray")
            
       
            
        
        
        
//        if cartflag==1{
//         let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
//            yourcart.idfromexpand=id
//            yourcart.listfromexpand=list
//            yourcart.mainmenunamefromexpand=mainmenuname
//
//        self.navigationController?.pushViewController(yourcart, animated: true)
//        }else{
            let partyorder = self.storyboard?.instantiateViewController (withIdentifier: "PartyorderproductsViewController") as! PartyorderproductsViewController
                  
                   self.navigationController?.pushViewController(partyorder, animated: true)
//        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        let item=productArray[section]
        return !sectionStats[section] ? 0 :(item["sub"] as! [[String:Any]]).count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell = (tableView.dequeueReusableCell(withIdentifier: "ExpandedarrayTableViewCell", for: indexPath) as? ExpandedarrayTableViewCell)!
        
        let subproduct=productArray[indexPath.section]
        let value=subproduct["sub"] as! [[String:Any]]
        let fooditemname=value[indexPath.row]
        cell.lblsubproducts.text=fooditemname["grp_food_item_name"] as! String
        let isselected=fooditemname["isselected"] as! Int
        
        if isselected==0{
           
            cell.imageview.image=UIImage(named:"icons8-oval-30-2")
        } else {
             cell.imageview.image=UIImage(named:"icons8-oval-30-3")
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 48
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 77
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//       headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderexpandedTableViewCell") as! HeaderexpandedTableViewCell
//        let item=productArray[section]
//              let value=item["sub"] as! [[String:Any]]
//                           headerCell.lblitemnamr.text=item["grp_sub_category_name"] as! String
//                           headerCell.lblcountitems.text="You can choose "+String(item["count_value"] as! String)+" items"
//                           headerCell.btnheadertapped.tag=section
//        headerCell.lbldash.isHidden=true
//
//                           headerCell.btnheadertapped.addTarget(self, action: #selector(sectionHeaderTapped(sender:)), for: .touchUpInside)
//
//
//                           return headerCell
        
        
        
        
        
        
        let item=productArray[section]
        let value=item["sub"] as! [[String:Any]]

       
        return headerView(section: section, title:item["grp_sub_category_name"] as! String, count: "You can choose "+String(item["count_value"] as! String)+" items")
        
    }
    
    private func headerView(section: Int, title: String, count: String) -> UIView {

   let item=productArray[section]
      

       // let frame=tableviewexpandcollapse.frame
        headerView = UIView(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width-20, height: 70))

        headerView.layer.cornerRadius=10

//        headerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        headerView.layer.shadowRadius = 5.0
//        headerView.layer.shadowOpacity = 0.1
//        headerView.backgroundColor=UIColor(red: 249 / 255, green: 208 / 255, blue: 164 / 255, alpha: 1.0)


        let buttonlabel = UIButton(frame: CGRect(x: 10, y: 30, width: UIScreen.main.bounds.width-20, height: 50))
        buttonlabel.tag = section
        buttonlabel.setTitle("   "+count, for: .normal)
//        buttonlabel.backgroundColor=UIColor(red: 249 / 255, green: 208 / 255, blue: 164 / 255, alpha: 1.0)

        buttonlabel.contentHorizontalAlignment = .left
        buttonlabel.setTitleColor(UIColor.darkGray, for: .normal)
        buttonlabel.addTarget(self, action: #selector(sectionHeaderTapped), for: .touchUpInside)


      let buttoncardview = UIButton(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width-20, height: 77))


        buttoncardview.layer.cornerRadius=10

//        buttoncardview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        buttoncardview.layer.shadowRadius = 3
//        buttoncardview.layer.shadowOpacity = 1
        //buttoncardview.backgroundColor=UIColor.black


       buttoncardview.addTarget(self, action: #selector(sectionHeaderTapped), for: .touchUpInside)
      buttoncardview.backgroundColor=UIColor(red: 249 / 255, green: 208 / 255, blue: 164 / 255, alpha: 1.0)

        let button = UIButton(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width-20, height: 60))
        button.tag = section
        button.setTitle("   "+title, for: .normal)
        button.layer.cornerRadius=10

       
        if item["count"] as! Int==(item["count_value"] as! NSString).integerValue{
                   button.setTitleColor(UIColor.red, for: .normal)
               }else{
                    button.setTitleColor(UIColor.black, for: .normal)
               }
        
       // button.backgroundColor=UIColor(red: 249 / 255, green: 208 / 255, blue: 164 / 255, alpha: 1.0)
        button.contentHorizontalAlignment = .left
       
        button.addTarget(self, action: #selector(sectionHeaderTapped), for: .touchUpInside)

        let button1 = UIButton(frame: CGRect(x: UIScreen.main.bounds.width-50, y: 30, width: 20, height: 20))
       

        button1.contentHorizontalAlignment = .right
       
        button1.addTarget(self, action: #selector(sectionHeaderTapped), for: .touchUpInside)
        button1.tag=section

//
        if sectionStats[section]==true{
//            button2.isHidden=false
//            headerView.backgroundColor=UIColor.white
             button1.setImage(UIImage(named: "icons8-chevron-down-30"), for: .normal)
            
            
        }else{
//             button2.isHidden=true
//             headerView.backgroundColor=UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1.0)
             button1.setImage(UIImage(named: "icons8-chevron-right-30"), for: .normal)
        }
       
       
//         headerView.addSubview(buttoncardview)
         headerView.addSubview(buttoncardview)
        buttoncardview.addSubview(button)
        buttoncardview.addSubview(buttonlabel)
        buttoncardview.addSubview(button1)
       
        
        return headerView
    }
    
    @objc private func sectionHeaderTapped(sender: UIButton) {
        
       
        var mainidsectionheader=String()
        let section = sender.tag
        print("section",section)
        sectionStats[section] = !sectionStats[section]
        
       // tableviewexpandcollapse.beginUpdates()
        tableviewexpandcollapse.reloadSections([section], with: .none)
       
        let indexPath = IndexPath(row: NSNotFound, section: section)
            tableviewexpandcollapse.scrollToRow(at: indexPath, at: .none, animated: false)
      
       // tableviewexpandcollapse.endUpdates()
        
        let mainid=productArray[section]["grp_sub_category_id"]
        mainidsectionheader = productArray[section]["grp_sub_category_id"] as! String
        print("mainid",mainid)
    }
    
    
    
    
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
    //        print("subidarrayback",subidarrayback)
    //        let subproduct=productArray[indexPath.section]
    //        let value=subproduct["sub"] as! [[String:Any]]
    //        var fooditemname=value[indexPath.row]
    //        subid=fooditemname["grp_food_item_id"] as! String
    //        mainid=subproduct["grp_sub_category_id"] as! String
    //
    //        var item = self.productArray[indexPath.section]
    //        self.subArray=item["sub"] as! [[String:Any]]
    //        // self.productArray[index] = item
    //
    //        var selected=self.subArray[indexPath.row]
    //        selected["isselected"] = 0
    //        self.subArray[indexPath.row]=selected
    //
    //        productArray[indexPath.section]["sub"]=subArray
    //
    //
    //        print("productArray",productArray)
    //
    //
    //        for value in subidarrayback{
    //            let indexpartinsertarray=subidarrayback.index(of:value)
    //            var items:[String:String]=value as! [String:String]
    //
    //            if items["mainidsub"]==mainid{
    //                tempvalue=(items["choosenitemnumber"] as! NSString).integerValue
    //                subidarrayback.remove(at: indexpartinsertarray!)
    //            }
    //
    //            if tempvalue==0{
    //
    //            }else{
    //                tempvalue=tempvalue-1
    //                var item=[String:String]()
    //
    //                item.updateValue(mainid, forKey: "mainidsub")
    //                item.updateValue(String(tempvalue), forKey: "choosenitemnumber")
    //                subidarrayback.append(item)
    //            }
    //
    //
    //        }
    //
    //
    //        for value in partyorderarray{
    //            let indexpartinsertarray=partyorderarray.index(of:value)
    //            var items:[String:String]=value as! [String:String]
    //
    //            if items["mainmenuid"]==id{
    //                if items["subids"]==subid{
    //
    //                    partyorderarray.remove(at: indexpartinsertarray!)
    //                }
    //            }
    //        }
    //
    //        UserDefaults.standard.set(partyorderarray, forKey: "partyorderarray")
    //        partyorderarray=UserDefaults.standard.array(forKey: "partyorderarray") as! [[String : String]]
    //        for value in partyinsertarray{
    //            let indexpartinsertarray=partyinsertarray.index(of:value)
    //            var items:[String:String]=value as! [String:String]
    //
    //            if items["sfood_id"]==subid{
    //
    //
    //                partyinsertarray.remove(at: indexpartinsertarray!)
    //            }
    //        }
    //        //        if nonvegitemarray.isEmpty==true{
    //        //
    //        //        }else{
    //        //
    //        //         for value in nonvegitemarray{
    //        //            let indexnonvegitemarray=nonvegitemarray.index(of:value)
    //        //            var items:[String:String]=value as! [String:String]
    //        //             if items["nonvegmainmenuname"]==mainmenuname{
    //        //                if items["nonvegitemchoosennumber"]=="1"{
    //        //                    nonvegitemarray.remove(at: indexnonvegitemarray!)
    //        //                }else{
    //        //                    nonvegcountvalue=(items["nonvegitemchoosennumber"] as! NSString).integerValue
    //        //                    nonvegcountvalue=nonvegcountvalue-1
    //        //                    nonvegitemarray.remove(at: indexnonvegitemarray!)
    //        //                    items.updateValue(String(nonvegcountvalue), forKey: "nonvegitemchoosennumber")
    //        //                    items.updateValue(mainmenuname, forKey: "nonvegmainmenuname")
    //        //                    nonvegitemarray.append(items)
    //        //                }
    //        //
    //        //        }
    //        //            }
    //        //            UserDefaults.standard.set(nonvegitemarray, forKey: "nonvegitemarray")
    //        //
    //        //                nonvegitemarray=UserDefaults.standard.array(forKey: "nonvegitemarray") as! [[String : String]]
    //        //        }
    //
    //        UserDefaults.standard.set(partyinsertarray, forKey: "partyinsertarray")
    //
    //        partyinsertarray=UserDefaults.standard.array(forKey: "partyinsertarray") as! [[String : String]]
    //
    //        print("nonvegitemarray",nonvegitemarray)
    //        print("partyinsertarray",partyinsertarray)
    //        print("partyorderarray",partyorderarray)
    //
    //        print("subidarrayback",subidarrayback)
    //        tableviewexpandcollapse.reloadData()
    //    }
    //
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       
        var item = [String:Any]()
        let row=indexPath.row
        let section=indexPath.section
        var selected=[String:Any]()
        
        item = self.productArray[section]
        let count_value=(item["count_value"]  as! NSString).integerValue
        self.subArraysubproducts=item["sub"] as! [[String:Any]]
        selected=self.subArraysubproducts[row]
        
      
        if (item["count"] as! Int) < count_value{
            
            selected=self.subArraysubproducts[row]
            if selected["isselected"] as! Int==0{
                
                selected["isselected"] = 1
                item["count"]=(item["count"] as! Int)+1
            }else{
                
                selected["isselected"] = 0
                item["count"]=(item["count"] as! Int)-1
            }
            
            
            print("productArray",productArray)
        }else if (item["count"]as! Int) == count_value{
            if selected["isselected"] as! Int==1{
                
                selected["isselected"] = 0
                item["count"]=(item["count"] as! Int)-1
                
            }else{
                self.showToast(message: "Quantity exceeds available quantity", font: UIFont.boldSystemFont(ofSize: 12), duration: 2)
            }
            
            
        }else{
            selected["isselected"] = 0
            self.showToast(message: "Quantity exceeds available quantity", font: UIFont.boldSystemFont(ofSize: 12), duration: 2)
        }
       
        productArray[section]=item
        
        self.subArraysubproducts[row]=selected
        
        self.productArray[section]["sub"]=self.subArraysubproducts
        
        print("subArraysubproducts",subArraysubproducts)
        print("productArray",productArray)
        print("partyinsertarray",partyinsertarray)
        
        
        
        
        
        //        let subproduct=productArray[indexPath.section]
        //              let value=subproduct["sub"] as! [[String:Any]]
        //              var fooditemname=value[indexPath.row]
        //
        //
        //
        //        subid=fooditemname["grp_food_item_id"] as! String
        //        selectionflag=subproduct["selection_flag"] as! String
        //        print("subid",subid)
        //        subcategoryname=subproduct["grp_sub_category_name"] as! String
        //        subitemname=fooditemname["grp_food_item_name"] as! String
        //        mainid=subproduct["grp_sub_category_id"] as! String
        //        countvalue=(subproduct["count_value"]as! NSString).integerValue
        //
        //        selectedindexpath=indexPath
        //
        //        buttonchnageforselecedindex=indexPath.row
        //        selectedsection=indexPath.section
        //        selectedrow=indexPath.row
        //        print("subidarrayback",subidarrayback)
        //        for value in subidarrayback{
        //            let item:[String:String]=value as [String:String]
        //
        //            if item["mainidsub"]==mainid{
        //                tempvalue=(item["choosenitemnumber"] as! NSString).integerValue
        //
        //
        //
        //            }else{
        //                if partorder_items[id] != nil{
        //                        }else{
        //                tempvalue=0
        //                }
        //            }
        //        }
        //         print("subidarrayback",subidarrayback)
        //         print("tempvalue",tempvalue)
        //
        //        if tempvalue<(subproduct["count_value"] as! NSString).integerValue{
        //
        //            isselected(index: indexPath.row, section: indexPath.section)
        //
        //
        //        }else{
        //            if fooditemname["isselected"] as!Int==1{
        //                isselected(index: indexPath.row, section: indexPath.section)
        //            }else{
        //                self.showToast(message: "Quantity exceeds available quantity", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
        //            }
        //
        //        }
        //
        //
        //        print("productArray",productArray)
        //
        
        tableviewexpandcollapse.reloadData()
        
        
        
    }
    
    
    
    func newcalculation(indexnewcalc:Int,sectionnewcalc:Int){
        if partyorderarray.isEmpty==true{
            print("partyorderarray",partyorderarray)
            var items=[String:String]()
            items.updateValue(id, forKey: "mainmenuid")
            items.updateValue(mainmenuprice, forKey: "actualprice")
            // items.updateValue(String(price_value), forKey: "totalprice")
            items.updateValue(subitemname, forKey: "subitemname")
            items.updateValue(mainmenuname, forKey: "mainitemname")
            items.updateValue(subid, forKey: "subids")
            items.updateValue(mainid, forKey: "mainid")
            //items.updateValue(String(itemnamearray.count), forKey: "choosenitemnumber")
            itemsubidarray.append(subid)
            // items.updateValue(String(itemsubidarray.count), forKey: "choosenitemnumber")
            UserDefaults.standard.set(itemsubidarray, forKey: "itemsubids")
            dictpassedpartyorder.append(items)
            UserDefaults.standard.set(dictpassedpartyorder, forKey: "partyorderarray")
            
            var item=[String:String]()
            
            item.updateValue(id, forKey: "mcategory_id")
            item.updateValue(mainid, forKey: "scategory_id")
            item.updateValue(subid, forKey: "sfood_id")
            item.updateValue(menutoken,forKey:"menu_token")
            partyinsertarray.append(item as! [String : String])
            UserDefaults.standard.set(partyinsertarray, forKey: "partyinsertarray")
            
            
            var itemback=[String:Any]()
            
            tempvalue=tempvalue+1
            itemback.updateValue(mainid, forKey: "mainidsub")
            itemback.updateValue(String(tempvalue), forKey: "choosenitemnumber")
            
            subidarrayback.append(itemback as! [String : String])
            
            
        } else{
            
            
            print("subidarrayback",subidarrayback)
            var mainidback=String()
            var mainidrrayback=String()
            var subidinarrayback=String()
            for value in subidarrayback{
                let item:[String:String]=value as [String:String]
                
                if item["mainidsub"]==mainid{
                    tempvalue=(item["choosenitemnumber"] as! NSString).integerValue
                    mainidback=item["mainidsub"]!
                    
                    
                }
            }
            
            print("tempvalue",tempvalue)
            print("mainidback",mainidback)
            print("mainid",mainid)
            print("subidarrayback",subidarrayback)
            
            if mainidback==mainid{
                
                if tempvalue<countvalue{
                    tempvalue=tempvalue+1
                    
                    
                    var items=[String:String]()
                    items.updateValue(id, forKey: "mainmenuid")
                    items.updateValue(mainmenuprice, forKey: "actualprice")
                    // items.updateValue(String(price_value), forKey: "totalprice")
                    items.updateValue(subitemname, forKey: "subitemname")
                    items.updateValue(mainmenuname, forKey: "mainitemname")
                    items.updateValue(subid, forKey: "subids")
                    items.updateValue(mainid, forKey: "mainid")
                    //items.updateValue(String(itemnamearray.count), forKey: "choosenitemnumber")
                    itemsubidarray.append(subid)
                    // items.updateValue(String(itemsubidarray.count), forKey: "choosenitemnumber")
                    UserDefaults.standard.set(itemsubidarray, forKey: "itemsubids")
                    partyorderarray.append(items)
                    UserDefaults.standard.set(partyorderarray, forKey: "partyorderarray")
                    
                    var item=[String:String]()
                    
                    item.updateValue(id, forKey: "mcategory_id")
                    item.updateValue(mainid, forKey: "scategory_id")
                    item.updateValue(subid, forKey: "sfood_id")
                    item.updateValue(menutoken,forKey:"menu_token")
                    partyinsertarray.append(item as! [String : String])
                    UserDefaults.standard.set(partyinsertarray, forKey: "partyinsertarray")
                    
                    
                    
                    
                    //                        if selectionflag=="1"{
                    //
                    //
                    //
                    //
                    //                            if nonvegitemarray.isEmpty==true{
                    //                                var nonvegcountvalue=0
                    //                               nonvegcountvalue=nonvegcountvalue+1
                    //                               var nonvegitem=[String:String]()
                    //                               nonvegitem.updateValue(String(nonvegcountvalue), forKey: "nonvegitemchoosennumber")
                    //                               nonvegitem.updateValue(mainmenuname, forKey: "nonvegmainmenuname")
                    //                               nonvegitemarray.append(nonvegitem)
                    //                            selectedmenu=mainmenuname
                    //                            let  value=Int(selectedmenu.prefix(1))
                    //                            prefix=value!
                    //                               print("nonvegitemarray",nonvegitemarray)
                    //
                    //                            }else{
                    //
                    //
                    //                            if nonvegcountvalue<prefix{
                    //                            nonvegcountvalue=nonvegcountvalue+1
                    //                                                                      nonvegitemarray.remove(at: index)
                    //                                                                      var nonvegitem=[String:String]()
                    //                                                                      nonvegitem.updateValue(String(nonvegcountvalue), forKey: "nonvegitemchoosennumber")
                    //                                                                      nonvegitem.updateValue(mainmenuname, forKey: "nonvegmainmenuname")
                    //                                                                      nonvegitemarray.append(nonvegitem)
                    //                                                                      tempvalue=tempvalue+1
                    //
                    //                                                                for value in subidarrayback{
                    //                                                            let indexpartsubidarray=subidarrayback.index(of:value)
                    //                                                            var itemback:[String:String]=value as! [String:String]
                    //                                                                                  //                                           if itemback["mainmenuidback"]==id{
                    //                                                                                                                              if itemback["mainidsub"]==mainid{
                    //                                                                                                                              subidarrayback.remove(at: indexpartsubidarray!)
                    //                                                                                                                              itemback.updateValue(String(tempvalue), forKey: "choosenitemnumber")
                    //                                                                                                                             // itemback.updateValue(id, forKey: "mainmenuidback")
                    //                                                                                                                              itemback.updateValue(mainid, forKey: "mainidsub")
                    //                                                                                                                              //itemback.updateValue(subid, forKey: "subid")
                    //                                                                                                                              subidarrayback.append(itemback)
                    //
                    //                                                                                  //                        }
                    //                                                                                          //
                    //                                                                                                          }
                    //                                                                                                          }
                    //
                    //                                                                  }else{
                    //
                    //                                                                      tableviewexpandcollapse.deselectRow(at: selectedindexpath, animated: false)
                    //                                                                      showToast(message: "Select only " + "\(prefix)" + " item from fish/chicken", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                    //                                                                  }
                    //                            }
                    //                        }else{
                    
                    
                    //  tempvalue=tempvalue+1
                    
                    for value in subidarrayback{
                        let indexpartsubidarray=subidarrayback.index(of:value)
                        var itemback:[String:String]=value as! [String:String]
                        //                                         if itemback["mainmenuidback"]==id{
                        if itemback["mainidsub"]==mainid{
                            subidarrayback.remove(at: indexpartsubidarray!)
                            itemback.updateValue(String(tempvalue), forKey: "choosenitemnumber")
                            // itemback.updateValue(id, forKey: "mainmenuidback")
                            itemback.updateValue(mainid, forKey: "mainidsub")
                            //itemback.updateValue(subid, forKey: "subid")
                            subidarrayback.append(itemback)
                            
                            //                        }
                            //
                        }
                    }
                    
                    //  }
                    
                    
                } else {
                    
                    tableviewexpandcollapse.deselectRow(at: selectedindexpath, animated: false)
                    
                    self.showToast(message: "Quantity exceeds available quantity", font: UIFont.boldSystemFont(ofSize: 12), duration: 2)
                    
                }
                
            } else{
                
                tempvalue=0
                tempvalue=tempvalue+1
                var items=[String:String]()
                items.updateValue(id, forKey: "mainmenuid")
                items.updateValue(mainmenuprice, forKey: "actualprice")
                // items.updateValue(String(price_value), forKey: "totalprice")
                items.updateValue(subitemname, forKey: "subitemname")
                items.updateValue(mainmenuname, forKey: "mainitemname")
                items.updateValue(subid, forKey: "subids")
                
                itemsubidarray.append(subid)
                
                UserDefaults.standard.set(itemsubidarray, forKey: "itemsubids")
                partyorderarray.append(items)
                UserDefaults.standard.set(partyorderarray, forKey: "partyorderarray")
                
                
                var item=[String:String]()
                
                item.updateValue(id, forKey: "mcategory_id")
                item.updateValue(mainid, forKey: "scategory_id")
                item.updateValue(subid, forKey: "sfood_id")
                item.updateValue(menutoken,forKey:"menu_token")
                partyinsertarray.append(item as! [String : String])
                UserDefaults.standard.set(partyinsertarray, forKey: "partyinsertarray")
                
                
                
                
                
                
                var itemback=[String:String]()
                
                itemback.updateValue(String(tempvalue), forKey: "choosenitemnumber")
                
                itemback.updateValue(mainid, forKey: "mainidsub")
                
                subidarrayback.append(itemback)
                
                
            }
        }
        
        partyinsertarray=UserDefaults.standard.array(forKey:  "partyinsertarray") as! [[String : String]]
        partyorderarray=UserDefaults.standard.array(forKey: "partyorderarray") as! [[String : String]]
        itemsubidarray=UserDefaults.standard.array(forKey: "itemsubids") as! [String]
        print("partyorderarray",partyorderarray)
        print("itemnamearray",itemsubidarray)
        print("partyinsertarray",partyinsertarray)
        print("subidarrayback",subidarrayback)
        dict_partyproducts.updateValue(partyinsertarray, forKey: "menu_list")
        
        dict_partymain.updateValue(dict_partyproducts, forKey: "data")
        UserDefaults.standard.set(partyinsertarray, forKey: "partyinsertarray")
        UserDefaults.standard.set(dict_partyproducts, forKey: "partyinsertmenulistdictionary")
        UserDefaults.standard.set(dict_partymain, forKey: "maindictionarypartyinsert")
        
        
        
        
        
        
    }
    
    
    @IBAction func btnaddtocartaction(_ sender: Any) {
        
        
        self.partyinsertarray.removeAll()
        var items=[String:String]()
        for index in 0...self.productArray.count - 1 {
            var item = self.productArray[index]
            self.subArray=item["sub"] as! [[String:Any]]
            if subArray.count>0{
            for i in 0...self.subArray.count-1{
                var selected=self.subArray[i]
                if  selected["isselected"] as! Int == 1{
                    items.updateValue(id, forKey: "mcategory_id")
                    items.updateValue(item["grp_sub_category_id"] as! String, forKey: "scategory_id")
                    items.updateValue(selected["grp_food_item_id"] as! String, forKey: "sfood_id")
                     items.updateValue(menutoken, forKey: "menu_token")
                    partyinsertarray.append(items)
                }else{
                    
                }
               
            }
        }
        }
        print("partyinsertarray",partyinsertarray)
        
        var totalcount=0
        var mycount=0
        for i in 0...productArray.count-1{
            totalcount+=(productArray[i]["count_value"] as! NSString).integerValue
            mycount+=productArray[i]["count"] as! Int
        }
//        print("totalcount",totalcount)
//        for i in 0...subidarrayback.count-1{
//            mycount+=(subidarrayback[i]["choosenitemnumber"]as! NSString).integerValue
//        }
        print("mycount",mycount)
        
        dict_partyproducts.updateValue(partyinsertarray, forKey: "menu_list")
        
        dict_partymain.updateValue(dict_partyproducts, forKey: "data")
        print("dict_partymain",dict_partymain)
        print("partyinsertarray",partyinsertarray)
        if partyinsertarray.isEmpty==true{
            DispatchQueue.main.async {
                self.showToast(message: "Your cart is empty", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
            }
            
        }
        else if mycount<totalcount{
            self.showToast(message: "Please select specified quantity item from all categories", font: UIFont.boldSystemFont(ofSize: 12), duration: 2)

        }else{
            
       // if partyorderselectedarray.isEmpty==true{
//
//
//            let totalpriceforanitem = (mainmenuprice as! NSString).integerValue*numberofpeoplepartyorder
//                       var item=[String:Any]()
//                       item.updateValue(mainmenuname, forKey: "mainmenuitem")
//                       item.updateValue(id, forKey: "id")
//                       item.updateValue(String(totalpriceforanitem), forKey: "mainmenuitemprice")
//                       item.updateValue(String(1), forKey: "quantity")
//                       item.updateValue(mainmenuprice,forKey:"actualprice")
//                       //item.updateValue(String(itemsubidarray.count), forKey: "choosenitemnumber")
//                       mainmenuitemarray.append(item as! [String : String])
//                       UserDefaults.standard.set(mainmenuitemarray, forKey: "mainmenuitemarraycart")
//
//                       mainmenuitemarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String:String]]
//                       print(mainmenuitemarray)
//                       for values in mainmenuitemarray{
//                           let item:[String:String]=values as! [String:String]
//                           cartprice+=(item["mainmenuitemprice"] as! NSString).integerValue
//
//
//                       }
//
//                       UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
//                        service_party_insert()
//                          let partyorder = self.storyboard?.instantiateViewController (withIdentifier: "PartyorderproductsViewController") as! PartyorderproductsViewController
//
//                       partyorderselectedarray.updateValue(productArray, forKey: id)
//                              UserDefaults.standard.set(partyorderselectedarray,forKey: "partyorderselectedarray")
//
//                                   self.navigationController?.pushViewController(partyorder, animated: true)
//
//
//        }else if partyorderselectedarray[id] != nil {
//            let totalpriceforanitem = (mainmenuprice as! NSString).integerValue*numberofpeoplepartyorder
//                var item=[String:Any]()
//                item.updateValue(mainmenuname, forKey: "mainmenuitem")
//                item.updateValue(id, forKey: "id")
//                item.updateValue(String(totalpriceforanitem), forKey: "mainmenuitemprice")
//                item.updateValue(String(1), forKey: "quantity")
//                item.updateValue(mainmenuprice,forKey:"actualprice")
//                //item.updateValue(String(itemsubidarray.count), forKey: "choosenitemnumber")
//                mainmenuitemarray.append(item as! [String : String])
//                UserDefaults.standard.set(mainmenuitemarray, forKey: "mainmenuitemarraycart")
//
//                mainmenuitemarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String:String]]
//                print(mainmenuitemarray)
//                for values in mainmenuitemarray{
//                    let item:[String:String]=values as! [String:String]
//                    cartprice+=(item["mainmenuitemprice"] as! NSString).integerValue
//
//
//                }
//
//                UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
//                 service_party_insert()
//                   let partyorder = self.storyboard?.instantiateViewController (withIdentifier: "PartyorderproductsViewController") as! PartyorderproductsViewController
//            partyorderselectedarray.removeValue(forKey: id)
//                partyorderselectedarray.updateValue(productArray, forKey: id)
//                       UserDefaults.standard.set(partyorderselectedarray,forKey: "partyorderselectedarray")
//
//                            self.navigationController?.pushViewController(partyorder, animated: true)
//
//
//        }else{
//
//            var refreshAlert = UIAlertController(title: "Do you want to update the cart with new product", message: "", preferredStyle: UIAlertController.Style.alert)
//
//                               refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
//
//
//                                let totalpriceforanitem = (self.mainmenuprice as! NSString).integerValue*self.numberofpeoplepartyorder
//                                               var item=[String:Any]()
//                                item.updateValue(self.mainmenuname, forKey: "mainmenuitem")
//                                item.updateValue(self.id, forKey: "id")
//                                               item.updateValue(String(totalpriceforanitem), forKey: "mainmenuitemprice")
//                                               item.updateValue(String(1), forKey: "quantity")
//                                item.updateValue(self.mainmenuprice,forKey:"actualprice")
//                                               //item.updateValue(String(itemsubidarray.count), forKey: "choosenitemnumber")
//                                self.mainmenuitemarray.append(item as! [String : String])
//                                UserDefaults.standard.set(self.mainmenuitemarray, forKey: "mainmenuitemarraycart")
//
//                                self.mainmenuitemarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String:String]]
//                                print(self.mainmenuitemarray)
//                                for values in self.mainmenuitemarray{
//                                                   let item:[String:String]=values as! [String:String]
//                                    self.cartprice+=(item["mainmenuitemprice"] as! NSString).integerValue
//
//
//                                               }
//
//                                UserDefaults.standard.set(self.cartprice, forKey: "carttotalprice")
//                                for (key,value) in self.partyorderselectedarray{
//                                    self.mainidtodelete=key
//                                }
//
//                                self.service_delete_party_insert()
//                                self.service_party_insert()
//
//                                let partyorder = self.storyboard?.instantiateViewController (withIdentifier: "PartyorderproductsViewController") as! PartyorderproductsViewController
//                                self.partyorderselectedarray.removeValue(forKey: self.mainidtodelete)
//                                self.partyorderselectedarray.updateValue(self.productArray, forKey: self.id)
//                                UserDefaults.standard.set(self.partyorderselectedarray,forKey: "partyorderselectedarray")
//
//                                                           self.navigationController?.pushViewController(partyorder, animated: true)
//
//
//
//
//
//                               }))
//
//                               refreshAlert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
//                                   let partyproducts = self.storyboard?.instantiateViewController (withIdentifier: "PartyorderproductsViewController") as! PartyorderproductsViewController
//
//
//                                              self.navigationController?.pushViewController(partyproducts, animated: true)
//
//
//
//
//                               }))
//
//                               refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//
//                               // }))
//
//
//
//
//                               present(refreshAlert, animated: true, completion: nil)
//
          
            
            let totalpriceforanitem = (mainmenuprice as! NSString).integerValue*numberofpeoplepartyorder
            var item=[String:Any]()
            item.updateValue(mainmenuname, forKey: "mainmenuitem")
            item.updateValue(id, forKey: "id")
            item.updateValue(String(totalpriceforanitem), forKey: "mainmenuitemprice")
            item.updateValue(String(1), forKey: "quantity")
            item.updateValue(mainmenuprice,forKey:"actualprice")
            //item.updateValue(String(itemsubidarray.count), forKey: "choosenitemnumber")
            mainmenuitemarray.append(item as! [String : String])
            UserDefaults.standard.set(mainmenuitemarray, forKey: "mainmenuitemarraycart")

            mainmenuitemarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String:String]]
            print(mainmenuitemarray)
            for values in mainmenuitemarray{
                let item:[String:String]=values as! [String:String]
                cartprice+=(item["mainmenuitemprice"] as! NSString).integerValue


            }

            UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
            
            partyorderselectedarray.updateValue(productArray, forKey: id)
            UserDefaults.standard.set(partyorderselectedarray,forKey: "partyorderselectedarray")
            
            

     if let userid=UserDefaults.standard.value(forKey: "userid"){
     service_party_insert()
    
    }else{
        
          let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
        
                        let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
                        launch.searchroomflag=3
                        UserDefaults.standard.set(self.id, forKey: "idforpartyorder")
                        UserDefaults.standard.set(self.list, forKey: "listforpartyorder")
                        UserDefaults.standard.set(self.mainmenuname, forKey: "mainmenunamepartyorder")
                        self.navigationController?.pushViewController(launch, animated: true)
        
                    }))
        
                    self.present(alert, animated: true)
        
        
        
        
    }
    
         
        }
          print("partyorderselectedarray",partyorderselectedarray)
            
        
    }
    
   
    
//    func service_delete_party_insert(){
//
//           guard let url=NSURL(string :"https://niyaregency.com/api/Data/delete_party_insert")else{return}
//
//           let poststring="mcategory_id=\(mainidtodelete)&menu_token=\(menutoken)"
//           var request = NSMutableURLRequest(url: url as URL)
//           request.httpMethod = "POST"
//           request.httpBody = poststring.data(using: String.Encoding.utf8)
//           let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
//
//               if error != nil{
//                   print("error",error)
//                   return
//               }
//               print("poststring",poststring)
//               let responsestring=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//
//               print("respnsedate,\(responsestring)")
//
//               do{
//                   let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers)as? NSDictionary
//                   if let parseJson = jsonarray{
//                       let status=parseJson["status"]as! Bool
//                       if status==true{
//                           //                        self.partorder_items.removeValue(forKey: self.maincatidfordelete)
//                           //                        UserDefaults.standard.set(self.partorder_items, forKey: "selecteditemsinpartyorder")
//
//                           DispatchQueue.main.async {
////                               self.service_party_checkout()
////                               self.tableviewyourcart.reloadData()
//                           }
//
//
//                       }else{
//
//                       }
//                   }
//               }
//               catch {
//                   print(error)
//               }
//
//           }.resume()
//       }
       
       
       
       
    
    
    
    func service_party_products_all(){
        self.showhud()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/party_products_all")else{return}
        
        let poststring="security_token=niya32jfhdu392nfbfdr&list=\(list)&id=\(id)"
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
                        let totalproducts=products["products"] as! [[String:Any]]
                        self.productArray.removeAll()
                        self.productArray.append(contentsOf:totalproducts )
                        if self.productArray.count>0{
                        for index in 0...self.productArray.count - 1 {
                            var item = self.productArray[index]
                            self.subArray=item["sub"] as! [[String:Any]]
                            item["count"]=0
                            self.productArray[index] = item
                            if self.subArray.count>0{
                            for i in 0...self.subArray.count-1{
                                var selected=self.subArray[i]
                                selected["isselected"] = 0
                                self.subArray[i]=selected
                                
                                
                            }
                            }
                            
                            print("subArray",self.subArray)
                            
                            self.productArray[index]["sub"]=self.subArray
                            self.sectionStats = [Bool](repeating: false, count: self.productArray.count)
                        }
                    }
                        for (key,value) in self.partyorderselectedarray{
                            if key==self.id{
                                self.productArray=value as! [[String : Any]]
                            }
                        }
                        self.sectionStats = [Bool](repeating: false, count: self.productArray.count)
                        UserDefaults.standard.set(self.partyorderselectedarray,forKey: "partyorderselectedarray")
                        
                        print("productArray",self.productArray)
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.tableviewexpandcollapse.reloadData()
                        }
                        
                        
                    }else{
                         DispatchQueue.main.async {
                         self.hud.hide(animated: true)
                        }
                    }
                }
            }
            catch {
               DispatchQueue.main.async {
                 self.hud.hide(animated: true)
                }
            }
            
        }.resume()
    }
    
    
    
    func service_party_insert(){
        
        print("dict_partymain",dict_partymain)
        var param=String()
        
        
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: dict_partymain,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: .utf8) {
            print("JSON string = \(theJSONText)")
            param=theJSONText
            print("param",param)
            
        }
        showhud()
        
        guard let url=URL(string :"https://niyaregency.com/api/Data/party_insert")else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: dict_partymain, options: .prettyPrinted) else {
            return
        }
        
        // request.httpBody = httpBody
        request.httpBody = httpBody
        
        let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
            
            if error != nil{
                print("error",error)
                return
            }
            let responsestring=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            print("respnsedate,\(responsestring)")
            
            do{
                let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers)as? NSDictionary
                print("jsonsignup",jsonarray)
                let status=jsonarray!["status"] as! Bool
                if status==true{
                    self.menutoken=jsonarray!["menu_token"] as! String
                    UserDefaults.standard.set(self.menutoken, forKey: "menutoken")
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                         let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
                        yourcart.idfromexpand=self.id
                        yourcart.listfromexpand=self.list
                        yourcart.mainmenunamefromexpand=self.mainmenuname
                        
                        UserDefaults.standard.set(self.id, forKey: "addedidtocart")
                        UserDefaults.standard.set(self.id, forKey: "idforpartyorder")
                        UserDefaults.standard.set(self.list, forKey: "listforpartyorder")
                        UserDefaults.standard.set(self.mainmenuname, forKey: "mainmenunamepartyorder")

                    self.navigationController?.pushViewController(yourcart, animated: true)
                    }
                }else{
                    self.showToast(message: "Something went wrong", font: UIFont.systemFont(ofSize: 14), duration: 2)
                }
                
            }
            catch{
                 DispatchQueue.main.async {
                     self.hud.hide(animated: true)
                     self.showToast(message: "Something went wrong", font: UIFont.systemFont(ofSize: 14), duration: 2)
                }
                
                print(error)
            }
        }
        .resume()
        
    }
    
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    
    
    
}




