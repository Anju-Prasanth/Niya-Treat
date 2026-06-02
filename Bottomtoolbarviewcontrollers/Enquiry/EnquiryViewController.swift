//
//  EnquiryViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 23/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class EnquiryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableviewenquiry: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
                   menuButton.target = self.revealViewController()
                   menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                  // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

               }
    }
 
    

      override func viewWillAppear(_ animated: Bool){
                 super.viewWillAppear(animated)
           

                     let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 150, height: 35))
                      imageView.contentMode = .scaleAspectFit

                       let image = UIImage(named: "Group 2")
                       imageView.image = image

                       navigationItem.titleView = imageView

                 }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row==0{
        let cell = (tableView.dequeueReusableCell(withIdentifier: "BanquetTableViewCell", for: indexPath) as? BanquetTableViewCell)!
            cell.btnbanquetenquiry.addTarget(self, action: #selector(btnbanquetenquiry), for: .touchUpInside)
            
            return cell
            
        }else if indexPath.row==1{
            let cell1 = (tableView.dequeueReusableCell(withIdentifier: "CateringTableViewCell", for: indexPath) as? CateringTableViewCell)!
             cell1.btncateringenquiry.addTarget(self, action: #selector(btncateringenquiry), for: .touchUpInside)
                    return cell1
        }else{
            let cell3 = (tableView.dequeueReusableCell(withIdentifier: "PackageenquiryTableViewCell", for: indexPath) as? PackageenquiryTableViewCell)!
             cell3.btnpackageenquiry.addTarget(self, action: #selector(btnpackageenquiry), for: .touchUpInside)
            return cell3
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row==0{
        return 141
        }else if indexPath.row==1{
            return 163
        }else{
           return 158
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func btnhomeaction(_ sender: Any) {
        let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
                  
               
                  self.navigationController?.pushViewController(home, animated: true)
        
    
    }
    
    
    @IBAction func btnroomaction(_ sender: Any) {
        
        let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
        home.roomactionflag=1
                      
                         self.navigationController?.pushViewController(home, animated: true)
        
    }
    
    
    
    @IBAction func btnfoodaction(_ sender: Any) {
        let food = self.storyboard?.instantiateViewController (withIdentifier: "FoodViewController") as! FoodViewController
                  
               
                  self.navigationController?.pushViewController(food, animated: true)
        
    }
    
    
    
    
    @objc func btnbanquetenquiry(_ sender: UIButton) {
        
        
        let banquetenquiry = self.storyboard?.instantiateViewController (withIdentifier: "banquetenquiryViewController") as! banquetenquiryViewController
                   self.navigationController?.pushViewController(banquetenquiry, animated: true)
    }
    
    @objc func btncateringenquiry(_ sender: Any) {
    
    let cateringenquiry = self.storyboard?.instantiateViewController (withIdentifier: "CateringEnquiryViewController") as! CateringEnquiryViewController
                   self.navigationController?.pushViewController(cateringenquiry, animated: true)
                 
             }
          
       
    
    @objc func btnpackageenquiry(_ sender: Any) {
        let packageenquiry = self.storyboard?.instantiateViewController (withIdentifier: "PackageenquiryViewController") as! PackageenquiryViewController
          self.navigationController?.pushViewController(packageenquiry, animated: true)
        
        
    }
    
}
