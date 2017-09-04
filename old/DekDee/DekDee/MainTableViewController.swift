//
//  MainTableViewController.swift
//  DekDee
//
//  Created by JakkritS on 1/1/2559 BE.
//  Copyright © 2559 AppIllustrator. All rights reserved.
//

import UIKit
import QuartzCore
import CoreImage
import Persei

class MainTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    private weak var menu: MenuView!
    
    // MARK: - Items
    private let items = (0..<5 as Range).map {
        MenuItem(image: UIImage(named: "menu_icon_\($0)")!)
    }
    //let items = [MenuItem(image: UIImage(named: "menu_icon_0")!)]
    
    let products = Products.sharedManager
    var selectedIndex = 0
    
    let shoppingIcon = ShoppingBag(frame: CGRect (x: 0, y: 0, width: 65, height: 65))
    var blurView: UIVisualEffectView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let rightButton = UIButton(type: .Custom)
        rightButton.addTarget(self, action: "showCart:", forControlEvents: .TouchUpInside)
        rightButton.frame = shoppingIcon.frame
        shoppingIcon.addSubview(rightButton)
        let rightBarButtonItem = UIBarButtonItem(customView: shoppingIcon)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.navigationItem.title = "Little Cutie Shop"
        
        //self.navigationItem.leftBarButtonItems = []
        
        
        loadMenu()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationItem.leftBarButtonItems = []
    }
    
    override func viewWillDisappear(animated: Bool) {
        //self.navigationItem.leftBarButtonItems = []
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.productCategories.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.MainCell, forIndexPath: indexPath) as! MainTableViewCell
        
        cell.iconImageView.image = products.productIcons[indexPath.row]
        cell.backgroundColor? = Color.RedA400
        cell.productCategoryTitle.text = products.productCategoryTitles[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.navigationItem.leftBarButtonItems = [self.leftBarButtonItem]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if products.productCategories[indexPath.row].count == 1 {
            selectedIndex = indexPath.row
            print("Selected Index = \(selectedIndex)")
            performSegueWithIdentifier(Constants.MainToProductSegue, sender: self)
        } else {
            selectedIndex = indexPath.row
            print("Selected Index = \(selectedIndex)")
            performSegueWithIdentifier(Constants.MainToSubVCSegue, sender: self)
        }
    }
    
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.MainToSubVCSegue {
            let popOverVC = segue.destinationViewController as! SubCategoryTableViewController
            popOverVC.modalPresentationStyle = .Popover
            popOverVC.popoverPresentationController?.delegate = self
            popOverVC.subProducts = products.productCategories[selectedIndex]
            
            
        } else if segue.identifier == Constants.MainToProductSegue {
            print("MAIN TO PRODUCT")
            let destinationVC = segue.destinationViewController
            destinationVC.transitioningDelegate = self
        }
        
    }
    

    func prepareForPopoverPresentation(popoverPresentationController: UIPopoverPresentationController) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView!.frame = self.view.bounds
        blurView!.translatesAutoresizingMaskIntoConstraints = false
        
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.frame = self.view.bounds
        
        self.view.addSubview(blurView!)
        blurView!.contentView.addSubview(vibrancyView)
    }
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        print("popover dismissed")
        blurView?.removeFromSuperview()
        //self.navigationItem.leftBarButtonItems = []
    }
    
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        switch UIDevice.currentDevice().orientation {
        case .LandscapeLeft, .LandscapeRight:
            print("landscape")
        case .Portrait, .PortraitUpsideDown:
            print("portrait")
        default:
            print("default")
        }
    }
    
    func showCart(sender: UIBarButtonItem) {
        print("cart")
    }

    func loadMenu() {
        let menuView = MenuView()
        
        var menuItem = MenuItem(image: UIImage(named: "menu_icon_0")!)
        menuItem.backgroundColor = UIColor.whiteColor()
        
        menuView.delegate = self
        menuView.items = items
        tableView.addSubview(menuView)
        self.menu = menuView
    }
    
    @IBAction func showMenu(sender: UIBarButtonItem) {
        menu.setRevealed(!menu.revealed, animated: true)
    }
}


extension MainTableViewController: MenuViewDelegate {
    func menu(menu: MenuView, didSelectItemAtIndex index: Int) {
        print("selected \(index)")
    }
}
























