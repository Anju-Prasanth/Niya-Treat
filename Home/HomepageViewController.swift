//
//  HomepageViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 18/12/19.
//  Copyright © 2019 Arun Vijayan. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD
import FBSDKCoreKit
import FBSDKLoginKit


extension UIApplication {

    
    var statusBarView: UIView? {
        
//        if #available(iOS 13.1, *) {
//            let view = UIView()
//            return value(forKey: "statusBarManager") as? UIView
//        }
//        else{
//            return value(forKey: "statusBar") as? UIView
//        }
        
        if #available(iOS 13.0, *) {
            let tag = 38482
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                guard let statusBarFrame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame else { return nil }
                let statusBarView = UIView(frame: statusBarFrame)
                statusBarView.tag = tag
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        } else {
            return nil
        }
        
        
    }
  
}




func showAlert(text:String, classInstance:UIViewController) {
    let alert = UIAlertController(title: "Alert", message: text, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        switch action.style{
        case .default:
            print("default")
            
        case .cancel:
            print("cancel")
            
        case .destructive:
            print("destructive")
            
            
        }}))
    classInstance.present(alert, animated: true, completion: nil)
}



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}




@available(iOS 13.0, *)
@available(iOS 13.0, *)
class HomepageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableviewhomepage: UITableView!
    var dates=BookyournightsTableViewCell()
    var cousine=WorldclasscouisineTableViewCell()
    var enquiry=EnquiriesTableViewCell()
    var roombuttonimage=RoombuttonimageTableViewCell()
    var imagearray=[String]()
    
    var myday=String()
    var nextmyday=String()
    var currentday=String()
    var currentweekday=String()
    var currentmonth=String()
    var currentyear=String()
    var nextday=String()
    var nextweekday=String()
    var nextmonth=String()
    var nextyear=String()
    var applyflag=Int()
    var totalrooms=Int()
    var totalnumbers=Int()
    var totaladult=Int()
    var totalchild=Int()
    var applyflagfromroomguests=Int()
    var childtempvaluearrayhome=[Int]()
    var adulttempvaluearrayhome=[Int]()
   var totalroomcuontarrayhome=[Int]()
    var addonemoreflaghome=Int()
    var roomcountarrayhome=[Int]()
    var username=String()
    var Total_no_of_days=Double()
    var foodtype=0
    var roomactionflag=Int()
    var pooram_status=String()
   
    @IBOutlet weak var btnhome: UIButton!
    
    @IBOutlet weak var btnroom: UIButton!
    
    var hud:MBProgressHUD!
    var accesstokenfb=NSObject()
    var fbflag=Int()
    var useremail=String()
    var uniqueid=String()
    var usermobile=String()
    var device_id=String()
    var device_token=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let  deviceid=UserDefaults.standard.value(forKey: "device_id"){
                   device_id=UserDefaults.standard.value(forKey: "device_id") as! String
               }
               if let devicetoken=UserDefaults.standard.value(forKey: "fcm_token"){
                   device_token=UserDefaults.standard.value(forKey: "fcm_token") as! String
               }
        
       
        
        
//        if fbflag==1{
//          getFBUserData()
//        }
        
        

        
        UserDefaults.standard.removeObject(forKey: "myarray")
        UserDefaults.standard.removeObject(forKey: "carttotalprice")
        UserDefaults.standard.removeObject(forKey: "partyorderarray")
         
         UserDefaults.standard.removeObject(forKey: "itemsubids")
         UserDefaults.standard.removeObject(forKey: "mainmenuitemarraycart")
        UserDefaults.standard.removeObject(forKey: "partyinsertarray")
         UserDefaults.standard.removeObject(forKey: "itemsubids")
         UserDefaults.standard.removeObject(forKey: "menutoken")
        UserDefaults.standard.removeObject(forKey: "subidarrayback")
       // UserDefaults.standard.removeObject(forKey: "nonvegitemarray")
        
        UserDefaults.standard.removeObject(forKey: "partyinsertarray")
        UserDefaults.standard.removeObject(forKey: "partyinsertmenulistdictionary")
        UserDefaults.standard.removeObject(forKey: "maindictionarypartyinsert")
               
        
        
        UserDefaults.standard.removeObject(forKey: "roomlistarray")
               UserDefaults.standard.removeObject(forKey: "maindictionaryroom")
               UserDefaults.standard.removeObject(forKey: "roomlistdictionary")
                UserDefaults.standard.removeObject(forKey: "productarray")
                UserDefaults.standard.removeObject(forKey: "productlistdictionary")
        UserDefaults.standard.removeObject(forKey: "maindictionary")
        
        
        
        print("applyflag",applyflag)
        self.navigationItem.hidesBackButton = true
        if let user_name=UserDefaults.standard.value(forKey: "username"){
        username=UserDefaults.standard.value(forKey: "username") as! String
        }
    print("username",username)
        if let revealController = self.revealViewController() {
          // revealController.panGestureRecognizer()
           revealController.tapGestureRecognizer()
       }
        print("roomcountarrayhome",roomcountarrayhome)
         print("childtempvaluearrayhome",childtempvaluearrayhome)
         print("adulttempvaluearrayhome",adulttempvaluearrayhome)
        print("addonemoreflaghome",addonemoreflaghome)
        print("totalroomcuontarrayhome",totalroomcuontarrayhome)
        
       tableviewhomepage.register(UINib(nibName: "BookyournightsTableViewCell", bundle: nil), forCellReuseIdentifier: "BookyournightsTableViewCell")
        tableviewhomepage.register(UINib(nibName: "WorldclasscouisineTableViewCell", bundle: nil), forCellReuseIdentifier: "WorldclasscouisineTableViewCell")
        tableviewhomepage.register(UINib(nibName: "EnquiriesTableViewCell", bundle: nil), forCellReuseIdentifier: "EnquiriesTableViewCell")
        tableviewhomepage.register(UINib(nibName: "RoombuttonimageTableViewCell", bundle: nil), forCellReuseIdentifier: "RoombuttonimageTableViewCell")
        
        
        service_dashboard()
//        if applyflag==0{
//
//             let today_date = Date()
//              let format = DateFormatter()
//              format.dateFormat = "dd MMM yyy"
//              format.timeZone = .current
//              let formattedDate = format.string(from: today_date)
//
//
//        let calendar = Calendar.current
//        currentday=String(calendar.component(.day, from: today_date))
//        currentweekday=String(calendar.component(.weekday, from: today_date))
//        currentyear=String(calendar.component(.year, from: today_date))
//
//
//        let daysToAdd = 1
//
//        var dateComponent = DateComponents()
//        dateComponent.day = daysToAdd
//
//        let futureDate = Calendar.current.date(byAdding: dateComponent, to: today_date)!
//        print("futureDate",futureDate)
//
//        let formattedfuturedate=format.string(from: futureDate)
//
//         nextday=String(calendar.component(.day, from: futureDate))
//          nextweekday=String(calendar.component(.weekday, from: futureDate))
//          nextyear=String(calendar.component(.year, from: futureDate))
//
//                    format.dateFormat="MMM"
//                     currentmonth=format.string(from: today_date)
//
//                     nextmonth=format.string(from: futureDate)
//
//                      if currentweekday=="1"{
//                            myday="Sunday"
//                             }else if currentweekday=="2"{
//                            myday="Monday"
//                            }else if currentweekday=="3"{
//                            myday="Tuesday"
//                            }else if currentweekday=="4"{
//                            myday="Wednesday"
//                            }else if currentweekday=="5"{
//                            myday="Thursday"
//                            }else if currentweekday=="6"{
//                            myday="Friday"
//                            }else{
//                            myday="Saturday"
//                            }
//
//                         if nextweekday=="1"{
//                               nextmyday="Sunday"
//                                }else if nextweekday=="2"{
//                               nextmyday="Monday"
//                               }else if nextweekday=="3"{
//                               nextmyday="Tuesday"
//                               }else if nextweekday=="4"{
//                               nextmyday="Wednesday"
//                               }else if nextweekday=="5"{
//                               nextmyday="Thursday"
//                               }else if nextweekday=="6"{
//                               nextmyday="Friday"
//                               }else{
//                               nextmyday="Saturday"
//                               }
//                         }
//
//        if roomactionflag==1{
//            btnroom.setImage(UIImage(named:"Icon ionic-ios-bed-1"), for: .normal)
//            btnhome.setImage(UIImage(named:"Group 3-1"), for: .normal)
//        }else{
            btnroom.setImage(UIImage(named:"Group 4"), for: .normal)
            btnhome.setImage(UIImage(named:"Group 3"), for: .normal)
//        }
       
      
    }
    
    
     override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        if self.revealViewController() != nil {
           // self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        }
        
//        let sw = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//        self.view.window?.rootViewController = sw
//
//       // let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let desController = self.storyboard?.instantiateViewController(withIdentifier: "SlidemenuViewController") as! SlidemenuViewController
//        let newFrontViewController = UINavigationController.init(rootViewController:desController)
//        sw.pushFrontViewController(newFrontViewController, animated: true)
//
//
        
        
        UserDefaults.standard.removeObject(forKey: "myarray")
               UserDefaults.standard.removeObject(forKey: "carttotalprice")
               UserDefaults.standard.removeObject(forKey: "partyorderarray")
//         UserDefaults.standard.set(nil, forKey: "partyorderarray")
                UserDefaults.standard.removeObject(forKey: "itemsubids")
                UserDefaults.standard.removeObject(forKey: "mainmenuitemarraycart")
               UserDefaults.standard.removeObject(forKey: "partyinsertarray")
                UserDefaults.standard.removeObject(forKey: "itemsubids")
                UserDefaults.standard.removeObject(forKey: "menutoken")
               UserDefaults.standard.removeObject(forKey: "subidarrayback")
               // UserDefaults.standard.removeObject(forKey: "nonvegitemarray")
               
               UserDefaults.standard.removeObject(forKey: "partyinsertarray")
               UserDefaults.standard.removeObject(forKey: "partyinsertmenulistdictionary")
               UserDefaults.standard.removeObject(forKey: "maindictionarypartyinsert")
                      
               
               
               UserDefaults.standard.removeObject(forKey: "roomlistarray")
                      UserDefaults.standard.removeObject(forKey: "maindictionaryroom")
                      UserDefaults.standard.removeObject(forKey: "roomlistdictionary")
                       UserDefaults.standard.removeObject(forKey: "productarray")
                       UserDefaults.standard.removeObject(forKey: "productlistdictionary")
               UserDefaults.standard.removeObject(forKey: "maindictionary")
               
               
        

            let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 150, height: 35))
             imageView.contentMode = .scaleAspectFit

              let image = UIImage(named: "Group 2")
              imageView.image = image

              navigationItem.titleView = imageView
        
        if let user_name=UserDefaults.standard.value(forKey: "username"){
        username=UserDefaults.standard.value(forKey: "username") as! String
        }
         print("username",username)
        if let  apply_flag=UserDefaults.standard.value(forKey: "applyflag"){
            applyflag=UserDefaults.standard.value(forKey: "applyflag") as! Int
        }
print("applyflag",applyflag)
        
             if applyflag==0{

              let today_date = Date()
               let format = DateFormatter()
               format.dateFormat = "dd MMM yyy"
               format.timeZone = .current
               let formattedDate = format.string(from: today_date)


         let calendar = Calendar.current
         currentday=String(calendar.component(.day, from: today_date))
         currentweekday=String(calendar.component(.weekday, from: today_date))
         currentyear=String(calendar.component(.year, from: today_date))


         let daysToAdd = 1

         var dateComponent = DateComponents()
         dateComponent.day = daysToAdd

         let futureDate = Calendar.current.date(byAdding: dateComponent, to: today_date)!
         print("futureDate",futureDate)

         let formattedfuturedate=format.string(from: futureDate)

          nextday=String(calendar.component(.day, from: futureDate))
           nextweekday=String(calendar.component(.weekday, from: futureDate))
           nextyear=String(calendar.component(.year, from: futureDate))

                     format.dateFormat="MMM"
                      currentmonth=format.string(from: today_date)

                      nextmonth=format.string(from: futureDate)

                       if currentweekday=="1"{
                             myday="Sunday"
                              }else if currentweekday=="2"{
                             myday="Monday"
                             }else if currentweekday=="3"{
                             myday="Tuesday"
                             }else if currentweekday=="4"{
                             myday="Wednesday"
                             }else if currentweekday=="5"{
                             myday="Thursday"
                             }else if currentweekday=="6"{
                             myday="Friday"
                             }else{
                             myday="Saturday"
                             }

                          if nextweekday=="1"{
                                nextmyday="Sunday"
                                 }else if nextweekday=="2"{
                                nextmyday="Monday"
                                }else if nextweekday=="3"{
                                nextmyday="Tuesday"
                                }else if nextweekday=="4"{
                                nextmyday="Wednesday"
                                }else if nextweekday=="5"{
                                nextmyday="Thursday"
                                }else if nextweekday=="6"{
                                nextmyday="Friday"
                                }else{
                                nextmyday="Saturday"
                                }
             }else{

      if let checkin__day=UserDefaults.standard.value(forKey: "checkinday"){
                         currentday=UserDefaults.standard.value(forKey: "checkinday") as! String
        print("currentday",currentday)
                     }
                     if let checkin_weekday=UserDefaults.standard.value(forKey: "checkinweekday"){
                         myday=UserDefaults.standard.value(forKey: "checkinweekday") as! String

                        print("myday",myday)
                     }

        if let checkin_month=UserDefaults.standard.value(forKey: "checkinmonth"){
            currentmonth=UserDefaults.standard.value(forKey: "checkinmonth") as! String
             print("currentmonth",currentmonth)
        }
        if let checkin_year=UserDefaults.standard.value(forKey: "checkinyear"){
            currentyear=UserDefaults.standard.value(forKey: "checkinyear") as! String
            print("currentyear",currentyear)
        }


        if let checkout__day=UserDefaults.standard.value(forKey: "checkoutday"){
                         nextday=UserDefaults.standard.value(forKey: "checkoutday") as! String
             print("nextday",nextday)
                     }
                     if let checkout_weekday=UserDefaults.standard.value(forKey: "checkoutweekday"){
                         nextmyday=UserDefaults.standard.value(forKey: "checkoutweekday") as! String
                         print("nextmyday",nextmyday)
                     }

        if let checkout_month=UserDefaults.standard.value(forKey: "checkoutmonth"){
            nextmonth=UserDefaults.standard.value(forKey: "checkoutmonth") as! String
             print("nextmonth",nextmonth)
        }
        if let checkout_year=UserDefaults.standard.value(forKey: "checkoutyear"){
            nextyear=UserDefaults.standard.value(forKey: "checkoutyear") as! String
            print("nextyear",nextyear)
        }


        }
        
        
        if let total_adult=UserDefaults.standard.value(forKey: "totaladult"){
            totaladult=UserDefaults.standard.value(forKey: "totaladult") as! Int
        }
        if let total_child=UserDefaults.standard.value(forKey: "totalchild"){
                   totalchild=UserDefaults.standard.value(forKey: "totalchild") as! Int
               }
        if totaladult+totalchild>1{
            totalroomcuontarrayhome=UserDefaults.standard.array(forKey: "roomnumbers") as! [Int]
            childtempvaluearrayhome=UserDefaults.standard.array(forKey: "childnumber") as! [Int]
            adulttempvaluearrayhome=UserDefaults.standard.array(forKey: "adultnumber") as! [Int]
            totaladult=UserDefaults.standard.value(forKey: "totaladult") as! Int
            totalchild=UserDefaults.standard.value(forKey: "totalchild") as! Int
            applyflagfromroomguests=UserDefaults.standard.value(forKey: "applyflagroom") as! Int
            roomcountarrayhome=UserDefaults.standard.array(forKey: "roomcountarray") as! [Int]

        }


                         
        
        print("roomcountarrayhome",roomcountarrayhome)
                      print("childtempvaluearrayhome",childtempvaluearrayhome)
                      print("adulttempvaluearrayhome",adulttempvaluearrayhome)
                     print("addonemoreflaghome",addonemoreflaghome)
                     print("totalroomcuontarrayhome",totalroomcuontarrayhome)

        }
    
    
//    func getFBUserData(){
//     
//        if((accesstokenfb) != nil){
//           
//            guard let accessToken = FBSDKLoginKit.AccessToken.current else { return }
//            let graphRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
//                                                          parameters: ["fields": "email, name"],
//                                                          tokenString: accessToken.tokenString,
//                                                          version: nil,
//                                                          httpMethod: .get)
//            graphRequest.start { (connection, result, error) -> Void in
//                if error == nil {
//                    let dict = result as! NSDictionary
//                    
//                    self.get_fblogin_details(dict: dict)
//                    
//                    
//                }
//                else {
//                    print("error \(error)")
//                }
//            }
//            
//            
//            
//            
//        }
//    }
//    
//    func get_fblogin_details(dict:NSDictionary){
//        print("dict",dict)
//        print("currentuserid:",UserDefaults.standard.value(forKey: "userid") as Any)
//        let fbemail : String = dict.object(forKey: "email") as! String
//        print(fbemail)
//        let fbname = dict.object(forKey: "name") as! String
//        print(fbname)
//        //            let phonenumber = dict.object(forKey: "mobile") as! String
//        //            print(fbname)
//        let id=dict.object(forKey: "id") as! String
//        
//        username=fbname
//        useremail=fbemail
//        // usermobile=phonenumber
//        print("id",id)
//        uniqueid=id
//        UserDefaults.standard.set(username, forKey:"username")
//        
//        UserDefaults.standard.set(useremail, forKey:"useremail")
//        UserDefaults.standard.set(id, forKey: "uniqueidforguest")
//        
//        
//        service_insert_guest()
//        
//        
//        
//    }
    
    
    
    func service_insert_guest(){
          // self.showhud()
           guard let url=NSURL(string :"https://niyaregency.com/api/Data/insert_guest")else{return}
           let poststring="user_name=\(username)&user_email=\(useremail)&mobile=\(usermobile)&unique_id=\(uniqueid)&security_token=niya32jfhdu392nfbfdr&device_id=\(device_id)&device_token=\(device_token)&device_type=2"
           print("poststring",poststring)
           var request = NSMutableURLRequest(url: url as URL)
           request.httpMethod = "POST"
           request.httpBody = poststring.data(using: String.Encoding.utf8)
           let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
               
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
                       let message=parseJson["message"]as! String
                       if status==true{
                           let dataarray=parseJson["data"] as! NSDictionary
                           
                           
                           let user_id=dataarray["user_id"] as! String
                           let user_cat=dataarray["user_cat"] as! String
                           let user_name=dataarray["user_name"] as! String
                           let offer=dataarray["offer"] as! String
                           print("user_id",user_id)
                           let gst=dataarray["gst"] as! String
                           let useremail=dataarray["user_email"] as! String
                           let paymentstatus=dataarray["payment_status"] as! String
                           UserDefaults.standard.set(user_id, forKey:"useridorderhistory")
                           UserDefaults.standard.set("1", forKey:"typeorderhistory")
                           UserDefaults.standard.set(paymentstatus, forKey:"paymentstatus")
                           UserDefaults.standard.set(user_id, forKey:"userid")
                           UserDefaults.standard.set(user_cat, forKey:"usercatid")
                           UserDefaults.standard.set(user_name, forKey:"username")
                           UserDefaults.standard.set(gst, forKey:"usergst")
                           UserDefaults.standard.set(offer, forKey:"useroffer")
                           UserDefaults.standard.set(useremail, forKey:"useremail")
                           
                           DispatchQueue.main.async {
                              // self.hud.hide(animated: true)
//                               let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
//
//                               self.navigationController?.pushViewController(home, animated: true)
                           }
                           
                       }else{
                           DispatchQueue.main.async {
                               self.showToast(message: "Invalid OTP", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                               
                           }
                       }
                   }
                   
               }
               catch {
                   print(error)
               }
               
           }.resume()
       }
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
       // self.navigationController?.isNavigationBarHidden = false
        //self.navigationController?.navigationBar.isTranslucent = false
//        let height: CGFloat = 100//whatever height you want
//        let bounds = self.navigationController!.navigationBar.bounds
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.height)!, width: bounds.width, height:(UIApplication.shared.statusBarView?.frame.height)! + height)
    }
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        if let user_name=UserDefaults.standard.value(forKey: "username"){
        username=UserDefaults.standard.value(forKey: "username") as! String
            print("username",username)
        }
    }

     public func numberOfSections(in tableView: UITableView) -> Int
       {
        if roomactionflag==1{
            return 2
        }else{
           return 3
        }
         
       }
    
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if roomactionflag==1{
            if section==0{
                return 1
            }else{
                return 1
            }
        }else{
        if section==0{
            return 1
        }else if section==1{
            return imagearray.count
//            return 1
        }else{
            return 1
        }
        }
          }
    
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if roomactionflag==0{
           
            if indexPath.section==0{

                  dates = (tableView.dequeueReusableCell(withIdentifier: "BookyournightsTableViewCell", for: indexPath) as? BookyournightsTableViewCell)!
                dates.btncheckin.addTarget(self, action: #selector(btncheckin(sender:)), for: .touchUpInside)
                dates.btncheckout.addTarget(self, action: #selector(btncheckout(sender:)), for: .touchUpInside)
                dates.btnrooms.addTarget(self, action: #selector(btnrooms(sender:)), for: .touchUpInside)
                dates.btnguests.addTarget(self, action: #selector(btnrooms(sender:)), for: .touchUpInside)
                dates.btnsearch.addTarget(self, action: #selector(btnsearch(sender:)), for: .touchUpInside)
                dates.checkinday.text=currentday
                 dates.checkinweekday.text=myday
                 dates.checkinmonth.text=currentmonth
                 dates.checkinyear.text=currentyear
                 dates.checkoutday.text=nextday
                 dates.checkoutweekday.text=nextmyday
                 dates.checkoutmonth.text=nextmonth
                dates.checkoutyear.text=nextyear
                dates.lblname.text="Hi, "+username
                
                dates.lblroombooking.isHidden=true
                dates.lblbookyournigts.isHidden=false
                dates.btnsearch.isHidden=false
                dates.imageviewsearch.isHidden=false
                if childtempvaluearrayhome.count==0{
                   totalrooms=1
                    totaladult=1
                    totalchild=0
                    totalnumbers=1
                    dates.lbltotalrooms.text="01"
                    dates.lbltotaladult.text="1 Adult"
                     dates.lbltotalchild.text="0 Child"
                     dates.lbltotalnumbers.text="01"
                    
                    UserDefaults.standard.set([1], forKey: "roomnumbers")
                    UserDefaults.standard.set([1], forKey: "adultnumber")
                    UserDefaults.standard.set([0], forKey: "childnumber")
                    
                }else{
                    totalrooms=totalroomcuontarrayhome.count
                    dates.lbltotalrooms.text=String(totalrooms)
                    dates.lbltotaladult.text=String(totaladult)+" "+"Adult"
                    dates.lbltotalchild.text=String(totalchild)+" "+"Child"
                    dates.lbltotalnumbers.text=String(totaladult+totalchild)
                    UserDefaults.standard.set(adulttempvaluearrayhome, forKey: "adultnumber")
                    UserDefaults.standard.set(childtempvaluearrayhome, forKey: "childnumber")
                     UserDefaults.standard.set(totalroomcuontarrayhome, forKey: "roomnumbers")
                   
                }
               
                UserDefaults.standard.set(currentday, forKey: "checkinday")
                UserDefaults.standard.set(myday, forKey: "checkinweekday")
                UserDefaults.standard.set(currentmonth, forKey: "checkinmonth")
                UserDefaults.standard.set(currentyear, forKey: "checkinyear")
                UserDefaults.standard.set(nextday, forKey: "checkoutday")
                UserDefaults.standard.set(nextmyday, forKey: "checkoutweekday")
                UserDefaults.standard.set(nextmonth, forKey: "checkoutmonth")
                UserDefaults.standard.set(nextyear, forKey: "checkoutyear")
                UserDefaults.standard.set(totaladult+totalchild, forKey: "totalpeople")
                 UserDefaults.standard.set(totaladult, forKey: "totaladult")
                UserDefaults.standard.set(totalchild, forKey: "totalchild")
                UserDefaults.standard.set(applyflagfromroomguests, forKey: "applyflagroom")
                                                  
                                   let startDateString =   currentday+"."+currentmonth+"."+currentyear
                                    let endDateString = nextday+"."+nextmonth+"."+nextyear

                                           let formatter = DateFormatter()
                                           formatter.dateFormat = "dd.MM.yyyy"
                                   
                                    let startdate=formatter.date(from: startDateString)

                                         let endDate = formatter.date(from: endDateString)
                                    let components = Calendar.current.dateComponents([.day], from: startdate!, to: endDate!)
                                               print("Number of days: \(components.day!)")
                                    Total_no_of_days=Double(components.day!)
                                    print("Total_no_of_days",Total_no_of_days)
                UserDefaults.standard.set(Total_no_of_days, forKey: "totalnoofdays")
                
                  return dates

            }else if indexPath.section==1{
                 cousine = (tableView.dequeueReusableCell(withIdentifier: "WorldclasscouisineTableViewCell", for: indexPath) as? WorldclasscouisineTableViewCell)!
                if pooram_status=="0"{
                    cousine.imageviewheight.constant=0
                }else{
                     cousine.imageviewheight.constant=132
                 let url = URL(string:imagearray[indexPath.row])
                          cousine.imageviewpooram.kf.indicatorType = .activity
                          cousine.imageviewpooram.kf.setImage(with: url)
                
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gesture:)))
                cousine.imageviewpooram.addGestureRecognizer(tapGesture)
                cousine.imageviewpooram.isUserInteractionEnabled = true
                 
                }
                
                cousine.btntakeaway.addTarget(self, action: #selector(btntakeaway(sender:)), for: .touchUpInside)
                 cousine.btntablebooking.addTarget(self, action: #selector(btntablebooking(sender:)), for: .touchUpInside)
                 cousine.btnpartyorder.addTarget(self, action: #selector(btnpartyorder(sender:)), for: .touchUpInside)
                 cousine.btndoordelivery.addTarget(self, action: #selector(btndoordelivery(sender:)), for: .touchUpInside)
                return cousine

            }else{
                enquiry = (tableView.dequeueReusableCell(withIdentifier: "EnquiriesTableViewCell", for: indexPath) as? EnquiriesTableViewCell)!
                enquiry.btnbanquetenquiry.addTarget(self, action: #selector(btnbanquetenquiry), for: .touchUpInside)
                 enquiry.btncateringenquiry.addTarget(self, action: #selector(btncateringenquiry), for: .touchUpInside)
                 enquiry.btnpackageenquiry.addTarget(self, action: #selector(btnpackageenquiry), for: .touchUpInside)
                return enquiry
            }
        
            }else{
                if indexPath.section==0{
                    
                    dates = (tableView.dequeueReusableCell(withIdentifier: "BookyournightsTableViewCell", for: indexPath) as? BookyournightsTableViewCell)!
                    dates.btnsearch.isHidden=true
                    dates.imageviewsearch.isHidden=true
                    
                                   dates.btncheckin.addTarget(self, action: #selector(btncheckin(sender:)), for: .touchUpInside)
                                   dates.btncheckout.addTarget(self, action: #selector(btncheckout(sender:)), for: .touchUpInside)
                                   dates.btnrooms.addTarget(self, action: #selector(btnrooms(sender:)), for: .touchUpInside)
                                   dates.btnguests.addTarget(self, action: #selector(btnrooms(sender:)), for: .touchUpInside)
                                   dates.btnsearch.addTarget(self, action: #selector(btnsearch(sender:)), for: .touchUpInside)
                                   dates.checkinday.text=currentday
                                    dates.checkinweekday.text=myday
                                    dates.checkinmonth.text=currentmonth
                                    dates.checkinyear.text=currentyear
                                    dates.checkoutday.text=nextday
                                    dates.checkoutweekday.text=nextmyday
                                    dates.checkoutmonth.text=nextmonth
                                   dates.checkoutyear.text=nextyear
                                   dates.lblname.text="Welcome to Niya's"
                    dates.lblroombooking.isHidden=false
                    dates.lblbookyournigts.isHidden=true
                                   if childtempvaluearrayhome.count==0{
                                      totalrooms=1
                                       totaladult=1
                                       totalchild=0
                                       totalnumbers=1
                                       dates.lbltotalrooms.text="01"
                                       dates.lbltotaladult.text="1 Adult"
                                        dates.lbltotalchild.text="0 Child"
                                        dates.lbltotalnumbers.text="01"
                                       
                                       UserDefaults.standard.set([1], forKey: "roomnumbers")
                                       UserDefaults.standard.set([1], forKey: "adultnumber")
                                       UserDefaults.standard.set([0], forKey: "childnumber")
                                       
                                   }else{
                                       totalrooms=totalroomcuontarrayhome.count
                                       dates.lbltotalrooms.text=String(totalrooms)
                                       dates.lbltotaladult.text=String(totaladult)+" "+"Adult"
                                       dates.lbltotalchild.text=String(totalchild)+" "+"Child"
                                       dates.lbltotalnumbers.text=String(totaladult+totalchild)
                                       UserDefaults.standard.set(adulttempvaluearrayhome, forKey: "adultnumber")
                                       UserDefaults.standard.set(childtempvaluearrayhome, forKey: "childnumber")
                                        UserDefaults.standard.set(totalroomcuontarrayhome, forKey: "roomnumbers")
                                      
                                   }
                                  
                                   UserDefaults.standard.set(currentday, forKey: "checkinday")
                                   UserDefaults.standard.set(myday, forKey: "checkinweekday")
                                   UserDefaults.standard.set(currentmonth, forKey: "checkinmonth")
                                   UserDefaults.standard.set(currentyear, forKey: "checkinyear")
                                   UserDefaults.standard.set(nextday, forKey: "checkoutday")
                                   UserDefaults.standard.set(nextmyday, forKey: "checkoutweekday")
                                   UserDefaults.standard.set(nextmonth, forKey: "checkoutmonth")
                                   UserDefaults.standard.set(nextyear, forKey: "checkoutyear")
                                   UserDefaults.standard.set(totaladult+totalchild, forKey: "totalpeople")
                                    UserDefaults.standard.set(totaladult, forKey: "totaladult")
                                    UserDefaults.standard.set(totalchild, forKey: "totalchild")
                                    UserDefaults.standard.set(applyflagfromroomguests, forKey: "applyflagroom")
                                                                     
                                                      let startDateString =   currentday+"."+currentmonth+"."+currentyear
                                                       let endDateString = nextday+"."+nextmonth+"."+nextyear

                                                              let formatter = DateFormatter()
                                                              formatter.dateFormat = "dd.MM.yyyy"
                                                      
                                                       let startdate=formatter.date(from: startDateString)

                                                            let endDate = formatter.date(from: endDateString)
                                                       let components = Calendar.current.dateComponents([.day], from: startdate!, to: endDate!)
                                                                  print("Number of days: \(components.day!)")
                                                       Total_no_of_days=Double(components.day!)
                                                       print("Total_no_of_days",Total_no_of_days)
                                   UserDefaults.standard.set(Total_no_of_days, forKey: "totalnoofdays")
                                   
                                     return dates
                    
                    
                    
                    
                    
                    
                }else{
                    
                 roombuttonimage = (tableView.dequeueReusableCell(withIdentifier: "RoombuttonimageTableViewCell", for: indexPath) as? RoombuttonimageTableViewCell)!
                     roombuttonimage.btnroomimagesearch.addTarget(self, action: #selector(btnsearch(sender:)), for: .touchUpInside)
                    
//                    if roomactionflag==1{
//                        btnroom.image=UIImage(named:"Icon ionic-ios-bed-1")
//                               btnhome.setImage(UIImage(named:"Group 3-1"), for: .normal)
//                    }
                    
                    
                    return roombuttonimage
                    
                    
                }
                
                
                
                
            }
            }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if roomactionflag==1{
            if indexPath.section==0{
                 return 331
            }else{
                return 381
            }
        }else{
        if indexPath.section==0{
        return 331
        }else if indexPath.section==1{
            if pooram_status=="1"{
            return 342
        }else{
            return 210
            }
        }else{
            return 215
        }
        }
    }
    
    
    @objc func tapGesture(gesture: UIGestureRecognizer) {
      
         let popvc=self.storyboard?.instantiateViewController(withIdentifier: "BookpoorampopupViewController")as! BookpoorampopupViewController
//               let popvc=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "BookpoorampopupViewController")as BookpoorampopupViewController
                 
                
                 
                  present(popvc, animated: true, completion: nil)
               
        
                   }
    
    @objc func btnpackageenquiry(sender: UIButton){
            let packageenquiry = self.storyboard?.instantiateViewController (withIdentifier: "PackageenquiryViewController") as! PackageenquiryViewController
             self.navigationController?.pushViewController(packageenquiry, animated: true)
           
       }
    
     @objc func btnbanquetenquiry(sender: UIButton){
         let banquetenquiry = self.storyboard?.instantiateViewController (withIdentifier: "banquetenquiryViewController") as! banquetenquiryViewController
          self.navigationController?.pushViewController(banquetenquiry, animated: true)
        
    }
    
    @objc func btncateringenquiry(sender: UIButton){
            let cateringenquiry = self.storyboard?.instantiateViewController (withIdentifier: "CateringEnquiryViewController") as! CateringEnquiryViewController
             self.navigationController?.pushViewController(cateringenquiry, animated: true)
           
       }
    
    
     @objc func btnsearch(sender: UIButton){
       //  if let id=UserDefaults.standard.value(forKey: "userid"){
        let format = DateFormatter()
               format.dateFormat = "yyy-MM-dd"
               let startdate=currentyear+"-"+currentmonth+"-"+currentday
               let enddate=nextyear+"-"+nextmonth+"-"+nextday
               format.locale =  NSLocale(localeIdentifier: "en_US_POSIX") as Locale
               format.timeZone = TimeZone(secondsFromGMT: 0)
               let startformattedDate = format.date(from: startdate)
               let endformattedDate = format.date(from: enddate)
               let startdatestring = format.string(from: startformattedDate!)
               let enddatestring = format.string(from: endformattedDate!)
              print("startdatestring",startdatestring)
              print("enddatestring",enddatestring)
              print("totalrooms",totalrooms)
            let searchrooms = self.storyboard?.instantiateViewController (withIdentifier: "SearchroomsViewController") as! SearchroomsViewController
             searchrooms.startdate=startdatestring
            searchrooms.enddate=enddatestring
            searchrooms.roomcount=totalrooms
            searchrooms.totalnumbers=totaladult+totalchild
          searchrooms.roomflag=roomactionflag
            UserDefaults.standard.set(startdatestring, forKey: "startdate")
               UserDefaults.standard.set(enddatestring, forKey: "enddate")
               //UserDefaults.standard.set(totalrooms, forKey: "roomnumbers")
        UserDefaults.standard.removeObject(forKey:"roomavailablearry" )
           self.navigationController?.pushViewController(searchrooms, animated: true)

            }
    
    
    
    @objc func btncheckin(sender: UIButton){
//          if let id=UserDefaults.standard.value(forKey: "userid"){
        
        
        let dateselection = self.storyboard?.instantiateViewController (withIdentifier: "DateselectionViewController") as! DateselectionViewController
        
        dateselection.selectedday=dates.checkinday.text!
        dateselection.selectedmonth=dates.checkinmonth.text!
        dateselection.selectedyear=dates.checkinyear.text!
        dateselection.myday=dates.checkinweekday.text!
        dateselection.nextday=dates.checkoutday.text!
        dateselection.nextselectedmonth=dates.checkoutmonth.text!
        dateselection.nextselectedyear=dates.checkoutyear.text!
        dateselection.nextmyday=dates.checkoutweekday.text!
        
        dateselection.totalroomfromhome = totalrooms
        dateselection.totaladultfromhome = totaladult
        dateselection.totalchildfromhome = totalchild
        dateselection.childtempvaluearray = childtempvaluearrayhome
        dateselection.adulttempvaluaearray = adulttempvaluearrayhome
        dateselection.totalroomcountarray = totalroomcuontarrayhome
        dateselection.roomcountarraydateselection=roomcountarrayhome
        dateselection.applyflagfromroom=applyflagfromroomguests
        dateselection.applyflagfromdateselection=applyflag
        dateselection.roomflag=roomactionflag
       
        self.navigationController?.pushViewController(dateselection, animated: true)
//          }else{
//           let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//
//                                        let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
//                                        self.navigationController?.pushViewController(launch, animated: true)
//
//                                    }))
//
//                                    self.present(alert, animated: true)
//        }
    }
    
    @objc func btncheckout(sender: UIButton){
//         if let id=UserDefaults.standard.value(forKey: "userid"){
           let dateselection = self.storyboard?.instantiateViewController (withIdentifier: "DateselectionViewController") as! DateselectionViewController
             dateselection.checkoutflag=1
              dateselection.selectedday=dates.checkinday.text!
               dateselection.selectedmonth=dates.checkinmonth.text!
               dateselection.selectedyear=dates.checkinyear.text!
               dateselection.myday=dates.checkinweekday.text!
               dateselection.nextday=dates.checkoutday.text!
               dateselection.nextselectedmonth=dates.checkoutmonth.text!
               dateselection.nextselectedyear=dates.checkoutyear.text!
               dateselection.nextmyday=dates.checkoutweekday.text!
        
             dateselection.totalroomfromhome = totalrooms
               dateselection.totaladultfromhome = totaladult
               dateselection.totalchildfromhome = totalchild
             dateselection.childtempvaluearray = childtempvaluearrayhome
            dateselection.adulttempvaluaearray = adulttempvaluearrayhome
            dateselection.totalroomcountarray = totalroomcuontarrayhome
          dateselection.roomcountarraydateselection=roomcountarrayhome
            dateselection.applyflagfromroom=applyflagfromroomguests
          dateselection.applyflagfromdateselection=applyflag
          dateselection.roomflag=roomactionflag
           self.navigationController?.pushViewController(dateselection, animated: true)
//    }else{
//
//    let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//
//                                let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
//                                self.navigationController?.pushViewController(launch, animated: true)
//
//                            }))
//
//                            self.present(alert, animated: true)
//    }
       }
    
    @objc func btnrooms(sender: UIButton){
//          if let id=UserDefaults.standard.value(forKey: "userid"){
        
        
         let roomselection = self.storyboard?.instantiateViewController (withIdentifier: "RoomSelectionViewController") as! RoomSelectionViewController
        roomselection.applyflagroom=applyflagfromroomguests
        roomselection.childtempvaluearray=childtempvaluearrayhome
        
        roomselection.adulttempvaluearray=adulttempvaluearrayhome
        roomselection.totalroomcuontarray=totalroomcuontarrayhome
        roomselection.addonemoreroomflag=addonemoreflaghome
        roomselection.roomcountarray=roomcountarrayhome
        roomselection.applyflagfromdateselection=applyflag
        roomselection.checkinday=dates.checkinday.text!
        roomselection.checkinyear=dates.checkinyear.text!
        roomselection.checkinmonth=dates.checkinmonth.text!
        roomselection.checkinweekday=dates.checkinweekday.text!
        roomselection.checkoutday=dates.checkoutday.text!
        roomselection.checkoutyear=dates.checkoutyear.text!
        roomselection.checkoutmonth=dates.checkoutmonth.text!
        roomselection.checkoutweekday=dates.checkoutweekday.text!
       // roomselection.childtempvaluearray=childtempvaluearrayhome
        roomselection.roomflag=roomactionflag
         self.navigationController?.pushViewController(roomselection, animated: true)
//          }else{
//
//             let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//
//                                        let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
//                                        self.navigationController?.pushViewController(launch, animated: true)
//
//                                    }))
//
//                                    self.present(alert, animated: true)
//
//
//        }
    }
    
     @objc func btntakeaway(sender: UIButton){
//         if let id=UserDefaults.standard.value(forKey: "userid"){
        self.revealViewController().rightRevealToggle(animated: false)
     foodtype=4
       
       
     showpopup()
//         }else{
//            
//            let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
//                       alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//                       
//                                                   let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
//                                                   self.navigationController?.pushViewController(launch, animated: true)
//                       
//                                               }))
//                       
//                                               self.present(alert, animated: true)
//            
//            
//            
//        }
        
        
    }
    @objc func btntablebooking(sender: UIButton){
//         if let id=UserDefaults.standard.value(forKey: "userid"){
           
           foodtype=3
             
           showpopup()
//         }else{
//
//            let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//
//                                        let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
//                                        self.navigationController?.pushViewController(launch, animated: true)
//
//                                    }))
//
//                                    self.present(alert, animated: true)
//
//        }
              
           
           
       }
    @objc func btnpartyorder(sender: UIButton){
//         if let id=UserDefaults.standard.value(forKey: "userid"){
           
         foodtype=2
             
           showpopup()
//         }else{
//            let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
//                       alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//                       
//                                                   let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
//                                                   self.navigationController?.pushViewController(launch, animated: true)
//                       
//                                               }))
//                       
//                                               self.present(alert, animated: true)
//        }
       
       }
    
    @objc func btndoordelivery(sender: UIButton){
//         if let id=UserDefaults.standard.value(forKey: "userid"){
           
          foodtype=1
       
            self.showpopup()
       
//         }else{
//
//            let alert = UIAlertController(title: "", message: "Please login to continue " , preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//
//                                        let launch = self.storyboard?.instantiateViewController (withIdentifier: "LaunchscreenViewController") as! LaunchscreenViewController
//                                        self.navigationController?.pushViewController(launch, animated: true)
//
//                                    }))
//
//                                    self.present(alert, animated: true)
//
//        }
              
           
           
       }
    func showpopup(){
       // self.definesPresentationContext=true
        
       let takeawaypopvc = self.storyboard?.instantiateViewController (withIdentifier: "TakeawaypopupViewController") as! TakeawaypopupViewController
          
                  takeawaypopvc.modalPresentationStyle = .overCurrentContext
                  takeawaypopvc.modalTransitionStyle = .crossDissolve
                  takeawaypopvc.foodtype=foodtype
        
                  UserDefaults.standard.set(foodtype, forKey: "foodtype")
                  self.navigationController?.present(takeawaypopvc, animated: true,completion: nil)
    }
    
    
    func service_dashboard(){
//        self.showhud()
           guard let url=NSURL(string :"https://niyaregency.com/api/Data/dashboard")else{return}
               let poststring="security_token=niya32jfhdu392nfbfdr"
                      var request = NSMutableURLRequest(url: url as URL)
                      request.httpMethod = "POST"
                      request.httpBody = poststring.data(using: String.Encoding.utf8)
                      let task=URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
              
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
                            let image=parseJson["image"]as! String
                                self.pooram_status=parseJson["pooram_status"] as! String
                                self.imagearray.append(image)
                                print("imagearray",self.imagearray)
                                DispatchQueue.main.async {
//                                    self.hud.hide(animated: true)
                                    self.tableviewhomepage.reloadData()
                                }
                            
                            }
                                           
                                                  
                          }
                          catch {
                            print(error)
                            }
                                                                                                 
                                                          }.resume()
                                                      }
                                      

    @IBAction func btnfoodaction(_ sender: Any) {
        
        
        let food = self.storyboard?.instantiateViewController (withIdentifier: "FoodViewController") as! FoodViewController
                  roomactionflag=0
               
                  self.navigationController?.pushViewController(food, animated: true)
        
    }
    
    @IBAction func btnenquiryaction(_ sender: Any) {
        
        let enquiry = self.storyboard?.instantiateViewController (withIdentifier: "EnquiryViewController") as! EnquiryViewController
                         roomactionflag=0
                      
                         self.navigationController?.pushViewController(enquiry, animated: true)
               
        
    }
    
    @IBAction func btnroomaction(_ sender: Any) {
        roomactionflag=1
        btnroom.setImage(UIImage(named:"Group 4-1"), for: .normal)
        btnhome.setImage(UIImage(named:"Group 3-1"), for: .normal)
        tableviewhomepage.reloadData()
        
        
    }
    
    @IBAction func btnhomeaction(_ sender: Any) {
        roomactionflag=0
        btnroom.setImage(UIImage(named:"Group 4"), for: .normal)
        btnhome.setImage(UIImage(named:"Group 3"), for: .normal)
        tableviewhomepage.reloadData()
        
    }
    func showhud(){
    hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.mode = MBProgressHUDMode.indeterminate
    }
    
    
}
