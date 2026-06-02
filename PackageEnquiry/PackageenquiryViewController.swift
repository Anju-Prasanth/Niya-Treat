//
//  PackageenquiryViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 27/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class PackageenquiryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableviewpackageenquiry: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.hidesBackButton = true
               let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
               navigationItem.leftBarButtonItem = btnsback
               self.tableviewpackageenquiry.register(UINib(nibName: "PackageTableViewCell", bundle: nil), forCellReuseIdentifier: "PackageTableViewCell")
        self.tableviewpackageenquiry.register(UINib(nibName: "Package2TableViewCell", bundle: nil), forCellReuseIdentifier: "Package2TableViewCell")
        self.tableviewpackageenquiry.register(UINib(nibName: "Package3TableViewCell", bundle: nil), forCellReuseIdentifier: "Package3TableViewCell")
        self.tableviewpackageenquiry.register(UINib(nibName: "Package4TableViewCell", bundle: nil), forCellReuseIdentifier: "Package4TableViewCell")
       
    }
    

     override func viewWillAppear(_ animated: Bool)
                       {
                           super.viewWillAppear(animated)
                           
                 
      
                           let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
                           title = " Package Enquiry"
                          
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
           return 4
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row==0{
              let package = (tableView.dequeueReusableCell(withIdentifier: "PackageTableViewCell", for: indexPath) as? PackageTableViewCell)!
                
                return package
                
            }else if indexPath.row==1{
                let package1 = (tableView.dequeueReusableCell(withIdentifier: "Package2TableViewCell", for: indexPath) as? Package2TableViewCell)!
                               
                               return package1
            }else if indexPath.row==2{
                let package2 = (tableView.dequeueReusableCell(withIdentifier: "Package3TableViewCell", for: indexPath) as? Package3TableViewCell)!
                                              
                            return package2
            }else{
                let package3 = (tableView.dequeueReusableCell(withIdentifier: "Package4TableViewCell", for: indexPath) as? Package4TableViewCell)!
                                                             
                                           return package3
            }
          
           
          }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row==0{
            return 425
        }else if indexPath.row==1{
            return 333
        }else if indexPath.row==2{
             return 333
        }else{
            return 397
        }
             
          }

    @IBAction func btnpackageenquiryaction(_ sender: Any) {
        let popvc=self.storyboard?.instantiateViewController(withIdentifier: "PackageenquirypopupViewController")as! PackageenquirypopupViewController
                
                  present(popvc, animated: true, completion: nil)
    }
}
