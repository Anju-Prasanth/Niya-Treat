//
//  DateselectionViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 19/12/19.
//  Copyright © 2019 Arun Vijayan. All rights reserved.
//

import UIKit
import FSCalendar


@available(iOS 13.0, *)
class DateselectionViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource  {
   
    @IBOutlet weak var checkin: UILabel!
    @IBOutlet weak var lblcheckoutyear: UILabel!
    @IBOutlet weak var lblcheckinyear: UILabel!
    
    @IBOutlet weak var checkout: UILabel!
    @IBOutlet weak var lblchekoutweekday: UILabel!
    @IBOutlet weak var lblcheckoutmonth: UILabel!
    @IBOutlet weak var lblcheckoutday: UILabel!
    @IBOutlet weak var lblcheckinweekday: UILabel!
    @IBOutlet weak var lblcheckinmonth: UILabel!
    @IBOutlet weak var lblcheckinday: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
   var myday=String()
    var nextmyday=String()
    var selectedday=String()
    var selectedweekday=Int()
    var selectedmonth=String()
    var selectedyear=String()
    var nextday=String()
    var nextselectedweekday=Int()
    var nextselectedmonth=String()
    var nextselectedyear=String()
    var datearray=[String]()
    var checkoutflag=0
    
    var totaladultfromhome=Int()
     var totalchildfromhome=Int()
     var totalroomfromhome=Int()
    var totalnumbersfromhome=Int()
    var applyflagfromroom=Int()
    
     var childtempvaluearray=[Int]()
     var adulttempvaluaearray=[Int]()
     var totalroomcountarray=[Int]()
     var roomcountarraydateselection=[Int]()
    
     var applyflagfromdateselection=Int()
    var roomflag=Int()
   
    
    
   

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         calendar.delegate=self
            calendar.dataSource=self
            calendar.scrollDirection = .vertical
            //calendar.allowsSelection=true
         self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
        lblcheckinday.text=selectedday
           lblcheckinmonth.text=selectedmonth
          lblcheckinyear.text=selectedyear
           lblcheckinweekday.text=myday
           
           lblcheckoutday.text=nextday
           lblcheckoutmonth.text=nextselectedmonth
           lblcheckoutyear.text=nextselectedyear
           lblchekoutweekday.text=nextmyday
        calendar.appearance.todayColor = .darkGray
       
    }
    
    override func viewWillAppear(_ animated: Bool)
          {
              super.viewWillAppear(animated)
           
           
                  self.navigationController?.navigationBar.barTintColor = .white
           //self.navigationController?.navigationBar.isTranslucent = false
//           let height: CGFloat = 100//whatever height you want
//           let bounds = self.navigationController!.navigationBar.bounds
//           self.navigationController?.navigationBar.frame = CGRect(x: 0, y: ((UIApplication.shared.statusBarView?.frame.height)!)+10, width: bounds.width, height:(UIApplication.shared.statusBarView?.frame.height)! + height)
              let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
              title = "Select Dates"
             
              lbl.text = title
              lbl.font = UIFont.systemFont(ofSize: 21.0)
            lbl.textColor =  UIColor.darkGray
              lbl.textAlignment = .left
              navigationItem.titleView=lbl
                  
              
          }
       
       
       override func viewWillDisappear(_ animated: Bool) {
           
               
//               let height: CGFloat = 100//whatever height you want
//               let bounds = self.navigationController!.navigationBar.bounds
//               self.navigationController?.navigationBar.frame = CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.height)!, width: bounds.width, height:(UIApplication.shared.statusBarView?.frame.height)! + height)
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
           // Perform your custom actions
           // ...
           // Go back to the previous ViewController
           self.navigationController?.popViewController(animated: true)
       }
       
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
         let newDate = date.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
        print("newDate",newDate)
        let today_date = Date()
                        let format = DateFormatter()
                        format.dateFormat = "dd MMM yyy"
                        format.timeZone = .current
                        format.locale = .current
       
        print("today_date",today_date)



        if newDate.compare(today_date) == .orderedAscending{
                   return false
        }else if newDate.compare(today_date) == .orderedDescending{
                   return true
               }else if newDate.compare(today_date) == .orderedSame{
            return true
        }else{
           return false
        }


    }
    
    
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
  
   
   let newDate = date.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
   print("newDate",newDate)
                 
                 print("\(date)")
                 let today_date = Date()
                 let format = DateFormatter()
                 format.dateFormat = "dd MMM yyy"
                 format.timeZone = .current
                 let formattedDate = format.string(from: newDate)
                 let todaydate=format.string(from: today_date)
                 let chosendate=formattedDate
                 print("today_date: ",format.string(from: today_date))
                 print("chosen_date: ",formattedDate)
                 format.dateFormat = "dd MMM yyy"

            
            
               
                   
                let daysToAdd = 1
                let weekdaytoadd=1
                var dateComponent = DateComponents()
                dateComponent.day = daysToAdd
//                dateComponent.weekday=weekdaytoadd
                
                  
                    
             let futureDate = Calendar.current.date(byAdding: dateComponent, to: newDate)!
            print("futureDate",futureDate)
          
    
            let currentDate = Date()
    
            let formattedcurrentdate=format.string(from: currentDate)
             let formattedfuturedate=format.string(from: futureDate)
    
//      if date<today_date||date>futureDate{
//
//     // self.showToastfordate(message: "Please select a date between" + "\(formattedcurrentdate)" + "and" + "\(String(describing: formattedfuturedate))", font: UIFont.boldSystemFont(ofSize: 14))
//        self.showToastfordate(message: "Please select a date after " + "\(formattedcurrentdate)", font: UIFont.boldSystemFont(ofSize: 14))
//     calendar.deselect(date)
//
//    }else{
//
     datearray.append(formattedDate)
              
                 print("formattedDate",formattedfuturedate)
                 calendar.appearance.weekdayTextColor = .black
                 
    
                  let calendar = Calendar.current
                   selectedday=String(calendar.component(.day, from: newDate))
                   selectedweekday=calendar.component(.weekday, from: newDate)
                   selectedyear=String(calendar.component(.year, from: newDate))
                 
                  nextday=String(calendar.component(.day, from: futureDate))
                  nextselectedweekday=calendar.component(.weekday, from: futureDate)
                  nextselectedyear=String(calendar.component(.year, from: futureDate))
    
                 format.dateFormat="MMM"
                  selectedmonth=format.string(from: newDate)
    
                  nextselectedmonth=format.string(from: futureDate)
                 
    
                 
                
                    if selectedweekday==1{
                     myday="sunday"
                      }else if selectedweekday==2{
                     myday="Monday"
                     }else if selectedweekday==3{
                     myday="Tuesday"
                     }else if selectedweekday==4{
                     myday="Wednesday"
                     }else if selectedweekday==5{
                     myday="Thursday"
                     }else if selectedweekday==6{
                     myday="Friday"
                     }else{
                     myday="Saturday"
                     }
    
                  if nextselectedweekday==1{
                        nextmyday="sunday"
                         }else if nextselectedweekday==2{
                        nextmyday="Monday"
                        }else if nextselectedweekday==3{
                        nextmyday="Tuesday"
                        }else if nextselectedweekday==4{
                        nextmyday="Wednesday"
                        }else if nextselectedweekday==5{
                        nextmyday="Thursday"
                        }else if nextselectedweekday==6{
                        nextmyday="Friday"
                        }else{
                        nextmyday="Saturday"
                        }
    
    
    
     
    
    if checkoutflag==0{
    
    lblcheckinday.text=selectedday
    lblcheckinmonth.text=selectedmonth
    lblcheckinyear.text=selectedyear
    lblcheckinweekday.text=myday
    
    lblcheckoutday.text=nextday
    lblcheckoutmonth.text=nextselectedmonth
    lblcheckoutyear.text=nextselectedyear
    lblchekoutweekday.text=nextmyday
        
        
    }else{
        
        lblcheckoutday.text=selectedday
        lblcheckoutmonth.text=String(selectedmonth)
        lblcheckoutyear.text=String(selectedyear)
        lblchekoutweekday.text=myday
        lblcheckoutday.textColor=UIColor.red
        checkout.textColor=UIColor.red
        lblcheckinday.textColor=UIColor.darkGray
        checkin.textColor=UIColor.darkGray
    
    }
    
//    }
     
    }
    
           
           
           
           
           func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
            
            
            let newDate = date.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
              print("newDate",newDate)
               print("\(date)")
                           let today_date = Date()
                           let format = DateFormatter()
                           format.dateFormat = "dd-MM-yyy"
                           format.timeZone = .current
                           let formattedDate = format.string(from: newDate)
                           print("today_date: ",format.string(from: today_date))
                           print("deselectdate: ",formattedDate)
                           
                           format.dateFormat = "dd-MM-yy"
                          format.dateFormat="dd"
                          let day=format.string(from: newDate)
                           
                           print("formattedDate",formattedDate)
              
                        
                           calendar.appearance.weekdayTextColor = .black
                         //  calendar.appearance.todayColor = .orange
           }
    
    
    
    @IBAction func btnapplyaction(_ sender: Any) {
        
        if datearray.count==0{
             self.showToastfordate(message: "Please select a date to continue", font: UIFont.boldSystemFont(ofSize: 15))
        }else if checkoutflag==0{
        let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
        home.applyflag=1
        home.currentday=selectedday
        home.myday=myday
        home.currentmonth=selectedmonth
        home.currentyear=selectedyear
        home.nextday=nextday
        home.nextmyday=nextmyday
        home.nextmonth=nextselectedmonth
        home.nextyear=nextselectedyear
        home.totaladult=totaladultfromhome
        home.totalchild=totalchildfromhome
        home.totalrooms=totalroomfromhome
        home.childtempvaluearrayhome=childtempvaluearray
            home.adulttempvaluearrayhome=adulttempvaluaearray
            home.totalroomcuontarrayhome=totalroomcountarray
            home.roomcountarrayhome=roomcountarraydateselection
        home.applyflagfromroomguests=applyflagfromroom
             home.roomactionflag=roomflag
        //home.totalrooms=totalroomfromhome
        
            
            UserDefaults.standard.set(selectedday, forKey: "checkinday")
                  UserDefaults.standard.set(myday, forKey: "checkinweekday")
                  UserDefaults.standard.set(selectedmonth, forKey: "checkinmonth")
                  UserDefaults.standard.set(selectedyear, forKey: "checkinyear")
                  UserDefaults.standard.set(nextday, forKey: "checkoutday")
                  UserDefaults.standard.set(nextmyday, forKey: "checkoutweekday")
                  UserDefaults.standard.set(nextselectedmonth, forKey: "checkoutmonth")
                  UserDefaults.standard.set(nextselectedyear, forKey: "checkoutyear")
            print(selectedday)
            self.navigationController?.pushViewController(home, animated: true)
            
            
        }else{
            let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
            home.applyflag=1
            home.nextday=selectedday
            home.nextmyday=myday
            home.nextmonth=selectedmonth
            home.nextyear=selectedyear
            home.currentday=lblcheckinday.text!
            home.myday=lblcheckinweekday.text!
            home.currentmonth=lblcheckinmonth.text!
            home.currentyear=lblcheckinyear.text!
            home.totaladult=totaladultfromhome
            home.totalchild=totalchildfromhome
            home.totalrooms=totalroomfromhome
            home.childtempvaluearrayhome=childtempvaluearray
            home.adulttempvaluearrayhome=adulttempvaluaearray
            home.totalroomcuontarrayhome=totalroomcountarray
            home.roomcountarrayhome=roomcountarraydateselection
            home.applyflagfromroomguests=applyflagfromroom
            home.roomactionflag=roomflag
        
            
            UserDefaults.standard.set(selectedday, forKey: "checkoutday")
                   UserDefaults.standard.set(myday, forKey: "checkoutweekday")
                   UserDefaults.standard.set(String(selectedmonth), forKey: "checkoutmonth")
                   UserDefaults.standard.set(String(selectedyear), forKey: "checkoutyear")
            self.navigationController?.pushViewController(home, animated: true)
            
        }
        
        UserDefaults.standard.set(1, forKey: "applyflag")
       
        
        
        
        
    }
    
           

}


@available(iOS 13.0, *)
extension DateselectionViewController {

func showToastfordate(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/4 - 85, y: self.view.frame.size.height-150, width: UIScreen.main.bounds.width-30, height: 50))
    //toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.backgroundColor = UIColor.darkGray
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 5;
    toastLabel.clipsToBounds  =  true
    toastLabel.numberOfLines=2
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.5, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

