//
//  Location.swift
//  compa
//
//  Created by m2sar on 22/05/2018.
//  Copyright © 2018 m2sar. All rights reserved.
//

import Foundation


class Location {
    
    let latitude, longitude:Double
    let date : Date
    
    init(dictionary: Dictionary<String, AnyObject>){
        self.latitude = 0.0
        self.longitude = 0.0
        self.date = Date.init()
    }
    
    init(){
        self.latitude = 0.0
        self.longitude = 0.0
        self.date = Date.init()
    }
}
