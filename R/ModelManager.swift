//
//  ModelManager.swift
//  R
//
//  Created by Juan Pablo Boero Alvarez on 5/11/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON


class ModelManager {
    
    // One line singleton.
    static let shared = ModelManager()
    fileprivate init() {}//This prevents others from using the default '()' initializer for this class.
    
    
    /// Will provide a collection of reddits.
    func getTopReddits(onCompletion:@escaping (_ children: Children?, _ reddits: [Thing]?) -> Void) {
        
        // Try to get Cache data first.
        onCompletion(nil, CacheManager.shared.getReddits())
        
        // Standard number of reddits to retrieve
        let countDefault = 25
        
        // URL
        let URL = "https://www.reddit.com/top.json?count=\(countDefault)"
        
        Alamofire.request(URL).validate().responseJSON { response in
            switch response.result {
            case .success:
                let responseValue = response.result.value
                if let responseAny = responseValue {
                    let json = JSON(responseAny)
                    
                    if let listing = Mapper<Children>().map(JSONString: json.description) {
                        // Update Cache.
                        CacheManager.shared.setReddits(reddits: listing.reddits)
                        onCompletion(listing,listing.reddits)
                    }
                }
            case .failure(let error):
                onCompletion(nil,nil)
                print("ERROR AT \(#function), line:\(#line) \(error)")
            }
        }
    }
}
