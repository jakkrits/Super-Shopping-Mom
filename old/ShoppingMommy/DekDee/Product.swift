//
//  Products.swift
//  DekDee
//
//  Created by JakkritS on 1/2/2559 BE.
//  Copyright © 2559 AppIllustrator. All rights reserved.
//

import Foundation

struct Product {
    let name: String
    let size: String?
    
    init(name: String) {
        self.name = name
        self.size = nil
    }
    
    init(name: String, size: String?) {
        self.name = name
        self.size = size
    }
    
}