//
//  CollectionViewController.swift
//  TableViewAndCollectionView1
//
//  Created by mac on 18.03.2019.
//  Copyright © 2019 Oleg_Psiarovsky. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    @IBOutlet var myCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let itemSize = UIScreen.main.bounds.width / 3 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 10.0, right: 0.0)
        layout.itemSize = CGSize(width: itemSize, height: 1.8 * itemSize)
        
        layout.minimumLineSpacing = 35
        layout.minimumInteritemSpacing = 10
        
        myCollectionView.collectionViewLayout = layout
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        if Int(indexPath.row) % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(red: 176.0 / 255.0, green: 202.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0)
        } else {
            cell.contentView.backgroundColor = UIColor(red: 190.0 / 255.0, green: 177.0 / 255.0, blue: 206.0 / 255.0, alpha: 1.0)
        }
        cell.myImageView.clipsToBounds = true
        cell.myImageView.layer.cornerRadius = 40.0
        
        cell.myImageView.backgroundColor = UIColor.green
        cell.namrLabel.text = "News"
        cell.detailsLabel.text = "Минимальная зарплата в Украине должна возрасти с нынешних 150 долларов до 300 долларов. Это является задачей Кабинета Министров"
    
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItem indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150.0, height: 250.0)
//    }

    // MARK: UICollectionViewDelegate

    
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


