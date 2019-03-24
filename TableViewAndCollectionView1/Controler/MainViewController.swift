//
//  MainViewController.swift
//  TableViewAndCollectionView1
//
//  Created by mac on 18.03.2019.
//  Copyright © 2019 Oleg_Psiarovsky. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UIView!
    
    @IBOutlet weak var collectionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alpha = 1
        collectionView.alpha = 0
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tableView.alpha = 1
            collectionView.alpha = 0
        } else {
            tableView.alpha = 0
            collectionView.alpha = 1
        }
    }
    
}
