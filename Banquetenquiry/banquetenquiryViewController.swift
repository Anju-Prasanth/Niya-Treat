//
//  banquetenquiryViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 25/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class banquetenquiryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,selectedimagedelegate{
   var banquerenquiry=BanquetenquiryTableViewCell()
    var array1=[String]()
    var array2=[String]()
    var arrayimages=[String]()
    var array3=[String]()
    var array4=[String]()
    
    @IBOutlet weak var tableviewbanquetenquiry: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          if #available(iOS 13.0, *){
                 self.isModalInPresentation = true
                }
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
      array1=["Upto 100 pax","Upto 400 pax","Conference Room"]
        array2=["Up to 100 pax,suitable for buisness meets and get togethers","Capacity Up to 400,suitable for any kind of ceremonies.","Capacity Up to 15-20 pax,suitable for any kind of meetings birthday functions"]
        array3=["https://niyaregency.com/assets/img/banquets/b1.jpg",
        "https://niyaregency.com/assets/img/banquets/b2.jpg",
        "https://niyaregency.com/assets/img/banquets/b3.jpg",
        "https://niyaregency.com/assets/img/banquets/b5.jpg",
        "https://niyaregency.com/assets/img/banquets/b11.jpg"]
        array4=["https://niyaregency.com/assets/img/banquets/conference2.jpg"]
          
       tableviewbanquetenquiry.register(UINib(nibName: "BanquetenquiryTableViewCell", bundle: nil), forCellReuseIdentifier: "BanquetenquiryTableViewCell")
    }
    
    
     override func viewWillAppear(_ animated: Bool)
                    {
                        super.viewWillAppear(animated)
                        
              
   
                        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
                        title = " Banquet Enquiry"
                       
                        lbl.text = title
                        lbl.font = UIFont.systemFont(ofSize: 20.0)
                      lbl.textColor =  UIColor.darkGray
                        lbl.textAlignment = .left
                        navigationItem.titleView=lbl
                        
                      
   
                             
                        
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
                  
                     self.navigationController?.popViewController(animated: true)
                 }
                 
        
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array1.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            banquerenquiry = (tableView.dequeueReusableCell(withIdentifier: "BanquetenquiryTableViewCell", for: indexPath) as? BanquetenquiryTableViewCell)!
        banquerenquiry.lblcapacity.text=array1[indexPath.row]
         banquerenquiry.lbldescription.text=array2[indexPath.row]
        banquerenquiry.delegate=self
        if indexPath.row==2{
          
         banquerenquiry.loadCollectionView(array: array4)
        }else{
             banquerenquiry.loadCollectionView(array: array3)
        }
        return banquerenquiry
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return 342
       }
   func selectedimage(array: [String]) {
       arrayimages=array
       
      showpopup()

   }
    func showpopup(){
        let popvc=self.storyboard?.instantiateViewController(withIdentifier: "popupimageslider")as! PopupImageSliderViewController
         
          popvc.arrayimages=arrayimages
       // popvc.enquiryimageflag=1
         
          present(popvc, animated: true, completion: nil)
    }
    
    
    @IBAction func banquetenquiryaction(_ sender: Any) {
        
        let popvc=self.storyboard?.instantiateViewController(withIdentifier:  "BanquetenquirypopupViewController")as! BanquetenquirypopupViewController
          
         
          
           present(popvc, animated: true, completion: nil)
        
    }
    

}
