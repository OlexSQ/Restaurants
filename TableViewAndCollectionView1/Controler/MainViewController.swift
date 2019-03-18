//
//  MainViewController.swift
//  Restaurants
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
