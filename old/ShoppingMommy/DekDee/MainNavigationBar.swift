//
//  MainNavigationBar.swift
//  DekDee
//
//  Created by Jakkrits on 1/2/2559 BE.
//  Copyright © 2559 AppIllustrator. All rights reserved.
//

import UIKit

class MainNavigationBar: UINavigationBar {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        return CGSizeMake(self.superview!.frame.width, 80)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
