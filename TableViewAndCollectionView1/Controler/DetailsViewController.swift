//
//  DetailsViewController.swift
//  TableViewAndCollectionView1
//
//  Created by mac on 05.03.2019.
//  Copyright © 2019 Oleg_Psiarovsky. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    var image: UIImage?
    var label: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = image
        detailsLabel.text = label
    }
    
}
