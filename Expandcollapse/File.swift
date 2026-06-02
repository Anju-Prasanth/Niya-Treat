//
//  File.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 14/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import Foundation
import  AlamofireObjectMapper
import ObjectMapper

class ExpandableResponse: Mappable{
    var status: Bool?
    var message: String?
    var products:Products1?
   // var totalproducts:[Products]?
     
   
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        products  <- map["products"]
       // totalproducts <- map["products.products"]
    }
}

class Products1: Mappable {
    var products:[totalproductsexpandable]?
      

    required init?(map: Map){

    }
    func mapping(map: Map) {
       
     products <- map["products"]
      

    }
}

class totalproductsexpandable: Mappable {
    var grp_sub_category_name: String?
    var grp_sub_category_id :String?
    var count_value:String?
    var selection_flag:String?
    var sub: [subcategoriesexpandable]?

    required init?(map: Map){

    }
    func mapping(map: Map) {

    grp_sub_category_name <- map["grp_sub_category_name"]
    grp_sub_category_id <- map["grp_sub_category_id"]
    count_value <- map["count_value"]
    selection_flag <- map["selection_flag"]
    sub <- map["sub"]
    }
}



class subcategoriesexpandable: Mappable {
    var grp_food_item_name: String?
    var grp_food_item_id:String?


    required init?(map: Map){

    }
    func mapping(map: Map) {
        grp_food_item_name <- map["grp_food_item_name"]
        grp_food_item_id <- map["grp_food_item_id"]


    }
}

