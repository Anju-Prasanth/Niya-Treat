//
//  ProfileeditViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 19/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import MBProgressHUD

@available(iOS 13.0, *)
class ProfileeditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var btnongoingorders: UIButton!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var lblpartyorderline: UILabel!
    @IBOutlet weak var lblfoodorderline: UILabel!
    @IBOutlet weak var lblroombookingline: UILabel!
    @IBOutlet weak var lblnotregisterduser: UILabel!
    @IBOutlet weak var lblnoorders: UILabel!
    @IBOutlet weak var viewprofile: UIView!
    @IBOutlet weak var btnoredersbooked: UIButton!
    @IBOutlet weak var btnupcomingoreders: UIButton!
    
    @IBOutlet weak var btncancelreviewentered: UIButton!
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var txtfldemail: UITextField!
    @IBOutlet weak var txtfldmobile: UITextField!
    @IBOutlet weak var txtfldname: UITextField!
    @IBOutlet weak var imageviewprofile: UIImageView!
    @IBOutlet weak var tableviewprofileedit: UITableView!
     @IBOutlet weak var viewreview: UIView!
     @IBOutlet weak var viewsubmitreview: UIView!
    
    @IBOutlet weak var btnreviewsubmit: UIButton!
    @IBOutlet weak var btnreviwcancel: UIButton!
    @IBOutlet weak var lblbookingcode: UILabel!
    
    @IBOutlet weak var txtviewreview: UITextView!
    
    @IBOutlet weak var lblyourreview: UILabel!
    
    var cell=ProfileeditTableViewCell()
   
    var image_url=String()
    var username=String()
    var useremail=String()
    var mobile=String()
    var start_datearray=[String]()
     var end_datearray=[String]()
   
    var order_codearray=[String]()
     var room_namearray=[String]()
     var room_imagearray=[String]()
    var createddatearray=[String]()
    var userid=String()
     var hud: MBProgressHUD = MBProgressHUD()
    var foodorder=FoodorderTableViewCell()
    var orderlistarray=[[String:Any]]()
    var productarray=[[String:Any]]()
    var orderflag=Int()
    var userid_orderhistory=String()
    var type_orderhistory=String()
    var completedbookingflag=0
    var reviewarray=[String]()
    var order_id=String()
    var order_idarray=[String]()
    var reviewentered=String()
    var orderid=String()
    var cancelflagforroom=Int()
    var bookingstatusarray=[String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
               let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
               navigationItem.leftBarButtonItem = btnsback
       if let useridvalue = UserDefaults.standard.value(forKey: "userid") {
             userid=UserDefaults.standard.value(forKey:"userid") as! String
         user_upcomig_booking_history()
        } else {
        
         btnupcomingoreders.isHidden=true
         btnoredersbooked.isHidden=true
         tableviewprofileedit.isHidden=true
         lblnotregisterduser.isHidden=false
        
        }
       
        btnongoingorders.layer.cornerRadius=5
               btnongoingorders.layer.borderWidth=1
               btnongoingorders.layer.borderColor=UIColor.darkGray.cgColor
        btnoredersbooked.layer.cornerRadius=5
        btnoredersbooked.layer.borderWidth=1
        btnoredersbooked.layer.borderColor=UIColor.darkGray.cgColor
        btnupcomingoreders.layer.cornerRadius=5
        btnupcomingoreders.layer.borderWidth=1
        btnupcomingoreders.layer.borderColor=UIColor.darkGray.cgColor
        btnupcomingoreders.titleLabel?.textColor=UIColor.white
        lblroombookingline.isHidden=false
        lblnoorders.isHidden=true
//        btnoredersbooked.titleLabel?.textColor=UIColor.black
        
       
        self.tableviewprofileedit.register(UINib(nibName: "ProfileeditTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileeditTableViewCell")
        self.tableviewprofileedit.register(UINib(nibName: "FoodorderTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodorderTableViewCell")
        
        btnupcomingoreders.backgroundColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0)
        btnoredersbooked.backgroundColor=UIColor.white
        viewsubmitreview.layer.cornerRadius=10
        
    }
    
    override func viewWillAppear(_ animated: Bool)
                          {
                              super.viewWillAppear(animated)
                              
                            
                              self.navigationController?.navigationBar.barTintColor = .white
                           //self.navigationController?.navigationBar.isTranslucent = false
         
                              let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
                              
                              title = " Order History"
                              
                              lbl.text = title
                              lbl.font = UIFont.systemFont(ofSize: 20.0)
                              lbl.textColor =  UIColor.darkGray
                              lbl.textAlignment = .left
                              navigationItem.titleView=lbl
                            
                            
                    if let useridorderhistory=UserDefaults.standard.value(forKey:"useridfororderhistory"){
                        userid_orderhistory=UserDefaults.standard.value(forKey:"useridfororderhistory") as! String
                                
                            }
                            
                            if let typeorderhistory=UserDefaults.standard.value(forKey:"typeorderhistory"){
                                   type_orderhistory=UserDefaults.standard.value(forKey:"typeorderhistory") as! String
                                           
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
                       let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
                                     
                            self.navigationController?.pushViewController(home, animated: true)
                       }
                       
    

         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if orderflag==1||orderflag==2{
                return orderlistarray.count
            }else{
        return createddatearray.count
            }
            }
                
                
              
                
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    if orderflag==1||orderflag==2{
                         let item = orderlistarray[indexPath.row]
                         foodorder = (tableView.dequeueReusableCell(withIdentifier: "FoodorderTableViewCell", for: indexPath) as? FoodorderTableViewCell)!
                        foodorder.lblordercode.text=item["order_code"] as! String
                         foodorder.lblcreateddate.text="Date: " + String(item["created_date"] as! String)
                        foodorder.lblorderstatus.text="Status: "+String(item["status_name"] as! String)
                        foodorder.lblgranttotal.text="Total: "+String(item["grand_total"] as! String)+" INR"
                        foodorder.btndetails.tag=indexPath.row
                    foodorder.btndetails.addTarget(self, action: #selector(buttondetailstapped(sender:)), for: .touchUpInside)
                        return foodorder
                    }else{
                        
                      cell = (tableView.dequeueReusableCell(withIdentifier: "ProfileeditTableViewCell", for: indexPath) as? ProfileeditTableViewCell)!
                    cell.lbldate.text=createddatearray[indexPath.row]
                    cell.lblcheckindate.text=start_datearray[indexPath.row]
                    cell.lvblcheckoutdate.text=end_datearray[indexPath.row]
                    cell.lblbookingcode.text=order_codearray[indexPath.row]
                    cell.lblroomname.text=room_namearray[indexPath.row]
                    let url = URL(string:room_imagearray[indexPath.row])
                    cell.imageviewroom.kf.indicatorType = .activity
                    cell.imageviewroom.kf.setImage(with: url)
                    cell.imageviewroom.contentMode = .scaleToFill
                        if completedbookingflag==0{
                            cell.btnsubmitreview.isHidden=true
                            cell.btncancelrequest.isHidden=false
                            if bookingstatusarray[indexPath.row]=="1"{
                                cell.btncancelrequest.setTitle("Cancel", for: .normal)
                            }else if bookingstatusarray[indexPath.row]=="0"{
                                 cell.btncancelrequest.setTitle("Cancel request processing", for: .normal)
                            }else{
                                cell.btncancelrequest.setTitle("Cancelled", for: .normal)
                            }
                           
            
                        }else{
                             cell.btncancelrequest.isHidden=true
                            if reviewarray[indexPath.row]==""{
                                cell.btnsubmitreview.tag=indexPath.row
                             cell.btnsubmitreview.isHidden=false
                                cell.btnsubmitreview.setTitle("SUBMIT REVIEW", for: .normal)
                            cell.btnsubmitreview.layer.cornerRadius=5
                        cell.btnsubmitreview.addTarget(self, action: #selector(btnsubmitreviewpressed(sender:)), for: .touchUpInside)
                            }else{
                                cell.btnsubmitreview.tag=indexPath.row
                                cell.btnsubmitreview.isHidden=false
                                cell.btnsubmitreview.setTitle("VIEW REVIEW", for: .normal)
                                 cell.btnsubmitreview.layer.cornerRadius=5
                                 cell.btnsubmitreview.addTarget(self, action: #selector(btnsubmitreviewpressed(sender:)), for: .touchUpInside)
                            }
                        }
                        cell.btncancelrequest.tag=indexPath.row
                        cell.btncancelrequest.addTarget(self, action: #selector(btncancelpressed(sender:)), for: .touchUpInside)
                   
                    return cell
                   }
    }
                   
                func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    if orderflag==1||orderflag==2{
                        return 120
                    }else{

                    return 230
                    }
                }
    
     @objc func btncancelpressed(sender:UIButton){
        
        btnreviwcancel.layer.cornerRadius=10
        btnreviewsubmit.layer.cornerRadius=10
        btnreviwcancel.layer.borderColor=UIColor.systemOrange.cgColor
        btnreviewsubmit.layer.borderColor=UIColor.systemOrange.cgColor
         btnreviewsubmit.layer.borderWidth=1
         btnreviwcancel.layer.borderWidth=1
        
        txtviewreview.layer.borderColor=UIColor.lightGray.cgColor
        txtviewreview.layer.borderWidth=1
         txtviewreview.layer.cornerRadius=10
        viewreview.isHidden=false
        lblyourreview.text="Booking Cancellation Request"
        lblbookingcode.text="Booking Code: "+order_codearray[sender.tag]
        txtviewreview.isUserInteractionEnabled=true
        cancelflagforroom=1
        order_id=order_idarray[sender.tag]
        
    }
    
    @objc func btnsubmitreviewpressed(sender:UIButton){
         viewreview.isHidden=false
        if reviewarray[sender.tag]==""{
            btnreviwcancel.isHidden=false
            btnreviewsubmit.isHidden=false
            btncancelreviewentered.isHidden=true
                   
        btnreviwcancel.layer.cornerRadius=10
        btnreviewsubmit.layer.cornerRadius=10
        btnreviwcancel.layer.borderColor=UIColor.systemOrange.cgColor
        btnreviewsubmit.layer.borderColor=UIColor.systemOrange.cgColor
         btnreviewsubmit.layer.borderWidth=1
         btnreviwcancel.layer.borderWidth=1
        
        txtviewreview.layer.borderColor=UIColor.lightGray.cgColor
        txtviewreview.layer.borderWidth=1
         txtviewreview.layer.cornerRadius=10
        lblyourreview.text="Review your booking here"
             txtviewreview.isUserInteractionEnabled=true
        }else{
            btnreviwcancel.isHidden=true
            btnreviewsubmit.isHidden=true
                 btncancelreviewentered.isHidden=false
            btncancelreviewentered.layer.cornerRadius=10
            lblyourreview.text="Your review"
            txtviewreview.text=reviewarray[sender.tag]
            txtviewreview.isUserInteractionEnabled=false
            
        }
        lblbookingcode.text="Booking Code: "+order_codearray[sender.tag]
        
        order_id=order_idarray[sender.tag]
       
    }
    
    @objc func buttondetailstapped(sender:UIButton){
        
        let item=orderlistarray[sender.tag]
        let orderid=item["order_id"] as! String
        let order_code=item["order_code"] as! String
        let created_date=item["created_date"] as! String
        let status_name=item["status_name"] as! String
        let grand_total=item["grand_total"] as! String
        let pax=item["pax"] as! String
        let review=item["review"] as! String
        let activity=item["activity"]as! String
        if orderflag==1{
        let details = self.storyboard?.instantiateViewController (withIdentifier: "OrderDetailsViewController") as!
                   OrderDetailsViewController
        details.order_id=orderid
         details.ordercode=order_code
         details.status=status_name
         details.createddate=created_date
         details.grand_total=grand_total
        details.review_submitted=review
        details.activity_food=activity
        self.navigationController?.pushViewController(details, animated: true)
        }else if orderflag==2{
            
            let partydetails = self.storyboard?.instantiateViewController (withIdentifier: "PartyorderdetailsViewController") as!
                       PartyorderdetailsViewController
            partydetails.order_id=orderid
             partydetails.ordercode=order_code
             partydetails.status=status_name
             partydetails.createddate=created_date
             partydetails.grand_total=grand_total
            partydetails.pax=pax
            partydetails.review_submitted=review
            self.navigationController?.pushViewController(partydetails, animated: true)
            
        }
        
    }
    
    
    @IBAction func btnongoingaction(_ sender: Any) {
        
        btnongoingorders.backgroundColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0)
               btnupcomingoreders.backgroundColor=UIColor.white
              
               btnupcomingoreders.titleLabel?.textColor=UIColor.black
               btnoredersbooked.setTitleColor(.black, for: .normal)
               btnoredersbooked.titleLabel?.textColor=UIColor.black
               btnongoingorders.setTitleColor(.white, for: .normal)
        completedbookingflag=0
        user_ongoing_booking_history()
        
        
        
    }
    @IBAction func btnordersbooked(_ sender: Any) {
        btnoredersbooked.backgroundColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0)
        btnupcomingoreders.backgroundColor=UIColor.white
       
        btnupcomingoreders.titleLabel?.textColor=UIColor.black
        btnoredersbooked.setTitleColor(.white, for: .normal)
        btnongoingorders.titleLabel?.textColor=UIColor.black
        btnongoingorders.backgroundColor=UIColor.white
        
         completedbookingflag=1
        
        user_completed_booking_history()
       
    }
    
    @IBAction func btnupcomingoreders(_ sender: Any) {
        btnupcomingoreders.backgroundColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0)
        btnoredersbooked.backgroundColor=UIColor.white
        btnoredersbooked.titleLabel?.textColor=UIColor.black
        btnupcomingoreders.titleLabel?.textColor=UIColor.white
        btnongoingorders.titleLabel?.textColor=UIColor.black
         btnongoingorders.backgroundColor=UIColor.white
         completedbookingflag=0
        user_upcomig_booking_history()
    }
    
//    @IBAction func btneditaction(_ sender: Any) {
//        if btnedit.currentTitle=="Save"{
//
//          service_profile_edit()
//            btncancel.isHidden=true
//        }else{
//
//            btnedit.setTitle("Save", for: .normal)
//            txtfldmobile.isUserInteractionEnabled=true
//            txtfldemail.isUserInteractionEnabled=true
//            txtfldname.isUserInteractionEnabled=true
//            btncancel.isHidden=false
//        }
//        //save
//    }
    
//    @IBAction func btncancelaction(_ sender: Any) {
//        txtfldmobile.isUserInteractionEnabled=false
//               txtfldemail.isUserInteractionEnabled=false
//               txtfldname.isUserInteractionEnabled=false
//         btnedit.setTitle("Edit", for: .normal)
//         btncancel.isHidden=true
//    }
//
    func user_completed_booking_history(){
    
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/user_room_booking_history")else{return}
        let poststring="user_id=\(userid)"
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
                            self.image_url=data["image_url"]as! String
                            let logged_user_details=data["logged_user_details"] as! NSArray
                           for value in logged_user_details{
                               let item:[String:Any]=value as! [String:Any]
                               self.username=item["user_name"] as! String
                               self.useremail=item["user_email"] as! String
                               self.mobile=item["mobile"] as! String
                                
                               //dict2.append(item as! [String : String])
                               
                           }
                            let over=data["over"] as! NSArray
                            if over.count==0{
                                DispatchQueue.main.async{
                                 self.tableviewprofileedit.isHidden=true
                                    self.lblnoorders.isHidden=false
                                }
                                
                            }else{
                                self.createddatearray.removeAll()
                                 self.start_datearray.removeAll()
                                 self.end_datearray.removeAll()
                                 self.order_codearray.removeAll()
                                 self.room_namearray.removeAll()
                                 self.room_imagearray.removeAll()
                                self.order_idarray.removeAll()
                            for value in over{
                            let item:[String:Any]=value as! [String:Any]
                            let start_date=item["start_date"] as! String
                            let end_date=item["end_date"] as! String
                            let order_code=item["order_code"] as! String
                            let room_name=item["room_name"] as! String
                            let room_image=item["room_image"] as! String
                            let created_date=item["created_date"] as! String
                            let review=item["review"] as! String
                                let roomorderid=item["room_order_id"] as! String
                                
                            self.start_datearray.append(start_date)
                            self.end_datearray.append(end_date)
                            self.order_codearray.append(order_code)
                            self.room_namearray.append(room_name)
                                self.room_imagearray.append(self.image_url+room_image)
                                self.createddatearray.append(created_date)
                                self.reviewarray.append(review)
                                self.order_idarray.append(roomorderid)
                            //dict2.appe
                            }
                            DispatchQueue.main.async {
                                self.tableviewprofileedit.isHidden=false
                                self.lblnoorders.isHidden=true
//                                self.txtfldname.text=self.username
//                                self.txtfldemail.text=self.useremail
//                                self.txtfldmobile.text=self.mobile
                                self.tableviewprofileedit.reloadData()
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
    func user_upcomig_booking_history(){
     self.showhud()
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/user_room_booking_history")else{return}
        let poststring="user_id=\(userid)"
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
                            self.image_url=data["image_url"]as! String
                            let logged_user_details=data["logged_user_details"] as! NSArray
                            let orders_upcoming=data["orders_upcoming"] as! NSArray
                            for value in logged_user_details{
                                let item:[String:Any]=value as! [String:Any]
                                self.username=item["user_name"] as! String
                                self.useremail=item["user_email"] as! String
                                self.mobile=item["mobile"] as! String
                                 
                                //dict2.append(item as! [String : String])
                                
                            }
                            if orders_upcoming.count==0{
                                DispatchQueue.main.async {
                                self.tableviewprofileedit.isHidden=true
                                self.lblnoorders.isHidden=false
                                }
                            }else{
                                 self.createddatearray.removeAll()
                               
                                self.start_datearray.removeAll()
                                self.end_datearray.removeAll()
                                self.order_codearray.removeAll()
                                self.room_namearray.removeAll()
                                self.room_imagearray.removeAll()
                                self.order_idarray.removeAll()
                            for value in orders_upcoming{
                            let item:[String:Any]=value as! [String:Any]
                            let start_date=item["start_date"] as! String
                            let end_date=item["end_date"] as! String
                            let order_code=item["order_code"] as! String
                            let room_name=item["room_name"] as! String
                            let room_image=item["room_image"] as! String
                            let created_date=item["created_date"] as! String
                              let roomorderid=item["room_order_id"] as! String
                               let  booking_status=item["booking_status"] as! String
                            self.start_datearray.append(start_date)
                            self.end_datearray.append(end_date)
                            self.order_codearray.append(order_code)
                            self.room_namearray.append(room_name)
                                self.room_imagearray.append(self.image_url+room_image)
                                self.createddatearray.append(created_date)
                                self.order_idarray.append(roomorderid)
                                self.bookingstatusarray.append(booking_status)
                            //dict2.appe
                            }
                                DispatchQueue.main.async {
                                    self.hud.hide(animated: true)
                                    self.lblnoorders.isHidden=true
                                    self.tableviewprofileedit.isHidden=false
                                     self.tableviewprofileedit.reloadData()
                                }
                            }
                            DispatchQueue.main.async {
                                 self.hud.hide(animated: true)
//                                self.txtfldname.text=self.username
//                                self.txtfldemail.text=self.useremail
//                                self.txtfldmobile.text=self.mobile
                               
                                
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
    
    func user_ongoing_booking_history(){
        
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/user_room_booking_history")else{return}
            let poststring="user_id=\(userid)"
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
                                self.image_url=data["image_url"]as! String
                               let logged_user_details=data["logged_user_details"] as! NSArray
                                let ongoing=data["on_going"] as! NSArray
                                for value in logged_user_details{
                                   let item:[String:Any]=value as! [String:Any]
                                   self.username=item["user_name"] as! String
                                   self.useremail=item["user_email"] as! String
                                   self.mobile=item["mobile"] as! String
                                    
                                   //dict2.append(item as! [String : String])
                                   
                               }
                               
                                if ongoing.count==0{
                                    DispatchQueue.main.async{
                                     self.tableviewprofileedit.isHidden=true
                                        self.lblnoorders.isHidden=false
                                    }
                                    
                                }else{
                                    self.createddatearray.removeAll()
                                     self.start_datearray.removeAll()
                                     self.end_datearray.removeAll()
                                     self.order_codearray.removeAll()
                                     self.room_namearray.removeAll()
                                     self.room_imagearray.removeAll()
                                    self.order_idarray.removeAll()
                                for value in ongoing{
                                let item:[String:Any]=value as! [String:Any]
                                let start_date=item["start_date"] as! String
                                let end_date=item["end_date"] as! String
                                let order_code=item["order_code"] as! String
                                let room_name=item["room_name"] as! String
                                let room_image=item["room_image"] as! String
                                let created_date=item["created_date"] as! String
                                let review=item["review"] as! String
                                    let roomorderid=item["room_order_id"] as! String
                                     let  booking_status=item["booking_status"] as! String
                                self.start_datearray.append(start_date)
                                self.end_datearray.append(end_date)
                                self.order_codearray.append(order_code)
                                self.room_namearray.append(room_name)
                                    self.room_imagearray.append(self.image_url+room_image)
                                    self.createddatearray.append(created_date)
                                    self.reviewarray.append(review)
                                    self.order_idarray.append(roomorderid)
                                    self.bookingstatusarray.append(booking_status)
                                }
                                DispatchQueue.main.async {
                                    self.tableviewprofileedit.isHidden=false
                                    self.lblnoorders.isHidden=true
    //                                self.txtfldname.text=self.username
    //                                self.txtfldemail.text=self.useremail
    //                                self.txtfldmobile.text=self.mobile
                                    self.tableviewprofileedit.reloadData()
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
    
    
    
    
//    func service_profile_edit(){
//        var usernameedited=String()
//        var mobileedited=String()
//        if txtfldname.text?.isEmpty==true{
//
//        }else{
//            usernameedited=txtfldname.text!
//        }
//       if txtfldmobile.text?.isEmpty==true{
//
//       }else{
//        mobileedited=txtfldmobile.text!
//        }
//     self.showhud()
//        guard let url=NSURL(string :"https://niyaregency.com/api/Data/profile_edit")else{return}
//        let poststring="user_id=85&mobile=\(mobileedited)&security_token=niya32jfhdu392nfbfdr&user_name=\(usernameedited)"
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
//                           if let parseJson = jsonarray{
//                            let status=parseJson["status"]as! Bool
//                            if status==true{
//                                DispatchQueue.main.async {
//                                    self.hud.hide(animated: true)
//                                    self.showToast(message: "Successfully updated", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
//                                }
//
//                            }else{
//
//                            }
//                  }else{
//                                  DispatchQueue.main.async {
//                                     self.hud.hide(animated: true)
//                                    self.showToast(message: "Error in fetching details", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
//                                  }
//                                  }
//                              }
//
//                                           catch {
//                                           print(error)
//                                           }
//
//                                  }.resume()
//
//
//                       }
//
    
    
    func service_food_history(){
         orderlistarray.removeAll()
         self.showhud()
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/food_history")else{return}
            let poststring="user_id=\(userid_orderhistory)&type=\(type_orderhistory)&security_token=niya32jfhdu392nfbfdr"
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
                                self.orderlistarray=data["order_list"] as! [[String:Any]]
                                print("orderlistarray",self.orderlistarray)
                                if self.orderlistarray.count>0{
                                    DispatchQueue.main.async {
                                        self.hud.hide(animated: true)
                                        self.lblnoorders.isHidden=true
                                        self.tableviewprofileedit.isHidden=false
                                        self.tableviewprofileedit.reloadData()
                                        
                                    }
                                }else{
                                     DispatchQueue.main.async {
                                    self.hud.hide(animated: true)
                                    self.lblnoorders.isHidden=false
                                    self.tableviewprofileedit.isHidden=true
                                    }
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
        
    func service_party_order_history(){
        orderlistarray.removeAll()
            self.showhud()
               guard let url=NSURL(string :"https://niyaregency.com/api/Data/food_history_party")else{return}
               let poststring="user_id=\(userid_orderhistory)&type=\(type_orderhistory)&security_token=niya32jfhdu392nfbfdr"
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
                                   self.orderlistarray=data["order_list_normal"] as! [[String:Any]]
                                   print("orderlistarray",self.orderlistarray)
                                   if self.orderlistarray.count>0{
                                       DispatchQueue.main.async {
                                           self.hud.hide(animated: true)
                                        self.lblnoorders.isHidden=true
                                           self.tableviewprofileedit.isHidden=false
                                           self.tableviewprofileedit.reloadData()
                                           
                                       }
                                   }else{
                                    
                                    DispatchQueue.main.async {
                                    self.hud.hide(animated: true)
                                    self.lblnoorders.isHidden=false
                                  self.tableviewprofileedit.isHidden=true
                                    
                                    }
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
           
    
    
    
    
    func showhud(){
           hud = MBProgressHUD.showAdded(to: self.view, animated: true)
           hud.mode = MBProgressHUDMode.indeterminate
       }
    
    
    @IBAction func btnfoodorderaction(_ sender: Any) {
        orderflag=1
        lblroombookingline.isHidden=true
        lblfoodorderline.isHidden=false
        lblpartyorderline.isHidden=true
        stackview.isHidden=true
        service_food_history()
        
    }
    
    
    
    @IBAction func btnpartyorderaction(_ sender: Any) {
        lblroombookingline.isHidden=true
        lblfoodorderline.isHidden=true
        lblpartyorderline.isHidden=false
        orderflag=2
        stackview.isHidden=true
        service_party_order_history()
    }
    
    
    @IBAction func btnroombookingaction(_ sender: Any) {
        lblroombookingline.isHidden=false
        lblfoodorderline.isHidden=true
        lblpartyorderline.isHidden=true
        orderflag=0
        stackview.isHidden=false
        
        btnupcomingoreders.titleLabel?.textColor=UIColor.white
        btnoredersbooked.titleLabel?.textColor=UIColor.black
            
                btnupcomingoreders.backgroundColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0)
                btnoredersbooked.backgroundColor=UIColor.white
        completedbookingflag=0
        
        user_upcomig_booking_history()
        
    }
    
    @IBAction func btnreviewcancelaction(_ sender: Any) {
        
        viewreview.isHidden=true
        btnreviwcancel.backgroundColor=UIColor.systemOrange
        btnreviwcancel.setTitleColor(.white, for: .normal)
        btnreviewsubmit.backgroundColor=UIColor.white
        btnreviewsubmit.setTitleColor(.systemOrange, for: .normal)
    }
    
    @IBAction func btnreviewsubmitactio(_ sender: Any) {
        

               btnreviwcancel.backgroundColor=UIColor.white
               btnreviwcancel.setTitleColor(.systemOrange, for: .normal)
               btnreviewsubmit.backgroundColor=UIColor.systemOrange
               btnreviewsubmit.setTitleColor(.white, for: .normal)
        if txtviewreview.text==""||txtviewreview.text.isEmpty==true||txtviewreview.text==" "||txtviewreview.text==nil{
            if cancelflagforroom==1{
             showToast(message: "Please enter the reason", font: UIFont.boldSystemFont(ofSize: 14),duration: 2)
            }else{
                showToast(message: "Please enter the review", font: UIFont.boldSystemFont(ofSize: 14),duration: 2)
            }
        }else{
        reviewentered=txtviewreview.text
            if cancelflagforroom==1{
                service_room_cancel()
            }else{
        service_user_review()
            }
        }
    }
    
    @IBAction func btncancelreviewentrdaction(_ sender: Any) {
        
        viewreview.isHidden=true
        
        
    }
    
    
    
    
    func service_user_review(){
        guard let url=NSURL(string :"https://niyaregency.com/api/Data/user_review")else{return}
        let poststring="order_id=\(order_id)&type=1&review=\(reviewentered)&security_token=niya32jfhdu392nfbfdr"
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
                                            self.viewreview.isHidden=true
                                                                                }
                                    }else{
                                        DispatchQueue.main.async {
                                                                                                                         
                                        self.showToast(message: "Something went wrong", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                            self.user_completed_booking_history()
//                                            self.tableviewfoodorderdetails.reloadData()
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
    
    
    func service_room_cancel(){
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/room_cancel")else{return}
            let poststring="booking_id=\(order_id)&reason=\(reviewentered)&user_id=\(userid)"
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
                                                                                      
                                            self.showToast(message: "Your cancellation is processing.Our representative will contact shortly.", font: UIFont.boldSystemFont(ofSize: 11), duration: 2)
                                                self.viewreview.isHidden=true
                                                                                    }
                                        }else{
                                            DispatchQueue.main.async {
                                                                                                                             
                                            self.showToast(message: "Something went wrong", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                                self.user_upcomig_booking_history()
    //                                            self.tableviewfoodorderdetails.reloadData()
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
