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


class NetworkManager {
    
    // One line singleton.
    static let shared = NetworkManager()
    fileprivate init() {}//This prevents others from using the default '()' initializer for this class.
    
    
    /// Will provide a collection of reddits.
    func getTopReddits(onCompletion:@escaping (_ reddits: [MThing]?) -> Void) {
        
        // Try to get Cache data first.
        onCompletion(CacheManager.shared.getReddits())
        
        // Standard number of reddits to retrieve
        let countDefault = 25
        
        // URL
        let URL = "https://www.reddit.com/top.json?count=\(countDefault)"
        
        Alamofire.request(URL).validate().responseJSON { response in
            switch response.result {
            case .success:
                let responseValue = response.result.value
                if let responseAny = responseValue as? [String: Any] {
                    let json = JSON(responseAny["data"] as Any)
                    let objectData = json["children"].arrayObject
                    if let reddits = Mapper<MThing>().mapArray(JSONObject: objectData) {
                        // Update Cache.
                        CacheManager.shared.setReddits(reddits: reddits)
                        onCompletion(reddits)
                    }
                }
            case .failure(let error):
                onCompletion(nil)
                print("ERROR AT \(#function), line:\(#line) \(error)")
            }
        }
    }
}
