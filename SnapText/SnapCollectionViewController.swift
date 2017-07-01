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
        cell.imageView?.image = snap.snap
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SnapDetailViewController") as! SnapDetailViewController
        detailController.snap = snaps[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }

}

// MARK: Helpers
extension SnapCollectionViewController {
    
    func getSnaps() -> [Snap] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.snaps
    }
}
