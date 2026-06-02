//
//  PackageenquirypopupViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 01/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import iOSDropDown

class PackageenquirypopupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var tableviewpopuppackageenquiry: UITableView!
    var cell=PopupTableViewCell()
     var packagearray=[String]()
    var timeflag=Int()
       var selectionflag=Int()
       var dateselected=String()
       var timeselected=String()
       var formattedDate=String()
       var dismissViewTap: UITapGestureRecognizer!
       
    override func viewDidLoad() {
        super.viewDidLoad()

       packagearray=["Guruvayoor Temple Package","Special Corporate Offer Single Occupancy","Special Corporate Offer Double Occupancy","Athirapilly Vazhachal Tour Packages"]
        
   tableviewpopuppackageenquiry.register(UINib(nibName: "PopupTableViewCell", bundle: nil), forCellReuseIdentifier: "PopupTableViewCell")
             let today_date = Date()
                                 let format = DateFormatter()
                                 format.dateFormat = "dd-MM-yyy"
                                 format.timeZone = .current
                               formattedDate = format.string(from: today_date)
                         dateselected=formattedDate
                   
                    
                     let timeformatter=DateFormatter()
                            timeformatter.dateFormat="hh:mm a"
                            timeformatter.timeZone = .current
                             let formattedtime = timeformatter.string(from: today_date)
                    timeselected=formattedtime
                    
              view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                    // dismissViewTap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
                    
      
        
       // view.addGestureRecognizer(dismissViewTap)
               
                 
                        
             }
             @objc func dismissView(){
               
                
            
                  self.dismiss(animated: true, completion: nil)
                
                }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             cell = (tableView.dequeueReusableCell(withIdentifier: "PopupTableViewCell", for: indexPath) as? PopupTableViewCell)!
           
           
            cell.txtfldstarttime.inputView = UIView()
                        cell.txtfldstarttime.inputAccessoryView = UIView()
                       cell.txtfldendtime.inputView = UIView()
                       cell.txtfldendtime.inputAccessoryView = UIView()
                       cell.txtfldstartdate.inputView = UIView()
                       cell.txtfldstartdate.inputAccessoryView = UIView()
                       cell.txtfldendadte.inputView = UIView()
                       cell.txtfldendadte.inputAccessoryView = UIView()
            
        
            
            if selectionflag==1{
                if timeflag==1{
                   cell.txtfldstarttime.text=timeselected
                }
                  
               }else if selectionflag==2{
                 if timeflag==1{
                     cell.txtfldendtime.text=timeselected
                }
                  
               }else if selectionflag==3{
                if timeflag==0{
                    cell.txtfldstartdate.text=dateselected
                }
                   
               }else if selectionflag==4{
                if timeflag==0{
                   cell.txtfldendadte.text=dateselected
                }
                  
            }else{
                cell.txtfldstarttime.text=timeselected
                         cell.txtfldendtime.text=timeselected
                         cell.txtfldstartdate.text=dateselected
                         cell.txtfldendadte.text=dateselected
            }
               
            cell.txtfldpackage.delegate=self
            
             cell.txtfldpackage.optionArray=packagearray
          
            
            if cell.txtfldpackage.text?.isEmpty==true{
            cell.txtfldpackage.text="  Guruvayur Temple Package"
                   }
          
            
            cell.txtfldpackage.didSelect{(selectedText , index ,id) in
               let package = "Selected String: \(selectedText) \n index: \(index)"
                
            }
            
            
            cell.txtfldstarttime.delegate=self
                         cell.txtfldendtime.delegate=self
                         cell.txtfldstartdate.delegate=self
                         cell.txtfldendadte.delegate=self
            
            
            cell.txtfldstarttime.addTarget(self, action: #selector(starttime), for: .allEvents)
              cell.txtfldendtime.addTarget(self, action: #selector(endtime), for: .allEvents)
              cell.txtfldstartdate.addTarget(self, action: #selector(startdate), for: .allEvents)
              cell.txtfldendadte.addTarget(self, action: #selector(enddate), for: .allEvents)
            cell.btnsubmitt.addTarget(self, action: #selector(btnsubmit(sender:)), for: .touchUpInside)
        
        return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 566
           }
         @objc func starttime(sender: UITextField){
            timeflag=1
            selectionflag=1
            showCalendar()
        }
        @objc func endtime(sender: UITextField){
            timeflag=1
            selectionflag=2
            showCalendar()
           }
        @objc func startdate(sender: UITextField){
             timeflag=0
            selectionflag=3
            showCalendar()
           }
        @objc func enddate(sender: UITextField){
             timeflag=0
            selectionflag=4
            showCalendar()
           }
        
        
        
        func showCalendar() {
            
            let selector = WWCalendarTimeSelector.instantiate()
            selector.delegate = self
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
            present(selector, animated: true, completion: nil)
        }
        
        
        
    @IBAction func btnoutsidetableviewtapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }


   
        
        
        
            func service_package_enquiry(){
                
                    guard let url=NSURL(string :"https://niyaregency.com/api/Data/package_enquiry")else{return}
                let poststring="name=\(cell.txtfldname.text!)&email=\(cell.txtfldemail.text!)&mobile=\(cell.txtfldphonenumber.text!)&package=\(cell.txtfldpackage.text!)&start_date=\(cell.txtfldstartdate.text!)&end_date=\(cell.txtfldendadte.text!)&start_time=\(cell.txtfldstarttime.text!)&end_time=\(cell.txtfldendtime.text!)"
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
                                                       let jsonarray = try JSONSerialization.jsonObject(with:data!, options: .allowFragments)as? [String:AnyObject]
                                   //                       if let parseJson = jsonarray{
                                                       let status=jsonarray!["status"] as! Bool
                                                             if status==true{
                                                                DispatchQueue.main.async {
                                                                    self.showToast(message: "Mail send successfully", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                                                   self.dismiss(animated: true, completion: nil)
                                                           }
                                                          
                                                           }
                                   //                       }else{
                                   //                              DispatchQueue.main.async {
                                   //                              self.showToast(message: "Error in fetching details", font: UIFont.boldSystemFont(ofSize: 14))
                                   //                              }
                                   //                              }
                                                      }
                                                         
                                                                          catch {
                                                                          print(error)
                                                                          }
                                                                                                        
                                                                 }.resume()
                                                             }
                                             

            
        
        
        
        
        
        
        
        
        
    @objc func btnsubmit(sender:UIButton){
            
            if cell.txtfldname.text?.isEmpty==true||cell.txtfldemail.text?.isEmpty==true||cell.txtfldphonenumber.text?.isEmpty==true||cell.txtfldpackage.text?.isEmpty==true||cell.txtfldstartdate.text?.isEmpty==true||cell.txtfldendadte.text?.isEmpty==true||cell.txtfldstarttime.text?.isEmpty==true||cell.txtfldendtime.text?.isEmpty==true{
                       DispatchQueue.main.async {
                        self.showToast(message: "All fields are mandatory", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                                              }
                       
                       
                   }else{
                       service_package_enquiry()
                       
                   }
            
            
        }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField==cell.txtfldstarttime||textField==cell.txtfldendtime||textField==cell.txtfldstartdate||textField==cell.txtfldendadte{
//               return false
//           }else{
//           return true
//           }
//    }
    
    func scrollToFirstRow() {
              let indexPath = NSIndexPath(row: 0, section: 0)
              self.tableviewpopuppackageenquiry.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
          }
    
    
}
        
        
    
extension PackageenquirypopupViewController: WWCalendarTimeSelectorProtocol{
    
    func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {

        let today_date = Date()
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyy"
            format.timeZone = .current



        if date.compare(today_date) == .orderedAscending{
            return false
        }else{
            return true
        }

    }


    
    
    

   func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
       print("Selected Date- \(date)")
     var result: ComparisonResult? = nil
//     dateselected = date.stringFromFormat("dd-MM-yyy")
//     timeselected = date.stringFromFormat(" h:mm a")
//
    
    
if timeflag==0{

   dateselected = date.stringFromFormat("dd-MM-yyy")
   }else{
        timeselected = date.stringFromFormat("h:mm a")
   
       let today_date = Date()
      let dateformat = DateFormatter()
                         dateformat.dateFormat = "h:mm a"
                         dateformat.timeZone = .current
                        let formattedDate = dateformat.string(from: today_date)
           let formatteddate1=dateformat.date(from: formattedDate)!
           let timeselectedcompare=dateformat.date(from: timeselected)
            print("timeselected",timeselected)
           print("formatteddate1",formatteddate1)
          print("timeselectedcompare",timeselectedcompare)
          print("today_date",today_date)
            print("date",date)
       print("dateselected",dateselected)

       result = formatteddate1.compare(timeselectedcompare!)


   }
    if selectionflag==3{
        if cell.txtfldstartdate.text==formattedDate && result == .orderedDescending{
                self.showToast(message: "Time not valid", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
//    if result == .orderedDescending {
//        self.showToast(message: "Time not valid", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
    }else{
        scrollToFirstRow()
        
             self.tableviewpopuppackageenquiry.reloadData()
        }
//    }
    }else if selectionflag==4 {
    if cell.txtfldendadte.text==formattedDate && result == .orderedDescending{
    self.showToast(message: "Time not valid", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
                  
//       if result == .orderedDescending {
//           self.showToast(message: "Time not valid", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
       }else{
        scrollToFirstRow()
        
             self.tableviewpopuppackageenquiry.reloadData()
        }
//        }
    }else if selectionflag==1{
        if cell.txtfldstartdate.text==formattedDate  && result == .orderedDescending{
                    self.showToast(message: "Time not valid", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
//        if result == .orderedDescending {
//            self.showToast(message: "Time not valid", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
        }else{
            scrollToFirstRow()
            
                 self.tableviewpopuppackageenquiry.reloadData()
            }
//        }
        }else if selectionflag==2{
            
            if cell.txtfldendadte.text==formattedDate  && result == .orderedDescending{
                     self.showToast(message: "Time not valid", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
//            if result == .orderedDescending {
//                self.showToast(message: "Time not valid", font: UIFont.boldSystemFont(ofSize: 14), duration: 2)
            }else{
             scrollToFirstRow()
             
                  self.tableviewpopuppackageenquiry.reloadData()
             }
//             }
            
            
            
            
        }
        
        
        
        
//       print("selectionflag",selectionflag)
//       scrollToFirstRow()
//
//           self.tableviewpopuppackageenquiry.reloadData()
    
       
   }
//    }

    
    
}


