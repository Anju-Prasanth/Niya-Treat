//
//  OrderconfirmationCODViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 12/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class OrderconfirmationCODViewController: UIViewController {
    
    var orderid=String()

    @IBOutlet weak var lblorderconfirmation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        lblorderconfirmation.text="Your booking successfully completed. Your booking id is"+"\(orderid)"
    }
    
    override func viewWillAppear(_ animated: Bool){
           super.viewWillAppear(animated)
        movetohome()
        
    }
    
    func movetohome(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
          DispatchQueue.main.async{
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)

                                              let sw = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController

                                              self.view.window?.rootViewController = sw

                                              let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "HomepageViewController") as! HomepageViewController


                                              let navigationController = UINavigationController(rootViewController: destinationController)



                                              sw.pushFrontViewController(navigationController, animated: true)
                                      }
        }
        
    }

   
}
