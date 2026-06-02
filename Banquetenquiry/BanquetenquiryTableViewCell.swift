//
//  BanquetenquiryTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 25/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
protocol selectedimagedelegate{
    
    func selectedimage(array:[String])
}


class BanquetenquiryTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var lblcapacity: UILabel!
    
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var collectionviewimagebanquet: UICollectionView!
    var collectionviewcell=BanquetenquiryimagesCollectionViewCell()
    var timer=Timer()
    var array=[String]()
    
     var counter=0

    var delegate:selectedimagedelegate!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionviewimagebanquet.delegate=self
       collectionviewimagebanquet.dataSource=self
        Outerview.layer.cornerRadius=10
        collectionviewimagebanquet.layer.cornerRadius=10
        self.collectionviewimagebanquet.register(UINib(nibName: "BanquetenquiryimagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BanquetenquiryimagesCollectionViewCell")
       
        DispatchQueue.main.async {
        self.timer=Timer.scheduledTimer(timeInterval: 3.0, target: self, selector:          #selector(self.changeimage), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func changeimage(){
    
           if counter<array.count{
               let index=IndexPath.init(item: counter, section: 0)
               self.collectionviewimagebanquet.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
               counter += 1
           }else{
               counter=0
               let index=IndexPath.init(item: counter, section: 0)
                self.collectionviewimagebanquet.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
               counter=1
           
           }
    }
    
    
    
    func loadCollectionView(array:[String]) {
       self.array = array
        print("array",array)
       self.collectionviewimagebanquet.reloadData()
    }
    
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
              return 1
          }
          
          func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
                return array.count
            
    }
          
          func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            collectionviewcell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanquetenquiryimagesCollectionViewCell", for: indexPath) as! BanquetenquiryimagesCollectionViewCell
              
           
               
              let url = URL(string:array[indexPath.row])
              collectionviewcell.imageviewbanquets.kf.indicatorType = .activity
              collectionviewcell.imageviewbanquets.kf.setImage(with: url)
              collectionviewcell.imageviewbanquets.contentMode = .scaleToFill
               
          
              return collectionviewcell
          }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        var array2=[String]()
       
            array2 = array
        
          
           delegate?.selectedimage(array: array2 as [String])
           
       }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension BanquetenquiryTableViewCell:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size=collectionviewimagebanquet.frame.size
        return CGSize(width: size.width, height: size.height)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0.0
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0.0
        
    }

    
    
}
