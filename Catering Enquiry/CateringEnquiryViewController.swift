//
//  CateringEnquiryViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 26/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class CateringEnquiryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {

    @IBOutlet weak var tableviewcatering: UITableView!
    @IBOutlet weak var collectionviewmenus: UICollectionView!
    var topbar=CateringtopbarCollectionViewCell()
    var tablecatering=CateringlistingTableViewCell()
    var araymenu=["Menu 1","Menu 2","Menu 3","Menu 4","Live Counter"]
    var selectedIndex=Int()
    var cell2=LivecounterTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
               let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
               navigationItem.leftBarButtonItem = btnsback

     self.tableviewcatering.register(UINib(nibName: "CateringlistingTableViewCell", bundle: nil), forCellReuseIdentifier: "CateringlistingTableViewCell")
        self.tableviewcatering.register(UINib(nibName: "LivecounterTableViewCell", bundle: nil), forCellReuseIdentifier: "LivecounterTableViewCell")
               
        
        self.collectionviewmenus.register(UINib(nibName: "CateringtopbarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CateringtopbarCollectionViewCell")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
                       {
                           super.viewWillAppear(animated)
                           
                 
      
                           let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
                           title = " Catering Enquiry"
                          
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
                    
           
       
    
    
    
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 5
          }
          
          func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              topbar = collectionView.dequeueReusableCell(withReuseIdentifier: "CateringtopbarCollectionViewCell", for: indexPath) as! CateringtopbarCollectionViewCell
            topbar.lblmenus.text=araymenu[indexPath.row]
            if selectedIndex==indexPath.row{
                topbar.lblscrolldirection.isHidden=false
                topbar.lblmenus.textColor = .red
                topbar.lblscrolldirection.backgroundColor = .red
                
               
            }else{
                topbar.lblmenus.textColor = .darkGray
                topbar.lblscrolldirection.isHidden=true
            }
            return topbar
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
              {
       
       
                      return CGSize (width: 5, height: 50)
       
       
                  }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
            selectedIndex = indexPath.row
        self.tableviewcatering.reloadData()
        self.collectionviewmenus.reloadData()
    }
    
    
    
    public func numberOfSections(in tableView: UITableView) -> Int
          {
              return 1
          }
       
       
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 1
              
          }
       
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // tablecatering = (tableView.dequeueReusableCell(withIdentifier: "CateringlistingTableViewCell", for: indexPath) as? CateringlistingTableViewCell)!
        if selectedIndex==0{
            tablecatering = (tableView.dequeueReusableCell(withIdentifier: "CateringlistingTableViewCell", for: indexPath) as? CateringlistingTableViewCell)!
            tablecatering.viewmenu1.isHidden=false
            tablecatering.viewmenu2.isHidden=true
             tablecatering.viewmenu3.isHidden=true
             tablecatering.viewmenu4.isHidden=true
            tablecatering.lblmenutype.text="MENU 1"
            return tablecatering
            
        }else if selectedIndex==1{
            tablecatering = (tableView.dequeueReusableCell(withIdentifier: "CateringlistingTableViewCell", for: indexPath) as? CateringlistingTableViewCell)!
            tablecatering.viewmenu1.isHidden=true
            tablecatering.viewmenu2.isHidden=false
             tablecatering.viewmenu3.isHidden=true
             tablecatering.viewmenu4.isHidden=true
            tablecatering.lblmenutype.text="MENU 2"
            return tablecatering
        }else if selectedIndex==2{
            tablecatering = (tableView.dequeueReusableCell(withIdentifier: "CateringlistingTableViewCell", for: indexPath) as? CateringlistingTableViewCell)!
            tablecatering.viewmenu1.isHidden=true
            tablecatering.viewmenu2.isHidden=true
             tablecatering.viewmenu3.isHidden=false
             tablecatering.viewmenu4.isHidden=true
            tablecatering.lblmenutype.text="MENU 3"
            return tablecatering
        }else if selectedIndex==3{
            tablecatering = (tableView.dequeueReusableCell(withIdentifier: "CateringlistingTableViewCell", for: indexPath) as? CateringlistingTableViewCell)!
            tablecatering.viewmenu1.isHidden=true
            tablecatering.viewmenu2.isHidden=true
             tablecatering.viewmenu3.isHidden=true
             tablecatering.viewmenu4.isHidden=false
            tablecatering.lblmenutype.text="MENU 4"
            return tablecatering
        }else{
       cell2 = (tableView.dequeueReusableCell(withIdentifier: "LivecounterTableViewCell", for: indexPath) as? LivecounterTableViewCell)!
            
        return cell2
     }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

           return 1099
       }
       
       
    @IBAction func btnenquiryaction(_ sender: Any) {
        
        
        let popvc=self.storyboard?.instantiateViewController(withIdentifier: "CateringenquirypopupViewController")as! CateringenquirypopupViewController
          
         
          
           present(popvc, animated: true, completion: nil)
        
    }
    
}
