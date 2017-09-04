//
//  SubCategoryTableViewController.swift
//  DekDee
//
//  Created by JakkritS on 1/2/2559 BE.
//  Copyright © 2559 AppIllustrator. All rights reserved.
//

import UIKit

class SubCategoryTableViewController: UITableViewController {

    var subProducts = [Product]()
    let products = Products.sharedManager
    
    override var preferredContentSize: CGSize {
        get {
            tableView.layoutIfNeeded()
            return CGSize(width:0, height:tableView.contentSize.height)
        }
        set {
            print("Cannot set preferredContentSize of this view controller!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        print(self.presentationController)
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
        return subProducts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SubCatCell, forIndexPath: indexPath) as! SubCategoryTableViewCell

        // Configure the cell...
        cell.backgroundColor = Color.BlueGray50
        cell.productTitle?.text = subProducts[indexPath.row].name
        cell.productIcon.image = products.bodyProductIcons[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        performSegueWithIdentifier(Constants.SubToProductSegue, sender: self)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    


    
}
