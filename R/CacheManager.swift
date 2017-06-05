//
//  CacheManager.swift
//  R
//
//  Created by Juan Pablo Boero Alvarez on 5/11/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CacheManager {
    
    // One line singleton.
    static let shared = CacheManager()
    fileprivate init() {}//This prevents others from using the default '()' initializer for this class.
    
    /// Retrieve persisted reddits.
    func getReddits() -> [MThing]? {
        if let reddits = getRedditsMO() {
            var redditsArray = [MThing]()
            for reddit in reddits {
                let redditObject = MThing()
                redditObject.title = reddit.title
                redditObject.author = reddit.author
                redditObject.dateUnixTimeStamp = reddit.dateUnixTimeStamp
                redditObject.thumbnailURL = reddit.thumbnailURL
                redditObject.commentsCount = reddit.commentsCount
                redditObject.subreddit = reddit.subreddit
                redditsArray.append(redditObject)
            }
            if redditsArray.count > 0 {
                return redditsArray
            }
        }
        return nil
    }
    
    private func getRedditsMO() -> [ThingMO]? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        do {
            return try appDelegate.persistentContainer.viewContext.fetch(ThingMO.fetchRequest())
        } catch {
            fatalError("Failed to fetch: \(error)")
        }
        
        return nil
    }
    
    /// Persist reddits.
    func setReddits(reddits: [MThing]?) {
        if let reddits = reddits {
            for reddit in reddits {
                
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
            
                let managedContext = appDelegate.persistentContainer.viewContext
                
                if let entity = NSEntityDescription.entity(forEntityName: "Thing", in: managedContext) {
                    let newStyle = NSManagedObject(entity: entity, insertInto: managedContext) as! ThingMO
                    
                    newStyle.title = reddit.title
                    newStyle.author = reddit.author
                    newStyle.dateUnixTimeStamp = reddit.dateUnixTimeStamp ?? 0
                    newStyle.thumbnailURL = reddit.thumbnailURL
                    newStyle.commentsCount = reddit.commentsCount ?? 0
                    newStyle.subreddit = reddit.subreddit
                }
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
}
