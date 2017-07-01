//
//  SnapCollectionViewController.swift
//  SnapText
//
//  Created by Arshin Jain on 6/29/17.
//  Copyright © 2017 Arshin Jain. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SnapCollectionViewCell"

class SnapCollectionViewController: UICollectionViewController {
    
    var snaps: [Snap]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        snaps = getSnaps()

        // Do any additional setup after loading the view.
        collectionView?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        snaps = getSnaps()
        collectionView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print ("Snaps Count - Items in section: \(snaps.count)")
        return snaps.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SnapCollectionViewCell
        
        // Configure the cell
        let snap = snaps[indexPath.row]
        print ("1. Snaps Count - Cell for item at: \(snap.snap)")
        print ("2. Snaps Count - Cell for item at: \(snap.originalImage)")
        
        //if snaps.count > 0 { cell.imageView.image = snap.originalImage }
    
        print ("3. Snaps Count - Cell for item at: \(snap.snap)")
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SnapDetailViewController")
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

// MARK: Helpers
extension SnapCollectionViewController {
    
    func getSnaps() -> [Snap] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.snaps
    }
}
