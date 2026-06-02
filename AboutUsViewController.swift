//
//  AboutUsViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 30/04/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationItem.hidesBackButton = true
                  let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
                  navigationItem.leftBarButtonItem = btnsback

                
                 
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
              
              
}
