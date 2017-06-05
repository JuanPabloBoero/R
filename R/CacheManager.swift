//
//  CacheManager.swift
//  R
//
//  Created by Juan Pablo Boero Alvarez on 5/11/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import Foundation

class CacheManager {
    
    // One line singleton.
    static let shared = CacheManager()
    fileprivate init() {}//This prevents others from using the default '()' initializer for this class.
    
    /// Retrieve persisted reddits.
    func getReddits() -> [Thing]? {
        let childrenData = UserDefaults.standard.value(forKey: "persistedChildren") as? Data
        if let childrenData = childrenData {
            return NSKeyedUnarchiver.unarchiveObject(with: childrenData) as? [Thing]
        }
        return nil
    }
    
    /// Persist reddits.
    func setReddits(reddits: [Thing]?) {
        if let reddits = reddits {
            let dataObject = NSKeyedArchiver.archivedData(withRootObject: reddits)
            UserDefaults.standard.set(dataObject, forKey: "persistedChildren")
        }
    }
    
}
