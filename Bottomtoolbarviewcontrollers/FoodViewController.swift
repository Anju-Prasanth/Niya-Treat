//
//  FoodViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 21/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class FoodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var foodtype=Int()
    
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
           return 1
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = (tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as? FoodTableViewCell)!
               cell.btntakeaway.addTarget(self, action: #selector(btntakeawayaction), for: .touchUpInside)
        cell.btntablebooking.addTarget(self, action: #selector(btntablebookingaction), for: .touchUpInside)
        cell.btnpartyorder.addTarget(self, action: #selector(btnpartyorederaction), for: .touchUpInside)
        cell.btndoordelivery.addTarget(self, action: #selector(btndoordeliveryaction), for: .touchUpInside)
               
               return cell
    
    
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 800
            
        }
    
    
    
    
    
    
    
            
    @IBAction func btnhomeaction(_ sender: Any) {
        let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
                                
                             
            self.navigationController?.pushViewController(home, animated: true)
                      
        
    }
    
        
    @IBAction func btnenquiryaction(_ sender: Any) {
        let enquiry = self.storyboard?.instantiateViewController (withIdentifier: "EnquiryViewController") as! EnquiryViewController
                                
                             
                                self.navigationController?.pushViewController(enquiry, animated: true)
                      
    }
    @IBAction func btnroomaction(_ sender: Any) {
        let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
        home.roomactionflag=1
                                    
        self.navigationController?.pushViewController(home, animated: true)
                             
        
    }
    
    
    @objc func btntakeawayaction(_ sender: Any) {

        foodtype=4
          
          
        showpopup()
    
    }
    @objc func btntablebookingaction(_ sender: Any) {
        foodtype=3
                       
        showpopup()
    }
    
    @objc func btnpartyorederaction(_ sender: Any) {
        foodtype=2
          
        showpopup()
    }
    @objc func btndoordeliveryaction(_ sender: Any) {
        foodtype=1
                       
        showpopup()
                        
    }
    
          

func showpopup(){
    
           let takeawaypopvc = self.storyboard?.instantiateViewController (withIdentifier: "TakeawaypopupViewController") as! TakeawaypopupViewController
             
                     takeawaypopvc.modalPresentationStyle = .overCurrentContext
                     takeawaypopvc.modalTransitionStyle = .crossDissolve
                     takeawaypopvc.foodtype=foodtype
                     UserDefaults.standard.set(foodtype, forKey: "foodtype")
                     self.navigationController?.present(takeawaypopvc, animated: true,completion: nil)
       }
       
    
    
    
}
    

   
