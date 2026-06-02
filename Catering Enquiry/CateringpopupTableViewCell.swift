//
//  CateringpopupTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 02/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import iOSDropDown

protocol selectedmenudelegate{
    
    func selectedcollectioncell(packageid:String)
}

class CateringpopupTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate{

    @IBOutlet weak var btnsubmitt: UIButton!
    @IBOutlet weak var txtfldpax: UITextField!
    @IBOutlet weak var collectionviewselectmenu: UICollectionView!
    @IBOutlet weak var txtfldendadte: UITextField!
        @IBOutlet weak var txtfldstartdate: UITextField!
        @IBOutlet weak var txtfldendtime: UITextField!
        @IBOutlet weak var txtfldstarttime: UITextField!
       
        @IBOutlet weak var txtfldoccassion: DropDown!
        @IBOutlet weak var txtfldemail: UITextField!
        @IBOutlet weak var txtfldphonenumber: UITextField!
        @IBOutlet weak var txtfldname: UITextField!
      var packageidarray=[String]()
      var namearray=[String]()
      var pricearray=[String]()
    
    
    var selectmenu=SelectmenuCollectionViewCell()
     var delegate:selectedmenudelegate!
    
    
        override func awakeFromNib() {
            super.awakeFromNib()
            
            
            collectionviewselectmenu.delegate=self
            collectionviewselectmenu.dataSource=self
            
           txtfldoccassion.layer.cornerRadius=5
                   txtfldoccassion.layer.borderWidth=1
                   txtfldoccassion.layer.borderColor = UIColor.lightGray.cgColor
                   txtfldendadte.layer.cornerRadius=5
                   txtfldendadte.layer.borderWidth=1
                   txtfldendadte.layer.borderColor = UIColor.lightGray.cgColor
                   txtfldstartdate.layer.cornerRadius=5
                   txtfldstartdate.layer.borderWidth=1
                   txtfldstartdate.layer.borderColor = UIColor.lightGray.cgColor
                   txtfldendtime.layer.cornerRadius=5
                   txtfldendtime.layer.borderWidth=1
                   txtfldendtime.layer.borderColor = UIColor.lightGray.cgColor
                   txtfldstarttime.layer.cornerRadius=5
                   txtfldstarttime.layer.borderWidth=1
                   txtfldstarttime.layer.borderColor = UIColor.lightGray.cgColor
                   txtfldemail.layer.cornerRadius=5
                   txtfldemail.layer.borderWidth=1
                   txtfldemail.layer.borderColor = UIColor.lightGray.cgColor
                   txtfldphonenumber.layer.cornerRadius=5
                          txtfldphonenumber.layer.borderWidth=1
                          txtfldphonenumber.layer.borderColor = UIColor.lightGray.cgColor
                   txtfldname.layer.cornerRadius=5
                          txtfldname.layer.borderWidth=1
                          txtfldname.layer.borderColor = UIColor.lightGray.cgColor
            txtfldpax.layer.cornerRadius=5
                                     txtfldpax.layer.borderWidth=1
                                     txtfldpax.layer.borderColor = UIColor.lightGray.cgColor
            
            
            
            self.collectionviewselectmenu.register(UINib(nibName: "SelectmenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SelectmenuCollectionViewCell")
            service_outdoor_banquets()
          
        }
    
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
             return 1
         }
         
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
            return packageidarray.count-1
         }
         
         
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
             selectmenu = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectmenuCollectionViewCell", for: indexPath) as! SelectmenuCollectionViewCell
             selectmenu.lblmenu.text=namearray[indexPath.row]
             selectmenu.lblprice.text="Price Rs."+pricearray[indexPath.row]+" /-"
            selectmenu.btncheckbox.tag=indexPath.row
            selectmenu.btncheckbox.addTarget(self, action: #selector(btncheckbox(sender: )), for: .touchUpInside)
            
            return selectmenu
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
      
       // delegate.selectedcollectioncell(array: array2 as [String])
        
    }
    
    @objc func btncheckbox(sender: UIButton){
        
        if sender.isSelected==true{
            sender.isSelected=false
             sender.setImage(UIImage (named: "icons8-unchecked-checkbox-24"), for: .normal)
        }else{
            sender.isSelected=true
            sender.setImage(UIImage (named: "icons8-checked-checkbox-24"), for: .normal)
        }
//            if(sender.currentImage == UIImage (named: "icons8-unchecked-checkbox-24"))
//               {
//                  sender.setImage(UIImage (named: "icons8-checked-checkbox-24"), for: .normal)
//               }
//               else{
//                   sender.setImage(UIImage (named: "icons8-unchecked-checkbox-24"), for: .normal)
//               }
       
            
        
       // self.collectionviewselectmenu.reloadData()
        delegate.selectedcollectioncell(packageid: packageidarray[sender.tag] as String)
               
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize (width: 194, height: 97)
        
    }
    
    
    
    func service_outdoor_banquets(){
                      
                guard let url=NSURL(string :"https://niyaregency.com/api/Data/outdoor_banquets")else{return}
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
                               let products=parseJson["Products"]as! NSDictionary
                               let packages=products["packages"]as! NSArray
                                   for value in packages{
                                       let item:[String:String]=value as! [String:String]
                                        let bpackage_id=item["bpackage_id"]as! String
                                        let name=item["name"]as! String
                                        let price=item["price"]as! String
                                       self.packageidarray.append(bpackage_id)
                                        self.namearray.append(name)
                                        self.pricearray.append(price)
                                       
                                       
                                   }
                               
                                  
                                  DispatchQueue.main.async {
                                      self.collectionviewselectmenu.reloadData()
                                  }
                              
                              
                              }else{
                                     DispatchQueue.main.async {
       //                              self.showToast(message: "Error in fetching details", font: UIFont.boldSystemFont(ofSize: 14))
                                     }
                                     }
                                 }
                             
                                              catch {
                                              print(error)
                                              }
                                                                            
                                     }.resume()
                                 }
           

    

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
    
    
    
    }
