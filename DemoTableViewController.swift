//
//  DemoTableViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 27/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
//import ExpandableTableViewController


//class DemoTableViewController: ExpandableTableViewController, ExpandableTableViewDelegate {
//
//    var id=String()
//    var list=String()
//    var subcategorynamearray=[String]()
//    var topcategoryarray=[String]()
//    var countarray=[String]()
//    var dict=[String:[String]]()
//    var subcategoryidarray=[String]()
//     var expandedsubcategoryidarray=[String]()
//    var dishescell=DishesTableViewCell()
//    var expandedarray=[String]()
//    var grp_sub_category_name=String()
//
//
//    struct Objects {
//
//        var sectionName : String!
//        var sectionObjects : [String]!
//    }
//
//    var objectArray = [Objects]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//self.expandableTableView.expandableDelegate = self
//
//        self.navigationItem.hidesBackButton = true
//               let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
//               navigationItem.leftBarButtonItem = btnsback
//        service_party_productsall()
//    }
//
//
//
//    override func viewWillAppear(_ animated: Bool)
//        {
//            super.viewWillAppear(animated)
//            let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
//            title = "Frequently Asked Questions"
//    //            let titleAttributes = [
//    //                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)
//    //                ]
//    //                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
//
//
//            lbl.text = title
//            lbl.font = UIFont.systemFont(ofSize: 16.0)
//            lbl.textColor = .black
//            lbl.textAlignment = .center
//            navigationItem.titleView=lbl
//
//
//
//    }
//
//        func backButton(imageName: String, selector: Selector) -> UIBarButtonItem {
//            let button = UIButton(type: .custom)
//            //        button.setImage(UIImage(named: imageName), for: .normal)
//            button.setBackgroundImage(UIImage(named: imageName), for: .normal)
//            button.frame = CGRect(x: 0, y: 0, width:30, height: 30)
//            button.backgroundColor = UIColor.clear
//            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
//            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
//            button.addTarget(self, action: selector, for: .touchUpInside)
//            return UIBarButtonItem(customView: button)
//        }
//
//        @objc func back(sender: UIBarButtonItem) {
//            // Perform your custom actions
//            // ...
//            // Go back to the previous ViewController
//            self.navigationController?.popViewController(animated: true)
//        }
//
//
//
//
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
//        print("topcategoryarraycount",topcategoryarray.count)
//        print("topcategoryarray",topcategoryarray)
//        print("subcate",subcategorynamearray)
//        print("dict",dict)
//        return dict.count
////        return objectArray[section].sectionObjects.count
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> UITableViewCell {
//         dishescell = expandableTableView.dequeueReusableCellWithIdentifier("DishesTableViewCell", forIndexPath: expandableIndexPath) as! DishesTableViewCell
//               //titleCell.lblquestion.text=questionarray[expandableIndexPath.row]
//        dishescell.lbldishname.text=(Array(dict.keys))[expandableIndexPath.row]
//
//        dishescell.lblnoofchoosendishes.text="You can choose "+countarray[expandableIndexPath.row]+" items"
//        dishescell.accessoryType = .disclosureIndicator
//      return dishescell
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
//
//       return 150
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, estimatedHeightForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
//        return 150
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) {
//        subcategorynamearray.removeAll()
//        if let cell = expandableTableView.cellForRowAtIndexPath(expandableIndexPath) as? CommonTableViewCell{
//                    if expandableTableView.isCellExpandedAtExpandableIndexPath(expandableIndexPath){
//                      print("expandableIndexPath",expandableIndexPath)
//
//                        cell.showSeparator()
//                    }else{
//                        cell.hideSeparator()
//                    }
//            expandableTableView.reloadData()
//                }
//                 expandableTableView.deselectRowAtExpandableIndexPath(expandableIndexPath, animated: true)
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfSubRowsInRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> Int {
//        print("objectArray",objectArray)
//        expandedarray.removeAll()
//        let expanded=(Array(dict))[expandableIndexPath.row]
//        print("expanded",expanded)
//        print("expanded.value",expanded.value)
//        expandedarray=expanded.value
////        print(expandedsubcategoryidarray[expandableIndexPath.row])
////        for i in 0...expandedsubcategoryidarray.count-1{
////       if expanded.key==expandedsubcategoryidarray[i]{
////           expandedarray=expanded.value
////       }
////        }
//       print("expandedarray",expandedarray)
//
//        return (expandedarray).count
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, subCellForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> UITableViewCell {
//        let dishesexpansion = expandableTableView.dequeueReusableCellWithIdentifier("DishesexpansionTableViewCell", forIndexPath: expandableIndexPath) as! DishesexpansionTableViewCell
//
//        for i in 0...expandedarray.count-1{
//
//           print(expandedarray[i])
//        }
//
//
//        return dishesexpansion
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForSubRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
//        return 61
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, estimatedHeightForSubRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
//         return 61
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectSubRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) {
//
//    }
//
//
//
//
//    func service_party_productsall(){
//
//        guard let url=NSURL(string :"https://niyaregency.com/api/Data/party_products_all")else{return}
//        let poststring="security_token=niya32jfhdu392nfbfdr&list=\(list)&id=\(id)"
//                   var request = NSMutableURLRequest(url: url as URL)
//                   request.httpMethod = "POST"
//                   request.httpBody = poststring.data(using: String.Encoding.utf8)
//                   let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
//
//                       if error != nil{
//                           print("error",error)
//                           return
//                       }
//                       print("poststring",poststring)
//                       let responsestring=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//
//                       print("respnsedate,\(responsestring)")
//
//                       do{
//                       let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers)as? NSDictionary
//                         if let parseJson = jsonarray{
//
//
//                             let products=parseJson["products"]as! NSDictionary
//
//                                          let totalproducts=products["products"] as! NSArray
//                            self.topcategoryarray.removeAll()
//                            self.subcategorynamearray.removeAll()
//                            self.countarray.removeAll()
//                            self.objectArray.removeAll()
//                                          for value in totalproducts{
//                                              let item:[String:Any]=value as! [String:Any]
//
//                                              let grp_sub_category_id=item["grp_sub_category_id"] as! String
//                                            self.grp_sub_category_name=item["grp_sub_category_name"] as! String
//                                              let count_value=item["count_value"] as! String
//                                            self.subcategoryidarray.append(grp_sub_category_id)
//                                            let sub=item["sub"] as! NSArray
//                                            self.subcategorynamearray.removeAll()
//                                            for item in sub{
//                                                let subcategory:[String:Any]=item as! [String:Any]
//                                                let grp_food_item_id=subcategory["grp_food_item_id"] as! String
//                                                let grp_sub_category_id=subcategory["grp_sub_category_id"] as! String
//                                                let grp_food_item_name=subcategory["grp_food_item_name"] as! String
//                                                self.expandedsubcategoryidarray.append(grp_sub_category_id)
//                                                for values in self.subcategoryidarray{
//                                                    if values == grp_sub_category_id{
//                                                self.subcategorynamearray.append(grp_food_item_name)
//                                                        self.dict.updateValue(self.subcategorynamearray, forKey: self.grp_sub_category_name)
//
//
//
//                                                    }else{
//
//                                                    }
//
//                                            }
//                                            }
//
//
//
//                                            self.topcategoryarray.append(self.grp_sub_category_name)
//
//                                            self.countarray.append(count_value)
//
//
//
//                            }
//                 for (key, value) in self.dict {
//                    self.objectArray.append(Objects(sectionName: key, sectionObjects: value))
//                                }
//                   print("objectArray",self.objectArray)
//                            DispatchQueue.main.async {
//                            // self.hud.hide(animated: true)
//                                   self.expandableTableView.reloadData()
//                                         }
//
//
//                                    }else{
//                                     DispatchQueue.main.async {
//                                     self.showToast(message: "Error in fetching details", font: UIFont.boldSystemFont(ofSize: 14))
//                                     }
//                                     }
//                                 }
//
//                                              catch {
//                                              print(error)
//                                              }
//
//                                     }.resume()
//}
//
//
//
//
//}
    
    
    
    
    
    

  
