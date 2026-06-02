//
//  TakeawaypopupViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 23/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import FSCalendar
import GoogleMaps
import GooglePlaces
import MapKit
import MBProgressHUD




@available(iOS 13.0, *)
@available(iOS 13.0, *)
class TakeawaypopupViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,mapdelegate,passfortakeaway {
    
    @IBOutlet weak var viewsettime: UIView!
    @IBOutlet weak var txtfldampm: UITextField!
    @IBOutlet weak var txtfldmin: UITextField!
    @IBOutlet weak var txtfldhr: UITextField!
    @IBOutlet weak var viewforsettingtime: UIView!
    @IBOutlet weak var lblpartyorderchangelocation: UILabel!
    @IBOutlet weak var lblpartyorderwedontdeliver: UILabel!
    @IBOutlet weak var lblpartyorderlocation: UILabel!
    
    @IBOutlet weak var btntakeawaytimeselector: UIButton!
    
    @IBOutlet weak var lbldeliverylimitpartyorder: UILabel!
    @IBOutlet weak var heightdoordeliverychangelocation: NSLayoutConstraint!
    @IBOutlet weak var heightdoordeliverywedontdeliver: NSLayoutConstraint!
    @IBOutlet weak var lbldoordeliverylocation: UILabel!
    @IBOutlet weak var hightchangelocation: NSLayoutConstraint!
    @IBOutlet weak var heightdontdeliver: NSLayoutConstraint!
    @IBOutlet weak var btntakeawaydateselector: UIButton!
    @IBOutlet weak var viewtablebookingdateselector: UIView!
    @IBOutlet weak var viewdatetimeselector: UIView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var viewpopupcalendar: UIView!
    @IBOutlet weak var btntimeselector: UIButton!
    @IBOutlet weak var btndateselector: UIButton!
    @IBOutlet weak var lblmonthday: UILabel!
    @IBOutlet weak var txtfldnoofpeople: UITextField!
    
    @IBOutlet weak var btnpartorderdateselector: UIButton!
    @IBOutlet weak var viewpartyorderdatetimeselector: UIView!
    
    @IBOutlet weak var txtfldpartyoredernoofpeople: UITextField!
    @IBOutlet weak var btnpartyordertimeselector: UIButton!
    
    @IBOutlet weak var viewdoordelivery: UIView!
    
    @IBOutlet weak var btndoordeliverydateselector: UIButton!
    
    @IBOutlet weak var btndoordeliverytimeselector: UIButton!
    
    @IBOutlet weak var mapview: GMSMapView!
    
    @IBOutlet weak var btndoordeliverychange: UIButton!
    var latitude=CLLocationDegrees()
    var longitude=CLLocationDegrees()
    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var btnreordernotavailable: UIButton!
    @IBOutlet weak var lblnotavailableproductname: UILabel!
    @IBOutlet weak var btncancelnotavailable: UIButton!
    @IBOutlet weak var viewreorderitemnotavailable: UIView!
    @IBOutlet weak var viewreorederitemavailable: UIView!
    @IBOutlet weak var btnreordersubmitt: UIButton!
    @IBOutlet weak var btnreordercancel: UIButton!
    
    @IBOutlet weak var viewreorderconfirmation: UIView!
    @IBOutlet weak var lblchangelocation: UILabel!
    var dismissViewTap: UITapGestureRecognizer!
    
    var formattedDate=String()
    @IBOutlet weak var lblwedontdeliver: UILabel!
    
    
    @IBOutlet weak var viewforampmselection: UIView!
    @IBOutlet weak var btntoshowampm: UIButton!
    
    @IBOutlet weak var lbldoordeliverydistance: UILabel!
    var myday=String()
    var timeflag=Int()
    var foodtype=Int()
    var dateselected=String()
    var timeselected=String()
    var lat=CLLocationDegrees()
    var long=CLLocationDegrees()
    var address=String()
    var placeaddress=String()
    var currentAddress=String()
    var hud:MBProgressHUD!
    var changelocationflag=Int()
    var addressfrommap=String()
    
    var time=Int()
     var timepartyorder=Int()
    var timetablebooking=Int()
     var timetakeaway=Int()
    var nextdatedoordelivery=Date()
    var datefordoordelivery=String()
    var nextdatepartyorder=Date()
    var dateforpartyorder=String()
    var reorderflag=Int()
    var orderid=String()
    var reorderproductsarray=[[String:String]]()
    var myarray=[[String:String]]()
    var cartprice=Int()
    var numberlimitablebooking=Int()
    var nextdatetablebooking=Date()
    var datefortablebooking=String()
    var nextdatetakeaway=Date()
    var datefortakeaway=String()
    var doordeliverystarttime=Date()
    var doordeliveryend=Date()
    var partorderstarttime=Date()
    var partorderend=Date()
    var tablebookingstarttime=Date()
    var tablebookingendtime=Date()
    var takeawaystarttime=Date()
    var takeawayendtime=Date()
    var people=Int()
    
    
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        self.showhud()
        // 1
        let geocoder = GMSGeocoder()
        print("coordinate",coordinate)
        latitude=coordinate.latitude
        longitude=coordinate.longitude
        UserDefaults.standard.set(lat, forKey: "latitude")
        UserDefaults.standard.set(long, forKey: "longitude")
        print("latitude",latitude)
        print("longitude",longitude)
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            // 3
            print(lines.joined(separator: "\n"))
            
            self.lbldoordeliverylocation.text=lines.joined(separator: "\n")
            self.lblpartyorderlocation.text=lines.joined(separator: "\n")
            UserDefaults.standard.set(lines.joined(separator: "\n"), forKey: "mapaddress")
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
        self.hud.hide(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(foodtype)
        print(addressfrommap)
        if changelocationflag==1{
            
        }else{
            locationupdate()
        }
        
        //        locationManager.delegate = self
        //        locationManager.requestWhenInUseAuthorization()
        //
        //        mapview.delegate=self
        //        mapview.isHidden=false
        //
        ////        mapview.camera=GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 9.582912, longitude: 76.547326), zoom: 15, bearing: 0, viewingAngle: 0)
        //
        //        mapview.delegate = self
        //        mapview.isMyLocationEnabled = true
        //        mapview.settings.zoomGestures   = true
        heightdontdeliver.constant=0
        hightchangelocation.constant=0
        heightdoordeliverychangelocation.constant=0
        heightdoordeliverywedontdeliver.constant=0
        lblwedontdeliver.isHidden=true
        lblchangelocation.isHidden=true
        lblpartyorderwedontdeliver.isHidden=true
        lblpartyorderchangelocation.isHidden=true
        
        btntimeselector.layer.cornerRadius=10
        btntimeselector.layer.borderWidth=2
        btntimeselector.layer.borderColor = UIColor.lightGray.cgColor
        btndateselector.layer.cornerRadius=10
        btndateselector.layer.borderWidth=2
        btndateselector.layer.borderColor = UIColor.lightGray.cgColor
        txtfldnoofpeople.layer.cornerRadius=10
        txtfldnoofpeople.layer.borderWidth=2
        txtfldnoofpeople.layer.borderColor = UIColor.lightGray.cgColor
        btntakeawaydateselector.layer.cornerRadius=10
        btntakeawaydateselector.layer.borderWidth=2
        btntakeawaydateselector.layer.borderColor = UIColor.lightGray.cgColor
        btntakeawaytimeselector.layer.cornerRadius=10
        btntakeawaytimeselector.layer.borderWidth=2
        btntakeawaytimeselector.layer.borderColor = UIColor.lightGray.cgColor
        btnpartorderdateselector.layer.cornerRadius=10
        btnpartorderdateselector.layer.borderWidth=2
        btnpartorderdateselector.layer.borderColor = UIColor.lightGray.cgColor
        btnpartyordertimeselector.layer.cornerRadius=10
        btnpartyordertimeselector.layer.borderWidth=2
        btnpartyordertimeselector.layer.borderColor = UIColor.lightGray.cgColor
        
        txtfldpartyoredernoofpeople.layer.cornerRadius=10
        txtfldpartyoredernoofpeople.layer.borderWidth=2
        txtfldpartyoredernoofpeople.layer.borderColor = UIColor.lightGray.cgColor
        
        btndoordeliverydateselector.layer.cornerRadius=10
        btndoordeliverydateselector.layer.borderWidth=2
        btndoordeliverydateselector.layer.borderColor = UIColor.lightGray.cgColor
        btndoordeliverytimeselector.layer.cornerRadius=10
        btndoordeliverytimeselector.layer.borderWidth=2
        btndoordeliverytimeselector.layer.borderColor = UIColor.lightGray.cgColor
        
        
        btndoordeliverychange.layer.cornerRadius=10
        
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        calendar.delegate=self
        calendar.dataSource=self
        
        
        
        if foodtype==4{
            viewpartyorderdatetimeselector.isHidden=true
            viewtablebookingdateselector.isHidden=true
            viewdatetimeselector.isHidden=false
            viewdoordelivery.isHidden=true
        }else if foodtype==3{
            viewpartyorderdatetimeselector.isHidden=true
            viewtablebookingdateselector.isHidden=false
            viewdatetimeselector.isHidden=true
            viewdoordelivery.isHidden=true
        }else if foodtype==2{
            
            viewpartyorderdatetimeselector.isHidden=false
            viewtablebookingdateselector.isHidden=true
            viewdatetimeselector.isHidden=true
            viewdoordelivery.isHidden=true
        }else if foodtype==1{
            viewpartyorderdatetimeselector.isHidden=true
            viewtablebookingdateselector.isHidden=true
            viewdatetimeselector.isHidden=true
            viewdoordelivery.isHidden=false
            
        }
        
        
        
        
        let today_date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyy"
        format.timeZone = .current
        
        // let date = today_date.addingTimeInterval(20.0 * 60.0)
        // print ("date",date)
        formattedDate = format.string(from: today_date)
        dateselected=formattedDate
        btndateselector.setTitle(dateselected, for: .normal)
        btnpartorderdateselector.setTitle(dateselected, for: .normal)
        btntakeawaydateselector.setTitle(dateselected, for: .normal)
        // btndoordeliverydateselector.setTitle(dateselected, for: .normal)
        
        let timeformatter=DateFormatter()
        timeformatter.dateFormat="hh:mm a"
        timeformatter.timeZone = .current
        let formattedtime = timeformatter.string(from: today_date)
        timeselected=formattedtime
        print("timeselected",timeselected)
        
        btntimeselector.setTitle(timeselected, for: .normal)
        btnpartyordertimeselector.setTitle(timeselected, for: .normal)
        btntakeawaytimeselector.setTitle(timeselected, for: .normal)
        btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
        btnreordercancel.layer.cornerRadius=10
        btnreordercancel.layer.borderWidth=1
        
        btnreordercancel.layer.borderColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0).cgColor
        
        btnreordersubmitt.layer.cornerRadius=10
        btnreordersubmitt.layer.borderWidth=1
        
        btnreordersubmitt.layer.borderColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0).cgColor
        
        viewreorderitemnotavailable.layer.cornerRadius=10
        viewreorederitemavailable.layer.cornerRadius=10
        
        
        
        btncancelnotavailable.layer.cornerRadius=10
        btncancelnotavailable.layer.borderWidth=1
        
        btncancelnotavailable.layer.borderColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0).cgColor
        
        btnreordernotavailable.layer.cornerRadius=10
        btnreordernotavailable.layer.borderWidth=1
        
        btnreordernotavailable.layer.borderColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0).cgColor
        
        
        // service_getsrollbarcategories()
        
        UserDefaults.standard.removeObject(forKey: "partyorderarray")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        hideKeyboardWhenTappedAround()
        
        
        viewforampmselection.isHidden=true
        lblwedontdeliver.isHidden=true
        lblchangelocation.isHidden=true
        heightdoordeliverychangelocation.constant=0
        heightdoordeliverywedontdeliver.constant=0
        service_food_time()
        
        service_Data_table()
        
        //                                     dismissViewTap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        //                                     view.addGestureRecognizer(dismissViewTap)
        
        
        
        
        
    }
    
    func mapdatas(lat: CLLocationDegrees, long: CLLocationDegrees, mapaddress: String, changelocationflag: Int) {
        print("lat",lat)
        print("mapaddress",mapaddress)
        lblwedontdeliver.isHidden=true
        lblchangelocation.isHidden=true
        lblpartyorderwedontdeliver.isHidden=true
        lblpartyorderchangelocation.isHidden=true
        if changelocationflag==1{
            self.lbldoordeliverylocation.text=mapaddress
            self.lblpartyorderlocation.text=mapaddress
            latitude=lat
            longitude=long
            UserDefaults.standard.set(lat, forKey: "latitude")
            UserDefaults.standard.set(long, forKey: "longitude")
            UserDefaults.standard.set(mapaddress, forKey: "mapaddress")
        }
        
    }
    
    func locationupdate(){
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapview.delegate=self
        mapview.isHidden=false
        
        //        mapview.camera=GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 9.582912, longitude: 76.547326), zoom: 15, bearing: 0, viewingAngle: 0)
        
        mapview.delegate = self
        mapview.isMyLocationEnabled = true
        mapview.settings.zoomGestures   = true
        
        
    }
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btntapped(_ sender: Any) {
        dismissView()
    }
    
    
    
    
    @IBAction func btndateselectoraction(_ sender: Any) {
        timeflag=0
        showCalendar()
        //        viewpopupcalendar.isHidden=false
        //        viewpopupcalendar.layer.cornerRadius=5
        //        viewpopupcalendar.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        //        viewpopupcalendar.layer.shadowRadius = 5.0
        //        viewpopupcalendar.layer.shadowOpacity = 0.1
        //        lblmonthday.text=myday+" , "+month+" "+year
        //        viewdatetimeselector.backgroundColor=UIColor.black.withAlphaComponent(0.4)
        //        btntimeselector.backgroundColor=UIColor.black.withAlphaComponent(0.4)
        //        btndateselector.backgroundColor=UIColor.black.withAlphaComponent(0.4)
        //        btntimeselector.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        //        btndateselector.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
    }
    
    @IBAction func btncancelaction(_ sender: Any) {
        viewpopupcalendar.isHidden=true
        viewdatetimeselector.backgroundColor=UIColor.white
        btntimeselector.backgroundColor=UIColor.white
        btndateselector.backgroundColor=UIColor.white
        btntimeselector.layer.borderColor = UIColor.lightGray.cgColor
        btndateselector.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func btnokaction(_ sender: Any) {
        viewpopupcalendar.isHidden=true
        btndateselector.setTitle(formattedDate, for: .normal)
        btnpartorderdateselector.setTitle(formattedDate, for: .normal)
        viewdatetimeselector.backgroundColor=UIColor.white
        btntimeselector.backgroundColor=UIColor.white
        btndateselector.backgroundColor=UIColor.white
        btntimeselector.layer.borderColor = UIColor.lightGray.cgColor
        btndateselector.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func btntimeselectoraction(_ sender: Any) {
        timeflag=1
        
        showCalendar()
        
        
    }
    
    
    func showCalendar() {
        
        let selector = WWCalendarTimeSelector.instantiate()
        selector.delegate = self
        selector.delegate1=self
        if timeflag==1{
            selector.optionStyles.showTime(true)
            selector.optionStyles.showYear(false)
            selector.optionStyles.showMonth(false)
            selector.optionStyles.showDateMonth(false)
            
        }else{
            selector.optionStyles.showTime(false)
            selector.optionStyles.showYear(true)
            selector.optionStyles.showMonth(true)
            selector.optionStyles.showDateMonth(true)
            
        }
        selector.flag=timeflag
        selector.food_type=foodtype
        present(selector, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func btncontinuetablebooking(_ sender: Any) {
            
            if txtfldnoofpeople.text==""||txtfldnoofpeople.text==nil{
                self.showToast(message: "Enter no of people", font: UIFont.boldSystemFont(ofSize: 14), duration: 10)
                
                
            }else{
                let noofpeople=txtfldnoofpeople.text
                let  people=Int(noofpeople!)
                if people!>numberlimitablebooking{
                    self.showToast(message: "Number of people should be less than \(numberlimitablebooking)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                }else{
                    timeflag=2
                    continueaction()
                }
            }
        }
        
        
        func tablebookingcontinue(){
            
            let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
            
            productlisting.activityid=foodtype+1
            productlisting.food_type=foodtype
            UserDefaults.standard.set(foodtype, forKey: "activity")
            UserDefaults.standard.set(dateselected, forKey: "start_datedoordelivery")
            UserDefaults.standard.set(timeselected, forKey: "start_timedoordelivery")
            UserDefaults.standard.set(txtfldnoofpeople.text,forKey: "partyorderpeoplenumbers")
            
            
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
            
            UserDefaults.standard.removeObject(forKey: "minprice")
            UserDefaults.standard.removeObject(forKey: "selecteditemsinpartyorder")
            UserDefaults.standard.removeObject(forKey: "cartDetails")
            UserDefaults.standard.removeObject(forKey: "doordeliveryproductArray")
            UserDefaults.standard.removeObject(forKey: "doordeliveryproductArrayvegonly")
            UserDefaults.standard.removeObject(forKey: "doordeliverysearchArray")
            UserDefaults.standard.removeObject(forKey: "search_items")
            UserDefaults.standard.removeObject(forKey: "productidarrayselected")
            UserDefaults.standard.removeObject(forKey: "partyorderselectedarray")
            UserDefaults.standard.removeObject(forKey: "idforpartyorder")
            UserDefaults.standard.removeObject(forKey: "listforpartyorder")
            UserDefaults.standard.removeObject(forKey: "mainmenunamepartyorder")
            UserDefaults.standard.removeObject(forKey: "addedidtocart")
            let navController = UINavigationController(rootViewController: productlisting)
            
            self.present(navController, animated: true)
            
        }
        
        
        
        
        
        
        @IBAction func btncontinueaction(_ sender: Any) {
            timeflag=2
            continueaction()
        }
        
        
        func takeawaycontinue(){
            let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
            
            productlisting.activityid=foodtype+1
            productlisting.food_type=foodtype
            UserDefaults.standard.set(foodtype, forKey: "activity")
            UserDefaults.standard.set(dateselected, forKey: "start_datedoordelivery")
            UserDefaults.standard.set(timeselected, forKey: "start_timedoordelivery")
            UserDefaults.standard.set(txtfldnoofpeople.text,forKey: "partyorderpeoplenumbers")
            
            
            
            UserDefaults.standard.removeObject(forKey: "myarray")
            UserDefaults.standard.removeObject(forKey: "carttotalprice")
            UserDefaults.standard.removeObject(forKey: "partyorderarray")
            
            UserDefaults.standard.removeObject(forKey: "itemsubids")
            UserDefaults.standard.removeObject(forKey: "mainmenuitemarraycart")
            UserDefaults.standard.removeObject(forKey: "partyinsertarray")
            UserDefaults.standard.removeObject(forKey: "itemsubids")
            UserDefaults.standard.removeObject(forKey: "menutoken")
            UserDefaults.standard.removeObject(forKey: "subidarrayback")
            
            UserDefaults.standard.removeObject(forKey: "partyinsertarray")
            UserDefaults.standard.removeObject(forKey: "partyinsertmenulistdictionary")
            UserDefaults.standard.removeObject(forKey: "maindictionarypartyinsert")
            // UserDefaults.standard.removeObject(forKey: "nonvegitemarray")
            
            UserDefaults.standard.removeObject(forKey: "minprice")
            UserDefaults.standard.removeObject(forKey: "selecteditemsinpartyorder")
            UserDefaults.standard.removeObject(forKey: "cartDetails")
            UserDefaults.standard.removeObject(forKey: "doordeliveryproductArray")
            UserDefaults.standard.removeObject(forKey: "doordeliveryproductArrayvegonly")
            UserDefaults.standard.removeObject(forKey: "doordeliverysearchArray")
            UserDefaults.standard.removeObject(forKey: "search_items")
            UserDefaults.standard.removeObject(forKey: "productidarrayselected")
            UserDefaults.standard.removeObject(forKey: "partyorderselectedarray")
            UserDefaults.standard.removeObject(forKey: "idforpartyorder")
            UserDefaults.standard.removeObject(forKey: "listforpartyorder")
            UserDefaults.standard.removeObject(forKey: "mainmenunamepartyorder")
            UserDefaults.standard.removeObject(forKey: "addedidtocart")
            let navController = UINavigationController(rootViewController: productlisting)
            
            self.present(navController, animated: true)
        }
        
        @IBAction func btnpartordercontinue(_ sender: Any) {
            
            if txtfldpartyoredernoofpeople.text==""||txtfldpartyoredernoofpeople.text==nil{
                self.showToast(message: "Enter no of people", font: UIFont.boldSystemFont(ofSize: 14), duration: 10)
            }else  {
                let noofpeople=txtfldpartyoredernoofpeople.text
                people=(noofpeople as! NSString).integerValue
                if people<10{
                    self.showToast(message: "Min 10 numbers", font: UIFont.boldSystemFont(ofSize: 14), duration: 10)
                }else{
                    UserDefaults.standard.set(txtfldpartyoredernoofpeople.text,forKey: "partyorderpeoplenumbers")
                    timeflag=2
                    continueaction()
                    
                }
            }
            
        }
        
        func partyordercontinue(){
            
            service_party_order()
            
            UserDefaults.standard.set(foodtype, forKey: "activity")
            UserDefaults.standard.set(dateselected, forKey: "start_datedoordelivery")
            UserDefaults.standard.set(timeselected, forKey: "start_timedoordelivery")
            
            UserDefaults.standard.removeObject(forKey: "myarray")
            UserDefaults.standard.removeObject(forKey: "carttotalprice")
            UserDefaults.standard.removeObject(forKey: "partyorderarray")
            
            UserDefaults.standard.removeObject(forKey: "itemsubids")
            UserDefaults.standard.removeObject(forKey: "mainmenuitemarraycart")
            UserDefaults.standard.removeObject(forKey: "partyinsertarray")
            UserDefaults.standard.removeObject(forKey: "itemsubids")
            UserDefaults.standard.removeObject(forKey: "menutoken")
            UserDefaults.standard.removeObject(forKey: "subidarrayback")
            
            
            UserDefaults.standard.removeObject(forKey: "partyinsertarray")
            UserDefaults.standard.removeObject(forKey: "partyinsertmenulistdictionary")
            UserDefaults.standard.removeObject(forKey: "maindictionarypartyinsert")
            UserDefaults.standard.removeObject(forKey: "selecteditemsinpartyorder")
            UserDefaults.standard.removeObject(forKey: "cartDetails")
            UserDefaults.standard.removeObject(forKey: "doordeliveryproductArray")
            UserDefaults.standard.removeObject(forKey: "doordeliveryproductArrayvegonly")
            UserDefaults.standard.removeObject(forKey: "doordeliverysearchArray")
            UserDefaults.standard.removeObject(forKey: "search_items")
            UserDefaults.standard.removeObject(forKey: "productidarrayselected")
            
            UserDefaults.standard.removeObject(forKey: "partyorderselectedarray")
            UserDefaults.standard.removeObject(forKey: "idforpartyorder")
            UserDefaults.standard.removeObject(forKey: "listforpartyorder")
            UserDefaults.standard.removeObject(forKey: "mainmenunamepartyorder")
            UserDefaults.standard.set(nil,forKey: "addedidtocart")
            
        }
        
        
        @IBAction func btncontinueactiondoordelivery(_ sender: Any) {
            timeflag=2
            continueaction()
        }
        
        func doordeliverycontinue(){
            
            UserDefaults.standard.set(foodtype, forKey: "activity")
            UserDefaults.standard.set(dateselected, forKey: "start_datedoordelivery")
            UserDefaults.standard.set(timeselected, forKey: "start_timedoordelivery")
            
            
            UserDefaults.standard.removeObject(forKey: "myarray")
            UserDefaults.standard.removeObject(forKey: "carttotalprice")
            UserDefaults.standard.removeObject(forKey: "partyorderarray")
            
            UserDefaults.standard.removeObject(forKey: "itemsubids")
            UserDefaults.standard.removeObject(forKey: "mainmenuitemarraycart")
            UserDefaults.standard.removeObject(forKey: "partyinsertarray")
            UserDefaults.standard.removeObject(forKey: "itemsubids")
            UserDefaults.standard.removeObject(forKey: "menutoken")
            UserDefaults.standard.removeObject(forKey: "subidarrayback")
            
            
            UserDefaults.standard.removeObject(forKey: "partyinsertarray")
            UserDefaults.standard.removeObject(forKey: "partyinsertmenulistdictionary")
            UserDefaults.standard.removeObject(forKey: "maindictionarypartyinsert")
            //                         UserDefaults.standard.removeObject(forKey: "nonvegitemarray")
            UserDefaults.standard.removeObject(forKey: "selecteditemsinpartyorder")
            UserDefaults.standard.removeObject(forKey: "cartDetails")
            UserDefaults.standard.removeObject(forKey: "doordeliveryproductArray")
            UserDefaults.standard.removeObject(forKey: "doordeliveryproductArrayvegonly")
            UserDefaults.standard.removeObject(forKey: "doordeliverysearchArray")
            UserDefaults.standard.removeObject(forKey: "search_items")
            UserDefaults.standard.removeObject(forKey: "productidarrayselected")
            UserDefaults.standard.removeObject(forKey: "partyorderselectedarray")
            UserDefaults.standard.removeObject(forKey: "idforpartyorder")
            UserDefaults.standard.removeObject(forKey: "listforpartyorder")
            UserDefaults.standard.removeObject(forKey: "mainmenunamepartyorder")
            UserDefaults.standard.removeObject(forKey: "addedidtocart")
            if reorderflag==1{
                service_re_door_delivery()
            }else{
                service_door_delivery()
                
            }
            
        }
        
        
        func continueaction(){
            var result: ComparisonResult? = nil
            var result1: ComparisonResult? = nil
            var result2: ComparisonResult? = nil
            var formatteddate1=Date()
            var formattedDatetime=String()
            var doorstarttime=String()
            var doorendtime=String()
            var partstarttime=String()
            var partendtime=String()
            var tablestarttime=String()
            var tableendtime=String()
            var takestarttime=String()
            var takeendtime=String()
            
            
            let today_date = Date()
            let dateformat = DateFormatter()
            dateformat.dateFormat = "h:mm a"
            dateformat.timeZone = .current
            if foodtype==1{
                formattedDatetime = dateformat.string(from: nextdatedoordelivery)
                doorstarttime=dateformat.string(from: doordeliverystarttime)
                doorendtime=dateformat.string(from: doordeliveryend)
            }else if foodtype==2{
                formattedDatetime = dateformat.string(from: nextdatepartyorder)
                partstarttime=dateformat.string(from: partorderstarttime)
                partendtime=dateformat.string(from: partorderend)
            }else if foodtype==3{
                formattedDatetime = dateformat.string(from: nextdatetablebooking)
                tablestarttime=dateformat.string(from: tablebookingstarttime)
                tableendtime=dateformat.string(from: tablebookingendtime)
            }else if foodtype==4{
                formattedDatetime = dateformat.string(from: nextdatetakeaway)
                takestarttime=dateformat.string(from: takeawaystarttime)
                takeendtime=dateformat.string(from: takeawayendtime)
            }
                
            else{
                formattedDatetime = dateformat.string(from: today_date)
            }
            formatteddate1=dateformat.date(from: formattedDatetime)!
            let timeselectedcompare=dateformat.date(from: timeselected)
            print("timeselected",timeselected)
            print("formatteddate1",formatteddate1)
            print("timeselectedcompare",timeselectedcompare)
            print("today_date",today_date)
            
            print("dateselected",dateselected)
            
            result = formatteddate1.compare(timeselectedcompare!)
            
            var format = DateFormatter()
            format.dateFormat = "hh:mm a"
            let value=format.date(from: timeselected)
            format.dateFormat = "HH:mm:ss"
            format.timeZone = .current
            let timeselectedfor = format.string(from: value!)
            let datefortime=format.date(from: timeselectedfor)
            
            if foodtype==1{
                
                result1 = datefortime!.compare(doordeliverystarttime)
                result2=datefortime!.compare(doordeliveryend)
            }else if foodtype==2{
                result1 = datefortime!.compare(partorderstarttime)
                result2=datefortime!.compare(partorderend)
            }else if foodtype==3{
                result1 = datefortime!.compare(tablebookingstarttime)
                result2=datefortime!.compare(tablebookingendtime)
            }else if foodtype==4{
                result1 = datefortime!.compare(takeawaystarttime)
                result2=datefortime!.compare(takeawayendtime)
            }else{
                
            }
            
            
            
            
            
            
            
            
            if foodtype==1{
                if timeflag==0{
                    if dateselected>=datefordoordelivery{
                        btndoordeliverydateselector.setTitle(dateselected, for: .normal)
                    }else{
                        self.showToast(message: "Please select date after \(datefordoordelivery)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                    }
                }else{
                    if btndoordeliverydateselector.currentTitle==dateselected{
                        //                    if result == .orderedDescending {
                        //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        //                    }else{
                        
                        if result1 == .orderedDescending {
                            if result2 == .orderedDescending {
                                self.showToast(message: "Please select time between \(doorstarttime) and \(doorendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
    //                             timeselected=formattedDatetime
                                
                            }else{
                                
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
    //                                     timeselected=formattedDatetime
                                    }else{
                                        btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                        doordeliverycontinue()
                                    }
                                }else{
                                    btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                    doordeliverycontinue()
                                }
                            }
                            
                        } else if result1 == .orderedAscending {
                            if result2 == .orderedAscending{
                                self.showToast(message: "Please select time between \(doorstarttime) and \(doorendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
    //                              timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
    //                                     timeselected=formattedDatetime
                                    }else{
                                        btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                        doordeliverycontinue()
                                    }
                                }else{
                                    btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                    doordeliverycontinue()
                                }
                            }
                        } else {
                            btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                            doordeliverycontinue()
                        }
                        //                    }
                        
                        
                        
                    }else{
                        btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                        doordeliverycontinue()
                    }
                }
            }else if foodtype==2{
                if timeflag==0{
                    if dateselected>=dateforpartyorder{
                        btnpartorderdateselector.setTitle(dateselected, for: .normal)
                    }else{
                        self.showToast(message: "Please select date after \(dateforpartyorder)", font: UIFont.boldSystemFont(ofSize: 14), duration: 10)
                    }
                }else{
                    
                    if btnpartorderdateselector.currentTitle==dateselected{
                        //                    if result == .orderedDescending {
                        //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        //                    }else{
                        if result1 == .orderedDescending {
                            if result2 == .orderedDescending {
                                self.showToast(message: "Please select time between \(partstarttime) and \(partendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                //timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        // timeselected=formattedDatetime
                                    }else{
                                        btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                        partyordercontinue()
                                    }
                                }else{
                                    btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                    partyordercontinue()
                                }
                            }
                            
                        } else if result1 == .orderedAscending {
                            if result2 == .orderedAscending{
                                self.showToast(message: "Please select time between \(partstarttime) and \(partendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                // timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        //timeselected=formattedDatetime
                                    }else{
                                        btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                        partyordercontinue()
                                    }
                                }else{
                                    btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                    partyordercontinue()
                                }
                            }
                        }else{
                            btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                            partyordercontinue()
                        }
                        //                    }
                    }else{
                        btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                        partyordercontinue()
                    }
                }
                
                
            }else if foodtype==3{
                if timeflag==0{
                    if dateselected>=datefortablebooking{
                        btndateselector.setTitle(dateselected, for: .normal)
                    } else{
                        self.showToast(message: "Please select date after \(datefortablebooking)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                    }
                }else{
                    
                    if btndateselector.currentTitle==dateselected{
                        //                    if result == .orderedDescending {
                        //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        //                    }else{
                        if result1 == .orderedDescending {
                            if result2 == .orderedDescending {
                                self.showToast(message: "Please select time between \(tablestarttime) and \(tableendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                // timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        //timeselected=formattedDatetime
                                    }else{
                                        btntimeselector.setTitle(timeselected, for: .normal)
                                        tablebookingcontinue()
                                    }
                                }else{
                                    btntimeselector.setTitle(timeselected, for: .normal)
                                    tablebookingcontinue()
                                }
                            }
                            
                        } else if result1 == .orderedAscending {
                            if result2 == .orderedAscending{
                                self.showToast(message: "Please select time between \(tablestarttime) and \(tableendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                // timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        // timeselected=formattedDatetime
                                    }else{
                                        btntimeselector.setTitle(timeselected, for: .normal)
                                        tablebookingcontinue()
                                    }
                                }else{
                                    btntimeselector.setTitle(timeselected, for: .normal)
                                    tablebookingcontinue()
                                }
                            }
                        }else{
                            btntimeselector.setTitle(timeselected, for: .normal)
                            tablebookingcontinue()
                        }
                        //                    }
                    }else{
                        btntimeselector.setTitle(timeselected, for: .normal)
                        tablebookingcontinue()
                    }
                }
                
            }else if foodtype==4{
                if timeflag==0{
                    if dateselected>=datefortakeaway{
                        btntakeawaydateselector.setTitle(dateselected, for: .normal)
                    }else{
                        self.showToast(message: "Please select date after \(datefortakeaway)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                    }
                }else{
                    
                    if btntakeawaydateselector.currentTitle==dateselected{
                        //                    if result == .orderedDescending {
                        //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        //                    }else{
                        if result1 == .orderedDescending {
                            if result2 == .orderedDescending {
                                self.showToast(message: "Please select time between \(takestarttime) and \(takeendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                // timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        //timeselected=formattedDatetime
                                    }else{
                                        btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                        takeawaycontinue()
                                    }
                                }else{
                                    
                                    
                                    btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                    takeawaycontinue()
                                }
                            }
                            
                        } else if result1 == .orderedAscending {
                            if result2 == .orderedAscending{
                                self.showToast(message: "Please select time between \(takestarttime) and   \(takeendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                // timeselected=formattedDatetime
                                
                            }else{
                                
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        // timeselected=formattedDatetime
                                    }else{
                                        btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                        takeawaycontinue()
                                    }
                                }else{
                                    btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                    takeawaycontinue()
                                }
                            }
                        }else{
                            btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                            takeawaycontinue()
                        }
                        //                    }
                    }else{
                        btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                        takeawaycontinue()
                    }
                }
                
                // btntakeawaytimeselector.setTitle(timeselected, for: .normal)
            }else{
                
            }
            
            
            
        }
        
        
        
        
        
        
        
        func service_Data_table(){
            
           
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/table")else{return}
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
                        let status=parseJson["status"] as! Bool
                        print("status",status)
                        let noofpeople=parseJson["no_people"] as! NSArray
                        for value in noofpeople{
                            let  item=value as! [String:Any]
                            self.numberlimitablebooking=(item["number"] as! NSString).integerValue
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
        
        
        
        
        
        
        
        
        func service_re_door_delivery(){
            
            self.showhud()
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/re_door_delivery")else{return}
            let poststring="start_date=\(dateselected)&start_time=\(timeselected)&security_token=niya32jfhdu392nfbfdr&latitude=\(latitude)&longitude=\(longitude)&order_id=\(orderid)"
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
                        let status=parseJson["status"] as! Bool
                        print("status",status)
                        if status==true{
                            let minprice=(parseJson["min_price"] as! NSString).integerValue
                            UserDefaults.standard.set(minprice, forKey: "minprice")
                            DispatchQueue.main.async {
                                self.hud.hide(animated: true)
                                self.heightdoordeliverywedontdeliver.constant=0
                                self.heightdoordeliverychangelocation.constant=0
                                self.lblwedontdeliver.isHidden=true
                                self.lblchangelocation.isHidden=true
                            }
                            let available=parseJson["available"] as! NSArray
                            if available.count>0{
                                
                                let notavailable=parseJson["not_available"] as! NSArray
                                if notavailable.count>0{
                                    for value in self.reorderproductsarray{
                                        let item=value as! [String:String]
                                        let i=self.reorderproductsarray.index(of:value)
                                        if notavailable.contains(item["product_name"]){
                                            self.reorderproductsarray.remove(at: i!)
                                            //popupnotavailable
                                            DispatchQueue.main.async {
                                                self.viewreorderconfirmation.isHidden=false
                                                self.viewreorderitemnotavailable.isHidden=false
                                                self.viewreorederitemavailable.isHidden=true
                                                self.viewdoordelivery.isHidden=true
                                                self.lblnotavailableproductname.text=item["product_name"] as! String
                                            }
                                        }else{
                                            DispatchQueue.main.async {
                                                self.viewreorderconfirmation.isHidden=false
                                                self.viewdoordelivery.isHidden=true
                                                self.viewreorderitemnotavailable.isHidden=true
                                                self.viewreorederitemavailable.isHidden=false
                                            }
                                        }
                                        
                                    }
                                }else{
                                    DispatchQueue.main.async {
                                        self.viewreorderconfirmation.isHidden=false
                                        self.viewdoordelivery.isHidden=true
                                        self.viewreorderitemnotavailable.isHidden=true
                                        self.viewreorederitemavailable.isHidden=false
                                    }
                                }
                            }else{
                                DispatchQueue.main.async {
                                    self.showToast(message: "Products are unavailable", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                }
                            }
                        }else{
                            DispatchQueue.main.async{
                                self.hud.hide(animated: true)
                                self.lblwedontdeliver.isHidden=false
                                self.lblchangelocation.isHidden=false
                                self.heightdoordeliverywedontdeliver.constant=16
                                self.heightdoordeliverychangelocation.constant=17
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
        
        func service_door_delivery(){
            self.showhud()
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/door_delivery")else{return}
            let poststring="start_date=\(dateselected)&start_time=\(timeselected)&security_token=niya32jfhdu392nfbfdr&latitude=\(latitude)&longitude=\(longitude)"
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
                        let status=parseJson["status"] as! Bool
                        print("status",status)
                        if status==true{
                            let minprice=(parseJson["min_price"] as! NSString).integerValue
                            UserDefaults.standard.set(minprice, forKey: "minprice")
                            DispatchQueue.main.async {
                                self.hud.hide(animated: true)
                                self.heightdoordeliverywedontdeliver.constant=0
                                self.heightdoordeliverychangelocation.constant=0
                                self.lblwedontdeliver.isHidden=true
                                self.lblchangelocation.isHidden=true
                                let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductslistingViewController") as! ProductslistingViewController
                                let navController = UINavigationController(rootViewController: productlisting)
                                self.present(navController, animated: true)
                                
                            }
                            
                        }else{
                            DispatchQueue.main.async{
                                self.hud.hide(animated: true)
                                self.lblwedontdeliver.isHidden=false
                                self.lblchangelocation.isHidden=false
                                self.heightdoordeliverywedontdeliver.constant=16
                                self.heightdoordeliverychangelocation.constant=17
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
        
        
        func service_party_order(){
            
            self.showhud()
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/party_order")else{return}
            let poststring="start_date=\(dateselected)&start_time=\(timeselected)&security_token=niya32jfhdu392nfbfdr&pax=\(txtfldpartyoredernoofpeople.text!)&latitude=\(latitude)&longitude=\(longitude)"
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
                        let status=parseJson["status"] as! Bool
                        let pax_max_number=(parseJson["pax_max_number"] as! NSString).integerValue
                        print("status",status)
                        if status==true{
                            let minprice=(parseJson["min_price"] as! NSString).integerValue
                            UserDefaults.standard.set(minprice, forKey: "minprice")
                            DispatchQueue.main.async {
                                self.hud.hide(animated: true)
                                self.heightdontdeliver.constant=0
                                self.hightchangelocation.constant=0
                                self.lblpartyorderwedontdeliver.isHidden=true
                                self.lblpartyorderchangelocation.isHidden=true
                                if self.people>pax_max_number{
                                    self.showToast(message: "Max number is \(pax_max_number)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                }else{
                                    
                                    let partyorder = self.storyboard?.instantiateViewController (withIdentifier: "PartyorderproductsViewController") as! PartyorderproductsViewController
                                    let navController = UINavigationController(rootViewController: partyorder)
                                    self.present(navController, animated: true)
                                }
                                
                            }
                            
                        }else{
                            DispatchQueue.main.async{
                                self.hud.hide(animated: true)
                                self.lblpartyorderwedontdeliver.isHidden=false
                                self.lblpartyorderchangelocation.isHidden=false
                                self.heightdontdeliver.constant=13
                                self.hightchangelocation.constant=14
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
        
        
        
        @IBAction func btnpartyorderautosearch(_ sender: Any) {
            
            let mapcontroller = self.storyboard?.instantiateViewController (withIdentifier: "MapViewController") as! MapViewController
            mapcontroller.delegate=self
            
            let navController = UINavigationController(rootViewController: mapcontroller)
            
            self.present(navController, animated: true)
            
        }
        
        
        @IBAction func btndoordeliveryautosearch(_ sender: Any) {
            let mapcontroller = self.storyboard?.instantiateViewController (withIdentifier: "MapViewController") as! MapViewController
            mapcontroller.delegate=self
            
            let navController = UINavigationController(rootViewController: mapcontroller)
            
            self.present(navController, animated: true)
        }
        
        func autosearchcompleted(){
            let takeaway = self.storyboard?.instantiateViewController (withIdentifier: "TakeawaypopupViewController") as! TakeawaypopupViewController
            takeaway.currentAddress=placeaddress
            // UserDefaults.standard.set(self.placeaddress, forKey: "currentaddress")
            takeaway.latitude=lat
            takeaway.longitude=long
            UserDefaults.standard.set(lat, forKey: "latitude")
            UserDefaults.standard.set(long, forKey: "longitude")
            self.navigationController?.pushViewController(takeaway, animated: true)
        }
        
        
        func showhud(){
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.indeterminate
        }
        
        
        
        
        func service_food_time(){
          
            guard let url=NSURL(string :"https://niyaregency.com/api/Data/food_open")else{return}
            let poststring="security_token=niya32jfhdu392nfbfdr"
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
                        let data=parseJson["data"]as! NSDictionary
                        let list=data["list"]as! NSArray
                        let timinglist=data["timing_list"] as! NSArray
                        for value in list{
                            let item=value as! [String:Any]
                            let activity=item["activity"] as! String
                            let measurement=item["measurement"] as! String
                            let order_time=(item["order_time"] as! NSString).integerValue
                            let km=item["km"] as! String
                            if activity=="1"{
                                if measurement=="hr"{
                                    self.time=order_time*60
                                }else{
                                    self.time=order_time
                                }
                                
                                
                                DispatchQueue.main.async {
                                    let today_date = Date()
                                    let format = DateFormatter()
                                    format.dateFormat = "dd-MM-yyy"
                                    format.timeZone = .current
                                    
                                    self.lbldoordeliverydistance.text="*Delivery limit is "+km+"Kms"
                                    
                                    let calendar = Calendar.current
                                    self.nextdatedoordelivery = calendar.date(byAdding: .minute, value: self.time, to: today_date)!
                                    self.datefordoordelivery=format.string(from: self.nextdatedoordelivery)
                                    if self.foodtype==1{
                                        self.dateselected=self.datefordoordelivery
                                    }
                                    
                                    self.btndoordeliverydateselector.setTitle(self.datefordoordelivery, for: .normal)
                                    
                                    
                                    let timeformatter=DateFormatter()
                                    timeformatter.dateFormat="hh:mm a"
                                    timeformatter.timeZone = .current
                                    let formattedtime = timeformatter.string(from: self.nextdatedoordelivery)
                                    if self.foodtype==1{
                                        self.timeselected=formattedtime
                                    }
                                    self.btndoordeliverytimeselector.setTitle(formattedtime, for: .normal)
                                    
                                    
                                }
                            }else if activity=="2"{
                                let partyorderordertime=order_time
                                
                                if measurement=="hr"{
                                    self.timepartyorder=order_time*60
                                }else{
                                    self.timepartyorder=order_time
                                }
                                print("order_time",order_time)
                                
                                DispatchQueue.main.async {
                                    
                                    
                                    self.lbldeliverylimitpartyorder.text="*Delivery limit is "+km+"Kms"
                                    let today_date = Date()
                                    let format = DateFormatter()
                                    format.dateFormat = "dd-MM-yyy"
                                    format.timeZone = .current
                                    
                                    print("self.time",self.timepartyorder)
                                    
                                    let calendar = Calendar.current
                                    self.nextdatepartyorder = calendar.date(byAdding: .minute, value: self.timepartyorder, to: today_date)!
                                    print("self.nextdatepartyorder",self.nextdatepartyorder)
                                    self.dateforpartyorder=format.string(from: self.nextdatepartyorder)
                                    if self.foodtype==2{
                                        self.dateselected=self.dateforpartyorder
                                    }
                                   
                                    self.btnpartorderdateselector.setTitle(self.dateforpartyorder, for: .normal)
                                    
                                    
                                    let timeformatter=DateFormatter()
                                    timeformatter.dateFormat="hh:mm a"
                                    timeformatter.timeZone = .current
                                    let formattedtime = timeformatter.string(from: self.nextdatepartyorder)
                                    if self.foodtype==2{
                                        self.timeselected=formattedtime
                                    }
                                    print("self.formattedtime",formattedtime)
                                    self.btnpartyordertimeselector.setTitle(formattedtime, for: .normal)
                                    
                                    
                                    
                                }
                                
                                
                                
                            }else if activity=="3"{
                                
                                
                                if measurement=="hr"{
                                    self.timetablebooking=order_time*60
                                }else{
                                    self.timetablebooking=order_time
                                }
                                
                                DispatchQueue.main.async {
                                    let today_date = Date()
                                    let format = DateFormatter()
                                    format.dateFormat = "dd-MM-yyy"
                                    format.timeZone = .current
                                    
                                    
                                    
                                    let calendar = Calendar.current
                                    self.nextdatetablebooking = calendar.date(byAdding: .minute, value: self.timetablebooking, to: today_date)!
                                    self.datefortablebooking=format.string(from: self.nextdatetablebooking)
                                    if self.foodtype==3{
                                        self.dateselected=self.datefortablebooking
                                    }
                                   
                                    self.btndateselector.setTitle(self.datefortablebooking, for: .normal)
                                    
                                    
                                    let timeformatter=DateFormatter()
                                    timeformatter.dateFormat="hh:mm a"
                                    timeformatter.timeZone = .current
                                    let formattedtime = timeformatter.string(from: self.nextdatetablebooking)
                                    if self.foodtype==3{
                                        self.timeselected=formattedtime
                                    }
                                    self.btntimeselector.setTitle(formattedtime, for: .normal)
                                    
                                    
                                    
                                }
                                
                                
                            }else if activity=="4"{
                                
                                
                                if measurement=="hr"{
                                    self.timetakeaway=order_time*60
                                }else{
                                    self.timetakeaway=order_time
                                }
                                
                                DispatchQueue.main.async {
                                    let today_date = Date()
                                    let format = DateFormatter()
                                    format.dateFormat = "dd-MM-yyy"
                                    format.timeZone = .current
                                    
                                    
                                    
                                    let calendar = Calendar.current
                                    self.nextdatetakeaway = calendar.date(byAdding: .minute, value: self.timetakeaway, to: today_date)!
                                    self.datefortakeaway=format.string(from: self.nextdatetakeaway)
                                    if self.foodtype==4{
                                        self.dateselected=self.datefortakeaway
                                    }
                                    
                                    self.btntakeawaydateselector.setTitle(self.datefortakeaway, for: .normal)
                                    
                                    
                                    let timeformatter=DateFormatter()
                                    timeformatter.dateFormat="hh:mm a"
                                    timeformatter.timeZone = .current
                                    let formattedtime = timeformatter.string(from: self.nextdatetakeaway)
                                    if self.foodtype==4{
                                        self.timeselected=formattedtime
                                    }
                                    self.btntakeawaytimeselector.setTitle(formattedtime, for: .normal)
                                    
                                    
                                    
                                }
                                
                                
                            }else{
                                
                            }
                        }
                        for val in timinglist{
                            let item=val as! [String:Any]
                            let activity=item["activity"] as! String
                            let starttime=item["start_time"] as! String
                            let endtime=item["end_time"] as! String
                            
                            let dateAsStringstarttime = item["start_time"] as! String
                            let dateAsStringendtime = item["end_time"] as! String
                            print("dateAsStringstarttime",dateAsStringstarttime)
                            print("dateAsStringendtime",dateAsStringendtime)
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "HH:mm:ss"
                            let start=dateFormatter.date(from: dateAsStringstarttime)
                            let end=dateFormatter.date(from: dateAsStringendtime)
                            
                            if activity=="1"{
                                self.doordeliverystarttime=start!
                                self.doordeliveryend=end!
                            }else if activity=="2"{
                                self.partorderstarttime=start!
                                self.partorderend=end!
                            }else if activity=="3"{
                                self.tablebookingstarttime=start!
                                self.tablebookingendtime=end!
                            }else if activity=="4"{
                                self.takeawaystarttime=start!
                                self.takeawayendtime=end!
                            }else{
                                
                            }
                            
                            
                            print("doordeliverystarttime",self.doordeliverystarttime)
                            print("doordeliveryend",self.doordeliveryend)
                        }
                        
                    }else{
//                         DispatchQueue.main.async {
//                            self.hud.hide(animated:true)
//                        }
                    }
//                    DispatchQueue.main.async {
//                                               self.hud.hide(animated:true)
//                                           }
                }
                catch {
                    print(error)
//
                }
                
            }.resume()
        }
        
        
        @IBAction func btnreordercancel(_ sender: Any) {
            btnreordersubmitt.backgroundColor=UIColor.white
            btnreordersubmitt.setTitleColor(UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0), for: .normal)
            btnreordercancel.backgroundColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0)
            btnreordercancel.setTitleColor(.white, for: .normal)
            viewreorderconfirmation.isHidden=true
            
            
        }
        
        
        @IBAction func btnreordersubmitpressed(_ sender: Any) {
            
            
            btnreordersubmitt.backgroundColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0)
            btnreordersubmitt.setTitleColor(.white, for: .normal)
            btnreordercancel.backgroundColor=UIColor.white
            btnreordercancel.setTitleColor(UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0), for: .normal)
            var reorderitem=[String:Any]()
            for value in reorderproductsarray{
                let item=value as [String:Any]
                reorderitem.updateValue(item["product_id"], forKey: "id")
                reorderitem.updateValue(item["price"], forKey: "actualprice")
                reorderitem.updateValue(item["total"], forKey: "totalprice")
                reorderitem.updateValue(item["qty"], forKey: "quantityincreased")
                reorderitem.updateValue(item["product_name"], forKey: "productname")
                myarray.append(reorderitem as! [String : String])
            }
            UserDefaults.standard.set(myarray,forKey: "myarray")
            print("myarray",myarray)
            for values in myarray{
                let item:[String:String]=values as [String:String]
                cartprice+=(item["totalprice"]as! NSString).integerValue
                print("cartprice",cartprice)
            }
            UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
            let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
            let navController = UINavigationController(rootViewController: yourcart)
            self.present(navController, animated: true)
            
        }
        
        @IBAction func btncancelactionnotavailable(_ sender: Any) {
            
            btnreordernotavailable.backgroundColor=UIColor.white
            btnreordernotavailable.setTitleColor(UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0), for: .normal)
            btncancelnotavailable.backgroundColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0)
            btncancelnotavailable.setTitleColor(.white, for: .normal)
            viewreorderconfirmation.isHidden=true
            
        }
        
        
        @IBAction func btnreorderactionnotavailable(_ sender: Any) {
            
            btnreordernotavailable.backgroundColor=UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0)
            btnreordernotavailable.setTitleColor(.white, for: .normal)
            btncancelnotavailable.backgroundColor=UIColor.white
            btncancelnotavailable.setTitleColor(UIColor(red: 226 / 255, green: 100 / 255, blue: 66 / 255, alpha: 1.0), for: .normal)
            
            var reorderitem=[String:Any]()
            for value in reorderproductsarray{
                let item=value as [String:Any]
                reorderitem.updateValue(item["product_id"], forKey: "id")
                reorderitem.updateValue(item["price"], forKey: "actualprice")
                reorderitem.updateValue(item["total"], forKey: "totalprice")
                reorderitem.updateValue(item["qty"], forKey: "quantityincreased")
                reorderitem.updateValue(item["product_name"], forKey: "productname")
                myarray.append(reorderitem as! [String : String])
            }
            UserDefaults.standard.set(myarray,forKey: "myarray")
            print("myarray",myarray)
            for values in myarray{
                let item:[String:String]=values as [String:String]
                cartprice+=(item["totalprice"]as! NSString).integerValue
                print("cartprice",cartprice)
            }
            UserDefaults.standard.set(cartprice, forKey: "carttotalprice")
            let yourcart = self.storyboard?.instantiateViewController (withIdentifier: "YourcartViewController") as! YourcartViewController
            let navController = UINavigationController(rootViewController: yourcart)
            self.present(navController, animated: true)
        }
        
        func passback(value:Int){
            print("value",value)
            if value==1{
                viewforsettingtime.isHidden=false
                txtfldampm.text="AM"
                viewsettime.layer.cornerRadius=10
            }
        }
        
        
        @IBAction func btntoshowampmaction(_ sender: Any) {
            if viewforampmselection.isHidden==false{
                viewforampmselection.isHidden=true
            }else{
                viewforampmselection.isHidden=false
            }
            txtfldampm.text="AM"
            
        }
        
        
        @IBAction func btnamselectedaction(_ sender: Any) {
            txtfldampm.text="AM"
            viewforampmselection.isHidden=true
        }
        
        
        @IBAction func btnpmselectedaction(_ sender: Any) {
            txtfldampm.text="PM"
            viewforampmselection.isHidden=true
        }
        
        
        
        @IBAction func btncancelofsettingtime(_ sender: Any) {
            viewforsettingtime.isHidden=true
        }
        
        @IBAction func btnokforsettingtime(_ sender: Any) {
            var result: ComparisonResult? = nil
            var result1: ComparisonResult? = nil
            var result2: ComparisonResult? = nil
            var formatteddate1=Date()
            var formattedDatetime=String()
            
            var doorstarttime=String()
            var doorendtime=String()
            var partstarttime=String()
            var partendtime=String()
            var tablestarttime=String()
            var tableendtime=String()
            var takestarttime=String()
            var takeendtime=String()
            var hourentered=Int()
            print("am/pm",txtfldampm.text!)
            
            if txtfldhr.text?.isEmpty==true||txtfldhr.text==""||txtfldhr.text==" "||txtfldmin.text?.isEmpty==true||txtfldmin.text==""||txtfldmin.text==" "{
                showToast(message: "Please enter the time", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
            }else if txtfldhr.text!.count>2{
                showToast(message: "Please enter the hour correctly", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                
                
            } else if txtfldmin.text!.count>2{
                showToast(message: "Please enter the minute correctly", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
            }else{
                
                let hour=txtfldhr.text!
                hourentered=Int(hour)!
                
                if hourentered>12 {
                    showToast(message: "Please enter the hr correctly", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                }else{
                    
                    
                    let  mytext = txtfldhr.text!+":"+txtfldmin.text!+" "+txtfldampm.text!
                    //           let mytext="5:04 AM"
                    print("mytext",mytext)
                    let dateformat = DateFormatter()
                    dateformat.dateFormat = "h:mm a"
                    dateformat.timeZone = .current
                    let value=dateformat.date(from: mytext)
                    print("value",value)
                    dateformat.dateFormat = "HH:mm:ss"
                    dateformat.timeZone = .current
                    let timeselectedfor = dateformat.string(from: value!)
                    let datefortime=dateformat.date(from: timeselectedfor)
                    print("datefortime",datefortime)
                    
                    let dateformat1 = DateFormatter()
                    dateformat1.dateFormat = "h:mm a"
                    dateformat1.timeZone = .current
                    if foodtype==1{
                        formattedDatetime = dateformat1.string(from: nextdatedoordelivery)
                        doorstarttime=dateformat1.string(from: doordeliverystarttime)
                        doorendtime=dateformat1.string(from: doordeliveryend)
                    }else if foodtype==2{
                        formattedDatetime = dateformat1.string(from: nextdatepartyorder)
                        partstarttime=dateformat1.string(from: partorderstarttime)
                        partendtime=dateformat1.string(from: partorderend)
                    }else if foodtype==3{
                        formattedDatetime = dateformat1.string(from: nextdatetablebooking)
                        tablestarttime=dateformat1.string(from: tablebookingstarttime)
                        tableendtime=dateformat1.string(from: tablebookingendtime)
                    }else if foodtype==4{
                        formattedDatetime = dateformat1.string(from: nextdatetakeaway)
                        takestarttime=dateformat1.string(from: takeawaystarttime)
                        takeendtime=dateformat1.string(from: takeawayendtime)
                    }
                        
                    else{
                        //formattedDatetime = dateformat1.string(from: today_date)
                    }
                    formatteddate1=dateformat1.date(from: formattedDatetime)!
                    let timeselectedcompare=dateformat1.date(from: mytext)
                    
                    result = formatteddate1.compare(timeselectedcompare!)
                    
                    //  UserDefaults.standard.set(timeselected, forKey: "start_timedoordelivery")
                    if foodtype==1{
                        
                        result1 = datefortime!.compare(doordeliverystarttime)
                        result2=datefortime!.compare(doordeliveryend)
                    }else if foodtype==2{
                        result1 = datefortime!.compare(partorderstarttime)
                        result2=datefortime!.compare(partorderend)
                    }else if foodtype==3{
                        result1 = datefortime!.compare(tablebookingstarttime)
                        result2=datefortime!.compare(tablebookingendtime)
                    }else if foodtype==4{
                        result1 = datefortime!.compare(takeawaystarttime)
                        result2=datefortime!.compare(takeawayendtime)
                    }else{
                        
                    }
                    
                    if foodtype==1{
                        if timeflag==0{
                            if dateselected>=datefordoordelivery{
                                btndoordeliverydateselector.setTitle(dateselected, for: .normal)
                            }else{
                                self.showToast(message: "Please select date after \(datefordoordelivery)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                            }
                        }else{
                            if btndoordeliverydateselector.currentTitle==dateselected{
                                //                    if result == .orderedDescending {
                                //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                //                    }else{
                                
                                if result1 == .orderedDescending {
                                    if result2 == .orderedDescending {
                                        self.showToast(message: "Please select time between \(doorstarttime) and \(doorendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                        timeselected=formattedDatetime
                                        
                                    }else{
                                        if dateselected==formattedDate{
                                            if result == .orderedDescending {
                                                self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                                timeselected=formattedDatetime
                                            }else{
                                                timeselected=mytext
                                                btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                            }
                                        }else{
                                            timeselected=mytext
                                            btndoordeliverytimeselector.setTitle(mytext, for: .normal)
                                        }
                                    }
                                    
                                } else if result1 == .orderedAscending {
                                    if result2 == .orderedAscending{
                                        self.showToast(message: "Please select time between \(doorstarttime) and \(doorendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                        timeselected=formattedDatetime
                                        
                                    }else{
                                        if dateselected==formattedDate{
                                            if result == .orderedDescending {
                                                self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                                timeselected=formattedDatetime
                                            }else{
                                                timeselected=mytext
                                                btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                            }
                                        }else{
                                            timeselected=mytext
                                            btndoordeliverytimeselector.setTitle(mytext, for: .normal)
                                        }
                                    }
                                } else {
                                    timeselected=mytext
                                    btndoordeliverytimeselector.setTitle(mytext, for: .normal)
                                }
                                //                    }
                                
                                
                                
                            }else{
                                timeselected=mytext
                                btndoordeliverytimeselector.setTitle(mytext, for: .normal)
                            }
                        }
                    }else if foodtype==2{
                        if timeflag==0{
                            if dateselected>=dateforpartyorder{
                                btnpartorderdateselector.setTitle(dateselected, for: .normal)
                            }else{
                                self.showToast(message: "Please select date after \(dateforpartyorder)", font: UIFont.boldSystemFont(ofSize: 14), duration: 5)
                            }
                        }else{
                            
                            if btnpartorderdateselector.currentTitle==dateselected{
                                //                    if result == .orderedDescending {
                                //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                //                    }else{
                                if result1 == .orderedDescending {
                                    if result2 == .orderedDescending {
                                        self.showToast(message: "Please select time between \(partstarttime) and \(partendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                        timeselected=formattedDatetime
                                        
                                    }else{
                                        if dateselected==formattedDate{
                                            if result == .orderedDescending {
                                                self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                                timeselected=formattedDatetime
                                            }else{
                                                timeselected=mytext
                                                btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                            }
                                        }else{
                                            timeselected=mytext
                                            btnpartyordertimeselector.setTitle(mytext, for: .normal)
                                        }
                                    }
                                    
                                } else if result1 == .orderedAscending {
                                    if result2 == .orderedAscending{
                                        self.showToast(message: "Please select time between \(partstarttime) and \(partendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                        timeselected=formattedDatetime
                                        
                                    }else{
                                        if dateselected==formattedDate{
                                            if result == .orderedDescending {
                                                self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                                timeselected=formattedDatetime
                                            }else{
                                                timeselected=mytext
                                                btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                            }
                                        }else{
                                            timeselected=mytext
                                            btnpartyordertimeselector.setTitle(mytext, for: .normal)
                                        }
                                    }
                                }else{
                                    timeselected=mytext
                                    btnpartyordertimeselector.setTitle(mytext, for: .normal)
                                }
                                //                    }
                            }else{
                                timeselected=mytext
                                btnpartyordertimeselector.setTitle(mytext, for: .normal)
                            }
                        }
                        
                        
                    }else if foodtype==3{
                        if timeflag==0{
                            if dateselected>=datefortablebooking{
                                btndateselector.setTitle(dateselected, for: .normal)
                            } else{
                                self.showToast(message: "Please select date after \(datefortablebooking)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                            }
                        }else{
                            
                            if btndateselector.currentTitle==dateselected{
                                //                    if result == .orderedDescending {
                                //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                //                    }else{
                                if result1 == .orderedDescending {
                                    if result2 == .orderedDescending {
                                        self.showToast(message: "Please select time between \(tablestarttime) and \(tableendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                        timeselected=formattedDatetime
                                        
                                    }else{
                                        if dateselected==formattedDate{
                                            if result == .orderedDescending {
                                                self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                                timeselected=formattedDatetime
                                            }else{
                                                timeselected=mytext
                                                btntimeselector.setTitle(timeselected, for: .normal)
                                            }
                                        }else{
                                            timeselected=mytext
                                            btntimeselector.setTitle(mytext, for: .normal)
                                        }
                                    }
                                    
                                } else if result1 == .orderedAscending {
                                    if result2 == .orderedAscending{
                                        self.showToast(message: "Please select time between \(tablestarttime) and \(tableendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                        timeselected=formattedDatetime
                                        
                                    }else{
                                        if dateselected==formattedDate{
                                            if result == .orderedDescending {
                                                self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                                timeselected=formattedDatetime
                                            }else{
                                                timeselected=mytext
                                                btntimeselector.setTitle(timeselected, for: .normal)
                                            }
                                        }else{
                                            timeselected=mytext
                                            btntimeselector.setTitle(mytext, for: .normal)
                                        }
                                    }
                                }else{
                                    timeselected=mytext
                                    btntimeselector.setTitle(mytext, for: .normal)
                                }
                                //                    }
                            }else{
                                timeselected=mytext
                                btntimeselector.setTitle(mytext, for: .normal)
                            }
                        }
                        
                    }else if foodtype==4{
                        if timeflag==0{
                            if dateselected>=datefortakeaway{
                                btntakeawaydateselector.setTitle(dateselected, for: .normal)
                            }else{
                                self.showToast(message: "Please select date after \(datefortakeaway)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                            }
                        }else{
                            
                            if btntakeawaydateselector.currentTitle==dateselected{
                                //                    if result == .orderedDescending {
                                //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                //                    }else{
                                if result1 == .orderedDescending {
                                    if result2 == .orderedDescending {
                                        self.showToast(message: "Please select time between \(takestarttime) and \(takeendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                        timeselected=formattedDatetime
                                        
                                    }else{
                                        if dateselected==formattedDate{
                                            if result == .orderedDescending {
                                                self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                                timeselected=formattedDatetime
                                            }else{
                                                timeselected=mytext
                                                btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                            }
                                        }else{
                                            timeselected=mytext
                                            btntakeawaytimeselector.setTitle(mytext, for: .normal)
                                        }
                                    }
                                    
                                } else if result1 == .orderedAscending {
                                    if result2 == .orderedAscending{
                                        self.showToast(message: "Please select time between \(takestarttime) and   \(takeendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                        timeselected=formattedDatetime
                                        
                                    }else{
                                        if dateselected==formattedDate{
                                            if result == .orderedDescending {
                                                self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 5)
                                                timeselected=formattedDatetime
                                            }else{
                                                timeselected=mytext
                                                btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                            }
                                        }else{
                                            timeselected=mytext
                                            btntakeawaytimeselector.setTitle(mytext, for: .normal)
                                        }
                                    }
                                }else{
                                    timeselected=mytext
                                    btntakeawaytimeselector.setTitle(mytext, for: .normal)
                                }
                                //                    }
                            }else{
                                timeselected=mytext
                                btntakeawaytimeselector.setTitle(mytext, for: .normal)
                            }
                        }
                        
                        // btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                    }else{
                        
                    }
                    
                    
                    
                    
                    viewforsettingtime.isHidden=true
                    
                }
                
                
            }
            //        else{
            //            showToast(message: "Please enter AM/PM correctly", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
            //        }
        }
        
    }
    @available(iOS 13.0, *)
    extension TakeawaypopupViewController: WWCalendarTimeSelectorProtocol{
        
        func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {
            
            let today_date = Date()
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyy"
            format.timeZone = .current
            
            if foodtype==1{
                if date.compare(nextdatedoordelivery) == .orderedAscending{
                    return false
                }
                else{
                    return true
                }
            }else if foodtype==2{
                
                if date.compare(nextdatepartyorder) == .orderedAscending{
                    return false
                }
                else{
                    return true
                }
                
            }else if foodtype==3{
                
                if date.compare(nextdatetablebooking) == .orderedAscending{
                    return false
                }
                else{
                    return true
                }
                
            }else if foodtype==4{
                
                if date.compare(nextdatetakeaway) == .orderedAscending{
                    return false
                }
                else{
                    return true
                }
                
            }
                
                
            else{
                if date.compare(today_date) == .orderedAscending{
                    return false
                }
                else{
                    return true
                }
                
            }
            
        }
        
        
        
        func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
            print("Selected Date- \(date)")
            var result: ComparisonResult? = nil
            var result1: ComparisonResult? = nil
            var result2: ComparisonResult? = nil
            var formatteddate1=Date()
            var formattedDatetime=String()
            var doorstarttime=String()
            var doorendtime=String()
            var partstarttime=String()
            var partendtime=String()
            var tablestarttime=String()
            var tableendtime=String()
            var takestarttime=String()
            var takeendtime=String()
            
            //
            if timeflag==0{
                dateselected = date.stringFromFormat("dd-MM-yyy")
                //        if foodtype==1{
                //          let doordateselected = date.stringFromFormat("dd-MM-yyy")
                //            if doordateselected>datefordoordelivery{
                //                dateselected=doordateselected
                //            }else{
                //
                //            }
                //        }
                
                
            }else{
                timeselected = date.stringFromFormat("h:mm a")
                //             UserDefaults.standard.set(timeselected, forKey: "start_timedoordelivery")
                
                let today_date = Date()
                let dateformat = DateFormatter()
                dateformat.dateFormat = "h:mm a"
                dateformat.timeZone = .current
                if foodtype==1{
                    formattedDatetime = dateformat.string(from: nextdatedoordelivery)
                    doorstarttime=dateformat.string(from: doordeliverystarttime)
                    doorendtime=dateformat.string(from: doordeliveryend)
                }else if foodtype==2{
                    formattedDatetime = dateformat.string(from: nextdatepartyorder)
                    partstarttime=dateformat.string(from: partorderstarttime)
                    partendtime=dateformat.string(from: partorderend)
                }else if foodtype==3{
                    formattedDatetime = dateformat.string(from: nextdatetablebooking)
                    tablestarttime=dateformat.string(from: tablebookingstarttime)
                    tableendtime=dateformat.string(from: tablebookingendtime)
                }else if foodtype==4{
                    formattedDatetime = dateformat.string(from: nextdatetakeaway)
                    takestarttime=dateformat.string(from: takeawaystarttime)
                    takeendtime=dateformat.string(from: takeawayendtime)
                }
                    
                else{
                    formattedDatetime = dateformat.string(from: today_date)
                }
                formatteddate1=dateformat.date(from: formattedDatetime)!
                let timeselectedcompare=dateformat.date(from: timeselected)
                print("timeselected",timeselected)
                print("formatteddate1",formatteddate1)
                print("timeselectedcompare",timeselectedcompare)
                print("today_date",today_date)
                print("date",date)
                print("dateselected",dateselected)
                
                result = formatteddate1.compare(timeselectedcompare!)
                
                var format = DateFormatter()
                format.dateFormat = "hh:mm a"
                let value=format.date(from: timeselected)
                format.dateFormat = "HH:mm:ss"
                format.timeZone = .current
                let timeselectedfor = format.string(from: value!)
                let datefortime=format.date(from: timeselectedfor)
                
                if foodtype==1{
                    
                    result1 = datefortime!.compare(doordeliverystarttime)
                    result2=datefortime!.compare(doordeliveryend)
                }else if foodtype==2{
                    result1 = datefortime!.compare(partorderstarttime)
                    result2=datefortime!.compare(partorderend)
                }else if foodtype==3{
                    result1 = datefortime!.compare(tablebookingstarttime)
                    result2=datefortime!.compare(tablebookingendtime)
                }else if foodtype==4{
                    result1 = datefortime!.compare(takeawaystarttime)
                    result2=datefortime!.compare(takeawayendtime)
                }else{
                    
                }
                
                
            }
            
            
            
            
            
            if foodtype==1{
                if timeflag==0{
                    if dateselected>=datefordoordelivery{
                        btndoordeliverydateselector.setTitle(dateselected, for: .normal)
                    }else{
                        self.showToast(message: "Please select date after \(datefordoordelivery)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                    }
                }else{
                    if btndoordeliverydateselector.currentTitle==dateselected{
                        //                    if result == .orderedDescending {
                        //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        //                    }else{
                        
                        if result1 == .orderedDescending {
                            if result2 == .orderedDescending {
                                self.showToast(message: "Please select time between \(doorstarttime) and \(doorendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                timeselected=formattedDatetime
                                
                            }else{
                                
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        timeselected=formattedDatetime
                                    }else{
                                        btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                    }
                                }else{
                                    btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                }
                            }
                            
                        } else if result1 == .orderedAscending {
                            if result2 == .orderedAscending{
                                self.showToast(message: "Please select time between \(doorstarttime) and \(doorendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        timeselected=formattedDatetime
                                    }else{
                                        btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                    }
                                }else{
                                    btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                                }
                            }
                        } else {
                            btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                        }
                        //                    }
                        
                        
                        
                    }else{
                        btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
                    }
                }
            }else if foodtype==2{
                if timeflag==0{
                    if dateselected>=dateforpartyorder{
                        btnpartorderdateselector.setTitle(dateselected, for: .normal)
                    }else{
                        self.showToast(message: "Please select date after \(dateforpartyorder)", font: UIFont.boldSystemFont(ofSize: 14), duration: 10)
                    }
                }else{
                    
                    if btnpartorderdateselector.currentTitle==dateselected{
                        //                    if result == .orderedDescending {
                        //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        //                    }else{
                        if result1 == .orderedDescending {
                            if result2 == .orderedDescending {
                                self.showToast(message: "Please select time between \(partstarttime) and \(partendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        timeselected=formattedDatetime
                                    }else{
                                        btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                    }
                                }else{
                                    btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                }
                            }
                            
                        } else if result1 == .orderedAscending {
                            if result2 == .orderedAscending{
                                self.showToast(message: "Please select time between \(partstarttime) and \(partendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        timeselected=formattedDatetime
                                    }else{
                                        btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                    }
                                }else{
                                    btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                                }
                            }
                        }else{
                            btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                        }
                        //                    }
                    }else{
                        btnpartyordertimeselector.setTitle(timeselected, for: .normal)
                    }
                }
                
                
            }else if foodtype==3{
                if timeflag==0{
                    if dateselected>=datefortablebooking{
                        btndateselector.setTitle(dateselected, for: .normal)
                    } else{
                        self.showToast(message: "Please select date after \(datefortablebooking)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                    }
                }else{
                    
                    if btndateselector.currentTitle==dateselected{
                        //                    if result == .orderedDescending {
                        //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        //                    }else{
                        if result1 == .orderedDescending {
                            if result2 == .orderedDescending {
                                self.showToast(message: "Please select time between \(tablestarttime) and \(tableendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        timeselected=formattedDatetime
                                    }else{
                                        btntimeselector.setTitle(timeselected, for: .normal)
                                    }
                                }else{
                                    btntimeselector.setTitle(timeselected, for: .normal)
                                }
                            }
                            
                        } else if result1 == .orderedAscending {
                            if result2 == .orderedAscending{
                                self.showToast(message: "Please select time between \(tablestarttime) and \(tableendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        timeselected=formattedDatetime
                                    }else{
                                        btntimeselector.setTitle(timeselected, for: .normal)
                                    }
                                }else{
                                    btntimeselector.setTitle(timeselected, for: .normal)
                                }
                            }
                        }else{
                            btntimeselector.setTitle(timeselected, for: .normal)
                        }
                        //                    }
                    }else{
                        btntimeselector.setTitle(timeselected, for: .normal)
                    }
                }
                
            }else if foodtype==4{
                if timeflag==0{
                    if dateselected>=datefortakeaway{
                        btntakeawaydateselector.setTitle(dateselected, for: .normal)
                    }else{
                        self.showToast(message: "Please select date after \(datefortakeaway)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                    }
                }else{
                    
                    if btntakeawaydateselector.currentTitle==dateselected{
                        //                    if result == .orderedDescending {
                        //                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                        //                    }else{
                        if result1 == .orderedDescending {
                            if result2 == .orderedDescending {
                                self.showToast(message: "Please select time between \(takestarttime) and \(takeendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                timeselected=formattedDatetime
                                
                            }else{
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        timeselected=formattedDatetime
                                    }else{
                                        btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                    }
                                }else{
                                    
                                    
                                    btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                    
                                }
                            }
                            
                        } else if result1 == .orderedAscending {
                            if result2 == .orderedAscending{
                                self.showToast(message: "Please select time between \(takestarttime) and   \(takeendtime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                timeselected=formattedDatetime
                                
                            }else{
                                
                                if dateselected==formattedDate{
                                    if result == .orderedDescending {
                                        self.showToast(message: "Please select a time greater than \(formattedDatetime)", font: UIFont.boldSystemFont(ofSize: 12), duration: 10)
                                        timeselected=formattedDatetime
                                    }else{
                                        btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                    }
                                }else{
                                    btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                                }
                            }
                        }else{
                            btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                        }
                        //                    }
                    }else{
                        btntakeawaytimeselector.setTitle(timeselected, for: .normal)
                    }
                }
                
                // btntakeawaytimeselector.setTitle(timeselected, for: .normal)
            }else{
                
            }
            
            
            
            
            
            
            //        }
            
            
            
            
            
            
            
            //    let today_date = Date()
            //                  let dateformat = DateFormatter()
            //                  dateformat.dateFormat = "h:mm a"
            //                  dateformat.timeZone = .current
            //                 let formattedDate = dateformat.string(from: today_date)
            //    let formatteddate1=dateformat.date(from: formattedDate)!
            //    let timeselectedcompare=dateformat.date(from: timeselected)
            //     print("timeselected",timeselected)
            //    print("formatteddate1",formatteddate1)
            //   print("timeselectedcompare",timeselectedcompare)
            //   print("today_date",today_date)
            //     print("date",date)
            //print("dateselected",dateselected)
            //    var result: ComparisonResult? = nil
            //    result = formattedDate.compare(timeselected)
            
            //    if result == .orderedDescending {
            //        if date.compare(today_date) == .orderedAscending{
            //
            //        }else if date.compare(today_date) == .orderedSame{
            //
            //        }else{
            //
            //
            //            if foodtype==1{
            //                btndoordeliverydateselector.setTitle(dateselected, for: .normal)
            //                btndoordeliverytimeselector.setTitle(timeselected, for: .normal)
            //            }else if foodtype==2{
            //                btnpartorderdateselector.setTitle(dateselected, for: .normal)
            //                   btnpartyordertimeselector.setTitle(timeselected, for: .normal)
            //            }else if foodtype==3{
            //                btndateselector.setTitle(dateselected, for: .normal)
            //                 btntimeselector.setTitle(timeselected, for: .normal)
            //            }else{
            //                btntakeawaydateselector.setTitle(dateselected, for: .normal)
            //                btntakeawaytimeselector.setTitle(timeselected, for: .normal)
            //            }
            //
            //        }
            
            //    }else{
            
            
            
        }
        
        
        
        
        
        
    }





    @available(iOS 13.0, *)
    extension TakeawaypopupViewController: CLLocationManagerDelegate {
        // 2
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            // 3
            guard status == .authorizedWhenInUse else {
                return
            }
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            mapview.isMyLocationEnabled = true
            mapview.settings.myLocationButton = true
        }
        
        // 6
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else {
                return
            }
            
            let camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            // 7
            mapview.camera = camera
            
            // 8
            showMarker(position: camera.target)
            locationManager.stopUpdatingLocation()
            
        }
        
        func showMarker(position: CLLocationCoordinate2D){
            let marker = GMSMarker()
            marker.position = position
            // marker.title = "\(currentaddress)"
            print("title",marker.title)
            // marker.snippet = "San Francisco"
            marker.map = mapview
        }
    }


    @available(iOS 13.0, *)
    extension TakeawaypopupViewController: GMSMapViewDelegate {
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            reverseGeocodeCoordinate(position.target)
            
        }
        
        
    }

    @available(iOS 13.0, *)
    extension TakeawaypopupViewController: GMSAutocompleteViewControllerDelegate {
        
        // Handle the user's selection.
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            placeaddress=place.formattedAddress!
            print("placeaddress",placeaddress)
            print("Place name: \(place.name)")
            print("Place address: \(place.formattedAddress)")
            print("Place attributions: \(place.attributions)")
            lat=place.coordinate.latitude
            long=place.coordinate.longitude
            print("lat",lat)
            print("long",long)
            UserDefaults.standard.set(lat, forKey: "latitude")
            UserDefaults.standard.set(long, forKey: "longitude")
            dismiss(animated: true, completion: nil)
            autosearchcompleted()
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            // TODO: handle the error.
            print("Error: ", error.localizedDescription)
        }
        
        // User canceled the operation.
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            dismiss(animated: true, completion: nil)
        }
        
        // Turn the network activity indicator on and off again.
        func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }



