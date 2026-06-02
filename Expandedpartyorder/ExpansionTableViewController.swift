//
//  ExpansionTableViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 01/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ExpansionTableViewController: UITableViewController {
    var id=String()
       var list=String()
       var subcategorynamearray=[String]()
       var topcategoryarray=[String]()
       var countarray=[String]()
       var dict=[String:[String]]()
    var subcategoryidarray=[String]()
     var expandedsubcategoryidarray=[String]()
    var dishescell=DishesTableViewCell()
    var expandedarray=[String]()
    var grp_sub_category_name=String()
    var dictforplaceorder=[[String:String]]()
    var mainmenuprice=String()
    var mainmenuname=String()
    var grp_sub_category_id=String()
    
    var cell1=ExapansionTableViewCell()
     var cell2=ExpandedTableViewCell()
    //var cell3=ConstantTableViewCell()
     var dictid=[String:[String]]()
    var itemname=String()
    var itemnamearray=[String]()
    var dictpassedpartyorder=[[String:String]]()
     var partyorderarray=[[String:String]]()
    var count=Int()
    var count_value=String()
    var count_value2=String()
    var mainmenuarray=[[String:String]]()
    var mainmenuitemarray=[[String:String]]()
    var numberofpeoplepartyorder=Int()
    var cartprice=Int()
   

    
    
    struct Objects {
            var opened:Bool!
          var sectionName : String!
          var sectionObjects : [String]!
        var sectionCount:String!
       
      }
     var objectArray = [Objects]()
    
      struct Objectsid {
        var opened:Bool!
             var maincategoryid : String!
             var subcatfoodid : [String]!
          
         }

    var objectArrayid = [Objectsid]()

    override func viewDidLoad() {
        super.viewDidLoad()
//         UserDefaults.standard.removeObject(forKey: "itemnames")
//        UserDefaults.standard.removeObject(forKey: "partyorderarray")
         print("partyorderarray",partyorderarray)
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
        if let itemarray=UserDefaults.standard.array(forKey: "itemnames"){
               if itemarray.isEmpty==true{

               }else{
                   itemnamearray=UserDefaults.standard.array(forKey: "itemnames") as! [String]


                   }
               }
        
         if let menuitemarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart"){
            if menuitemarray.isEmpty==true{

                          }else{
                mainmenuitemarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String:String]]


                              }
            
        }
               
        
        
        let hight=UIScreen.main.bounds.height
        print("hight",hight)
        let myFirstButton = UIButton()
        
       
        myFirstButton.setTitle("Add to cart", for: .normal)
        myFirstButton.setTitleColor(.blue, for: .normal)
        myFirstButton.backgroundColor=UIColor.red
        myFirstButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-150, width: UIScreen.main.bounds.width, height: 40)
        myFirstButton.addTarget(self, action: #selector(btncartpressed(sender:)), for: .touchUpInside)
       
        self.view.addSubview(myFirstButton)
       service_party_productsall()
        
        
      
    }

    
    @objc func btncartpressed(sender:UIButton){
         let partyorder = self.storyboard?.instantiateViewController (withIdentifier: "PartyorderproductsViewController") as! PartyorderproductsViewController
        if partyorderarray.isEmpty==true{
           DispatchQueue.main.async {
            self.showToast(message: "Your cart is empty", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
            }
        }else{
            let totalpriceforanitem = Int(mainmenuprice)!*numberofpeoplepartyorder
            var item=[String:Any]()
            item.updateValue(mainmenuname, forKey: "mainmenuitem")
            item.updateValue(String(totalpriceforanitem), forKey: "mainmenuitemprice")
            item.updateValue(String(1), forKey: "quantity")
            item.updateValue(mainmenuprice,forKey:"actualprice")
            mainmenuitemarray.append(item as! [String : String])
            UserDefaults.standard.set(mainmenuitemarray, forKey: "mainmenuitemarraycart")
        }
        mainmenuitemarray=UserDefaults.standard.array(forKey: "mainmenuitemarraycart") as! [[String:String]]
        print(mainmenuitemarray)
        for values in mainmenuitemarray{
            let item:[String:String]=values as! [String:String]
            cartprice+=(item["mainmenuitemprice"] as! NSString).integerValue
        }
         UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
        
        
//         let partyorder = self.storyboard?.instantiateViewController (withIdentifier: "PartyorderproductsViewController") as! PartyorderproductsViewController
//         var items=[String:String]()
//               items.updateValue(id, forKey: "mainmenuid")
//               items.updateValue(mainmenuprice, forKey: "actualprice")
//              // items.updateValue(String(price_value), forKey: "totalprice")
//               items.updateValue(itemname, forKey: "subitemname")
//              items.updateValue(mainmenuname, forKey: "mainitemname")
//             items.updateValue(String(itemnamearray.count), forKey: "choosenitemnumber")
//        if partyorderarray.isEmpty==true{
//        dictpassedpartyorder.append(items)
//        UserDefaults.standard.set(dictpassedpartyorder, forKey: "partyorderarray")
//        }else{
//            partyorderarray.append(items)
//             UserDefaults.standard.set(partyorderarray, forKey: "partyorderarray")
//
//        }
//
//        partyorderarray=UserDefaults.standard.array(forKey: "partyorderarray") as! [[String : String]]
//        print("partyorderarray",partyorderarray)
         self.navigationController?.pushViewController(partyorder, animated: true)
        
  
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return objectArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if objectArrayid[section].opened==true{
        return objectArray[section].sectionObjects.count+1
        }else{
        return 1
        }
        
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       print("countarray",countarray)
        let dataindex=indexPath.row-1
        if indexPath.row==0{
         cell1 = (tableView.dequeueReusableCell(withIdentifier: "ExapansionTableViewCell", for: indexPath) as? ExapansionTableViewCell)!
            cell1.lbltitle.text=objectArray[indexPath.section].sectionName
//            cell1.lbltitle.text=topcategoryarray[indexPath.section]
        
//            cell1.lblitemschoosen.text="You can choose "+objectArrayid[indexPath.section].countid+" items"
             count=((countarray[indexPath.section]) as NSString).integerValue
            return cell1
        }else {
           cell2 = (tableView.dequeueReusableCell(withIdentifier: "ExpandedTableViewCell", for: indexPath) as? ExpandedTableViewCell)!
                     
                       cell2.lblsubtitle.text=objectArray[indexPath.section].sectionObjects[dataindex]
                      cell2.btnselection.tag=dataindex
                      cell2.btnselection.addTarget(self, action: #selector(btnselectionpressed(sender:)), for: .touchUpInside)
//                       cell1 = (tableView.dequeueReusableCell(withIdentifier: "ExapansionTableViewCell", for: indexPath) as? ExapansionTableViewCell)!
                      return cell2
            
        }
        }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row==0{
            return 150
        }else {
           return UITableView.automaticDimension
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let dataindex=indexPath.row-1
        if indexPath.row==0{
            if objectArrayid[indexPath.section].opened==true{
                objectArrayid[indexPath.section].opened=false
                let sections=IndexSet.init(integer: indexPath.section)
               
                tableView.reloadSections(sections, with: .none)
            }else{
                objectArrayid[indexPath.section].opened=true
                let sections=IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }else{
            print("value",objectArray[indexPath.section].sectionObjects[dataindex])
            print(count)
            
            print("main",objectArrayid[indexPath.section].subcatfoodid[dataindex])
           
            itemname=objectArray[indexPath.section].sectionObjects[dataindex]
            if partyorderarray.isEmpty==true{
             var items=[String:String]()
                   items.updateValue(id, forKey: "mainmenuid")
                   items.updateValue(mainmenuprice, forKey: "actualprice")
                  // items.updateValue(String(price_value), forKey: "totalprice")
                   items.updateValue(itemname, forKey: "subitemname")
                  items.updateValue(mainmenuname, forKey: "mainitemname")
                 items.updateValue(String(itemnamearray.count), forKey: "choosenitemnumber")
                itemnamearray.append(itemname)
                UserDefaults.standard.set(itemnamearray, forKey: "itemnames")
                dictpassedpartyorder.append(items)
                UserDefaults.standard.set(dictpassedpartyorder, forKey: "partyorderarray")
            }else{
                if itemnamearray.contains(itemname){
                for value in itemnamearray{
                        let indexofitemnamearray=itemnamearray.index(of:value)
                        if value==itemname{
                            itemnamearray.remove(at: indexofitemnamearray!)
                        }
                        UserDefaults.standard.set(itemnamearray, forKey: "itemnames")
                    }
              print("partyorderarray",partyorderarray)
                for values in partyorderarray{
                let indexofpartyorderarray=partyorderarray.index(of:values)
                var item:[String:String]=values as [String:String]
                if item["subitemname"]==itemname{
                    partyorderarray.remove(at: indexofpartyorderarray!)
                    UserDefaults.standard.set(partyorderarray, forKey: "partyorderarray")
                    partyorderarray=UserDefaults.standard.array(forKey:  "partyorderarray") as! [[String : String]]
                }
                }
                }else{
                    var items=[String:String]()
                      items.updateValue(id, forKey: "mainmenuid")
                      items.updateValue(mainmenuprice, forKey: "actualprice")
                     // items.updateValue(String(price_value), forKey: "totalprice")
                      items.updateValue(itemname, forKey: "subitemname")
                     items.updateValue(mainmenuname, forKey: "mainitemname")
                    items.updateValue(String(itemnamearray.count), forKey: "choosenitemnumber")
                    itemnamearray.append(itemname)
                                   UserDefaults.standard.set(itemnamearray, forKey: "itemnames")
                                   partyorderarray.append(items)
                                   UserDefaults.standard.set(partyorderarray, forKey: "partyorderarray")
                }
                    
        
            
            
                            
            }
            partyorderarray=UserDefaults.standard.array(forKey: "partyorderarray") as! [[String : String]]
            itemnamearray=UserDefaults.standard.array(forKey: "itemnames") as! [String]
            print("partyorderarray",partyorderarray)
            print("itemnamearray",itemnamearray)
        }
    }
       
    func service_party_productsall(){
        
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
        
        
                                 let products=parseJson["products"]as! NSDictionary
                                             
                               let totalproducts=products["products"] as! NSArray
                                
                                self.topcategoryarray.removeAll()
                                self.subcategorynamearray.removeAll()
                                self.countarray.removeAll()
                                self.objectArray.removeAll()
                                 self.expandedsubcategoryidarray.removeAll()
                                 
                                for value in totalproducts{
                                                  let item:[String:Any]=value as! [String:Any]
                                                  
                                                self.grp_sub_category_id=item["grp_sub_category_id"] as! String
                                                self.grp_sub_category_name=item["grp_sub_category_name"] as! String
                                                self.count_value=item["count_value"] as! String
                                                self.subcategoryidarray.append(self.grp_sub_category_id)
                                               // self.countarray.append(self.count_value)
                                                let sub=item["sub"] as! NSArray
                                                self.subcategorynamearray.removeAll()
                                                self.expandedsubcategoryidarray.removeAll()
                                                // self.objectArray.removeAll()
                                                for item in sub{
                                                    let subcategory:[String:Any]=item as! [String:Any]
                                                    let grp_food_item_id=subcategory["grp_food_item_id"] as! String
                                                    let grp_sub_category_idinsub=subcategory["grp_sub_category_id"] as! String
                                                    let grp_food_item_name=subcategory["grp_food_item_name"] as! String
                                                    self.subcategorynamearray.append(grp_food_item_name)
                                                    self.dict.updateValue(self.subcategorynamearray, forKey:
                                                    self.grp_sub_category_name)
                                                  self.expandedsubcategoryidarray.append(grp_food_item_id)
                                                   
                                                  self.dictid.updateValue(self.expandedsubcategoryidarray, forKey: self.grp_sub_category_id)
                                                   
                                                 
                                                    for values in self.subcategoryidarray{
                                                        if values == self.grp_sub_category_id{
                                                  //  self.expandedsubcategoryidarray.append(grp_sub_category_id)
                                                   // self.subcategorynamearray.append(grp_food_item_name)
                                                          
//                                                    self.dict.updateValue(self.subcategorynamearray, forKey:
//                                                        self.grp_sub_category_name)
                                                       
                                                    self.dictforplaceorder.append(item as! [String : String])
                                                    
                                                                          
                                                        }else{
                                                            
                                                        }
                                                        
                                                    
                                                   
                                                }
                                                }
                                               
                                    
                                self.topcategoryarray.append(self.grp_sub_category_name)
                                   self.countarray.append(self.count_value)
                                     
                                 print("dict",self.dict)
                                 print("subcategorynamearray",self.subcategorynamearray)
                                print("subcategoryidarray",self.subcategoryidarray)
                                print("dictforplaceorder",self.dictforplaceorder)
                                }
                                
                               print("dictid",self.dictid)
                              print("objectArray",self.objectArray)
                                DispatchQueue.main.async {
                                 for (key, value) in self.dict {
                                 
                                    self.objectArray.append(Objects(opened: false, sectionName: key, sectionObjects: value))

                                         
                                    }
                                    
                                    for (key,value) in self.dictid{
                                        self.objectArrayid.append(Objectsid(opened:false,maincategoryid: key, subcatfoodid: value))
                                    }
//
                                    print("objectArrayid",self.objectArrayid)
                                    
                                       self.tableView.reloadData()
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
    
    
    
    @objc func btnselectionpressed(sender: UIButton){
        
        if sender.isSelected==true{
                  sender.isSelected=false
                   //sender.setImage(UIImage (named: "icons8-unchecked-checkbox-24"), for: .normal)
            sender.backgroundColor=UIColor.white
              }else{
                  sender.isSelected=true
                 // sender.setImage(UIImage (named: "icons8-checked-checkbox-24"), for: .normal)
             sender.backgroundColor=UIColor.orange
              }
        
        
    }
   
                  
    }

