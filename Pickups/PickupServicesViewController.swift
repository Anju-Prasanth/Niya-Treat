//
//  PickupServicesViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 14/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import iOSDropDown
import MBProgressHUD

@available(iOS 13.0, *)
class PickupServicesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
   
    @IBOutlet weak var tbleviewpickupservices: UITableView!
    var pickupservice=pickupserviceTableViewCell()
    var serviceflag=Int()
    var carnamearray=[String]()
    var seatarray=[Int]()
    var countarray=[String]()
    var countindex=String()
    var carindex=String()
    var ampmselection=String()
    var caridarray=[String]()
    var caridindex=String()
    var roomidpickupvc=String()
    var hud:MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        print("serviceflag",serviceflag)
        countarray=["1","2","3","4","5","6","7","8","9","10"]
        
       tbleviewpickupservices.register(UINib(nibName: "pickupserviceTableViewCell", bundle: nil), forCellReuseIdentifier: "pickupserviceTableViewCell")
        service_car_list()
    }
    override func viewWillAppear(_ animated: Bool)
                   {
                       super.viewWillAppear(animated)
                    
                    
                           self.navigationController?.navigationBar.barTintColor = .white
                    //self.navigationController?.navigationBar.isTranslucent = false
                   // let height: CGFloat = 100//whatever height you want
                   // let bounds = self.navigationController!.navigationBar.bounds
                   // self.navigationController?.navigationBar.frame = CGRect(x: 0, y: ((UIApplication.shared.statusBarView?.frame.height)!)+10, width: bounds.width, height:(UIApplication.shared.statusBarView?.frame.height)! + height)
                       let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
                    if serviceflag==1{
                         title = " Pick up from Airport"
                    }else if serviceflag==2{
                       title = " Pick up from Railway Station"
                    }else{
                        title = " Pick up from Bus Station"
                    }
                      
                       lbl.text = title
                       lbl.font = UIFont.systemFont(ofSize: 20.0)
                     lbl.textColor =  UIColor.darkGray
                       lbl.textAlignment = .left
                       navigationItem.titleView=lbl
                           
                       
                   }
                
                
//                override func viewWillDisappear(_ animated: Bool) {
//
//
//                        let height: CGFloat = 100//whatever height you want
//                        let bounds = self.navigationController!.navigationBar.bounds
//                        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.height)!, width: bounds.width, height:(UIApplication.shared.statusBarView?.frame.height)! + height)
//                    }
//
//
                
                
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
                  
                    // self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: false, completion: nil)
                }
                
       
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carnamearray.count-(carnamearray.count-1)
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            pickupservice = (tableView.dequeueReusableCell(withIdentifier: "pickupserviceTableViewCell", for: indexPath) as? pickupserviceTableViewCell)!
        
        if serviceflag==1{
            pickupservice.trainnumber.text="Airline/Flight Number"
             pickupservice.txtfldarrivingat.text="Cochin Interntional Airport"
        }else if serviceflag==2{
             pickupservice.trainnumber.text="Train Number/Train"
             pickupservice.txtfldarrivingat.text="Thrissur Railway Station "
        }else if serviceflag==3{
            pickupservice.trainnumber.text="Bus Name"
             pickupservice.txtfldarrivingat.text="Bus Station Thrissur"
        }else{
            
        }
    
        
        pickupservice.txtfldchoosecount.delegate=self
         pickupservice.txtfldchoosecar.delegate=self
        pickupservice.txtfldchoosecount.optionArray=countarray
        pickupservice.txtfldchoosecar.optionArray=carnamearray
        if pickupservice.txtfldchoosecar.text?.isEmpty==true{
            if UserDefaults.standard.value(forKey: "carname") != nil{
            pickupservice.txtfldchoosecar.text=UserDefaults.standard.value(forKey: "carname") as! String
            self.caridindex=UserDefaults.standard.value(forKey: "carid") as! String
            }
        }
        
         if pickupservice.txtfldchoosecount.text?.isEmpty==true{
             if UserDefaults.standard.value(forKey: "carcount")  != nil{
                pickupservice.txtfldchoosecount.text=UserDefaults.standard.value(forKey: "carcount") as! String
             self.countindex=UserDefaults.standard.value(forKey: "carcount") as! String
        }
        }
        
        if pickupservice.txtfldhour.text==" "{
            pickupservice.txtfldhour.text="12"
        }
        if pickupservice.txtfldminute.text==" "{
                  pickupservice.txtfldhour.text="00"
              }
       // if pickupservice.txtfldam.text.is||pickupservice.txtfldpm.text==" "{
            pickupservice.txtfldpm.text="PM"
            ampmselection="PM"
        //}
        
        pickupservice.txtfldchoosecount.didSelect{(selectedText , index ,id) in
        let count = "Selected String: \(selectedText) \n index: \(index)"
       
         self.countindex=self.countarray[index]
         UserDefaults.standard.set(self.countindex, forKey: "carcount")
        }
        
        pickupservice.txtfldchoosecar.didSelect{(selectedText , index ,id) in
               let car = "Selected String: \(selectedText) \n index: \(index)"
              
             self.carindex=self.carnamearray[index]
            self.caridindex=self.caridarray[index]
            UserDefaults.standard.set(self.caridindex, forKey: "carid")
       }
        
          pickupservice.btnam.addTarget(self, action: #selector(btnamcaction(sender:)), for: .touchUpInside)
        
          pickupservice.btnpm.addTarget(self, action: #selector(btnpmaction(sender:)), for: .touchUpInside)
        
        
        
         return pickupservice
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 562
    }

    func service_car_list(){
        self.showhud()
              guard let url=NSURL(string :"https://niyaregency.com/api/Data/car_list/")else{return}
        let poststring="security_token=niya32jfhdu392nfbfdr"
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
                       let status=parseJson["status"]as! Bool
                        let Cars=parseJson["Cars"]as! NSArray
                        
                        for values in Cars{
                            let item:[String:Any]=values as! [String:Any]
                            let car_id=item["car_id"] as! String
                            let car_name=item["car_name"] as! String
                            let seat=(item["seat"] as! NSString).intValue
                             let type1cost=item["type1_cost"] as! String
                             let type2cost=item["type2_cost"] as! String
                             let type3cost=item["type3_cost"] as! String
                            self.carnamearray.append(car_name+" ("+String(Int(seat-1))+") ")
                            self.seatarray.append(Int(seat-1))
                            self.caridarray.append(car_id)
                            
                            UserDefaults.standard.set(self.carnamearray[0], forKey: "carname")
                            UserDefaults.standard.set(self.caridarray[0], forKey: "carid")
                            UserDefaults.standard.set(self.countarray[0], forKey: "carcount")
                        }
                        print("seatarray",self.seatarray)
                              
                        
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                               self.tbleviewpickupservices.reloadData()
                               }
                          
                           
                       }else{
                           DispatchQueue.main.async {
                             self.hud.hide(animated: true)
                            self.showToast(message: "Unable o fetch car details", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                           }
                           }
                       }
                   
                                    catch {
                                    print(error)
                                    }
                                                                  
                           }.resume()
                       }
       
    
    @objc func btnamcaction(sender: UIButton){
        pickupservice.txtfldam.backgroundColor=UIColor(red: 112 / 255, green: 247 / 255, blue: 188 / 255, alpha: 1.0)
            pickupservice.txtfldpm.backgroundColor = .white
        ampmselection="AM"
    }
    
    @objc func btnpmaction(sender: UIButton){
          pickupservice.txtfldpm.backgroundColor=UIColor(red: 112 / 255, green: 247 / 255, blue: 188 / 255, alpha: 1.0)
        pickupservice.txtfldam.backgroundColor = .white
        ampmselection="PM"
    }
    
    
    func service_cab_insert(){
        self.showhud()
        let arrivaltime = pickupservice.txtfldhour.text!+":"+pickupservice.txtfldminute.text!+" "+ampmselection
                  
                 guard let url=NSURL(string :"https://niyaregency.com/api/Data/cab_insert/")else{return}
        let poststring="number=\(pickupservice.txtfldtrainnumber.text!)&type=\(serviceflag)&contact=\(pickupservice.txtfldtravellername.text!)&cnumber=\(pickupservice.txtfldtravellernumber.text!)&arrival_time=\(arrivaltime)&station=\(pickupservice.txtfldarrivingat.text!)&car_id=\(self.caridindex)&car_count=\( self.countindex)&security_token=niya32jfhdu392nfbfdr"
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
                          let status=parseJson["status"]as! Bool
                            
                           
                                 
                           
                           DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                                  let reviewbooking = self.storyboard?.instantiateViewController (withIdentifier: "ReviewbookingViewController") as! ReviewbookingViewController
                               reviewbooking.roomidreviewbooking=self.roomidpickupvc
                                  self.navigationController?.pushViewController(reviewbooking, animated: true)
                                  }
                             
                              
                          }else{
                              DispatchQueue.main.async {
                                self.hud.hide(animated: true)
                                self.showToast(message: "Unable to get the details", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                              }
                              }
                          }
                      
                                       catch {
                                       print(error)
                                       }
                                                                     
                              }.resume()
                          }
    
    
    @IBAction func btncontinueaction(_ sender: Any) {
        if pickupservice.txtfldtrainnumber.text?.isEmpty==true||pickupservice.txtfldtravellername.text?.isEmpty==true||pickupservice.txtfldtravellernumber.text?.isEmpty==true{
        
            showToast(message: "All fields are mandatory", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
        }else{
            
        service_cab_insert()
        UserDefaults.standard.set(serviceflag, forKey: "cab_token")
        UserDefaults.standard.set(roomidpickupvc, forKey: "room_id")
        }
    }
    
    
    @IBAction func btnskipaction(_ sender: Any) {
        let reviewbooking = self.storyboard?.instantiateViewController (withIdentifier: "ReviewbookingViewController") as! ReviewbookingViewController
        reviewbooking.roomidreviewbooking=self.roomidpickupvc
        self.navigationController?.pushViewController(reviewbooking, animated: true)
        
    }
    
    func showhud(){
           hud = MBProgressHUD.showAdded(to: self.view, animated: true)
           hud.mode = MBProgressHUDMode.indeterminate
       }
    
}
