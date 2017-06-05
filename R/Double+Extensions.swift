//
//  Extension+Double.swift
//  R
//
//  Created by Juan Pablo Boero Alvarez on 7/11/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import Foundation

extension Double {
    
    func stringDateFromUnixValue() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: date)
    }
    
}
