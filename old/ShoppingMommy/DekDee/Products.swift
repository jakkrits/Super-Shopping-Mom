//
//  Products.swift
//  DekDee
//
//  Created by JakkritS on 1/2/2559 BE.
//  Copyright © 2559 AppIllustrator. All rights reserved.
//

import UIKit

class Products {
    let diaper = Product(name: "Baby Diaper")

    let formulaFeed = Product(name: "Formula Feed")

    let mosquitoPatch = Product(name: "Anti-Mosquitos Patch")
    
    //body
    let lotion = Product(name: "Organic Double Moisture Lotion")
    let powder = Product(name: "Baby Powder")
    let soap = Product(name: "Organic Shampoo & Body Wash")
    let wipes = Product(name: "Wet Wipes")
    let mouthTissue = Product(name: "Baby Mouth Tissue")
    
    //dish
    let dishDetergent = Product(name: "Bottles & Nipples Liquid Cleanser")
    let bottle = Product(name: "Feeding Bottle")
    let nipple = Product(name: "Nipple")
    
    //Fabric
    let softener = Product(name: "Baby Fabric Softener")
    let detergent = Product(name: "Baby Liquid Fabric Detergent")

    //Mom's
    let breastMilkBag = Product(name: "Breast Milk Storage Bag")
    let breastPad = Product(name: "Breast Pads")
    
    
    static let sharedManager = Products()
    
    let allProducts: [Product]
    let productCategories: [[Product]]
    let productIcons: [UIImage]
    let bodyProductIcons: [UIImage]
    let productBackgroundColors: [UIColor]
    let productCategoryTitles: [String]
    
    init() {
        let bodyProducts = [lotion, powder, soap, wipes, mouthTissue]
        let dishProducts = [dishDetergent, bottle, nipple]
        let fabricProducts = [softener, detergent]
        let momsProducts = [breastMilkBag, breastPad]
        
       self.allProducts = [diaper, formulaFeed, mosquitoPatch, lotion, powder, soap, wipes, mouthTissue, dishDetergent, bottle, softener, detergent, breastMilkBag, breastPad]
        
        self.productCategories = [[diaper], [formulaFeed], [mosquitoPatch], bodyProducts, dishProducts, fabricProducts, momsProducts]
        
        self.productIcons = [UIImage(named: "diaper")!, UIImage(named: "feed")!, UIImage(named: "bug")!, UIImage(named: "body")!, UIImage(named: "bottle")!, UIImage(named: "clothe")!, UIImage(named: "mom")!]
        
        self.bodyProductIcons = [UIImage(named: "lotion")!, UIImage(named: "powder")!, UIImage(named: "shampoo")!, UIImage(named: "wipe")!, UIImage(named: "tissue")!]
        
        self.productBackgroundColors = [Color.RedA200, Color.DeepOrangeA400, Color.LightBlueA700, Color.IndigoA700, Color.PurpleA200, Color.PinkA500, Color.LightGreen700]
        
        self.productCategoryTitles = ["Diapers", "Formular Feeds", "Mosquitos", "Body", "Dish & Bottles", "Fabric", "For Mom"]
        
    }
}