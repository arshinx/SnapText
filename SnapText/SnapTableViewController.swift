//
//  SnapTableViewController.swift
//  SnapText
//
//  Created by Arshin Jain on 6/29/17.
//  Copyright © 2017 Arshin Jain. All rights reserved.
//

import UIKit

class SnapTableViewController: UITableViewController {
    
    var snaps : [Snap]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        snaps = getSnaps()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Snaps
        snaps = getSnaps()
        
        tableView.reloadData()
        print("\n\n TableView \(snaps.count) \n\n")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return snaps.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let snap = snaps[indexPath.row]
        cell.imageView?.image = snap.snap
        cell.textLabel?.text = snap.topText + "..." + snap.bottomText
        cell.detailTextLabel?.text = ""

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SnapDetailViewController") as! SnapDetailViewController
        detailController.snap = snaps[indexPath.row]
    }
 
}

// MARK: Helpers
extension SnapTableViewController {
    
    func getSnaps() -> [Snap] {
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.snaps
    }
}
