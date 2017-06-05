//
//  Thing.swift
//  R
//
//  Created by Juan Pablo Boero Alvarez on 4/6/17.
//  Copyright © 2017 jpba. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData


/// Object Mappable version of the Thing Class, since the ThingMO is the Core Data generated class for the Thing entity.
class MThing: Mappable {
    
    var title: String?
    var author: String?
    var dateUnixTimeStamp: Double?
    var thumbnailURL: String?
    var commentsCount: Double?
    var subreddit: String?
    
    required init?(map: Map){
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        title               <- map["data.title"]
        author              <- map["data.author"]
        dateUnixTimeStamp   <- map["data.created"]
        thumbnailURL        <- map["data.thumbnail"]
        commentsCount       <- map["data.num_comments"]
        subreddit           <- map["data.subreddit"]
        
    }
}
