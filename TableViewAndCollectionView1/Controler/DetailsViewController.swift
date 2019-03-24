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
    @IBOutlet weak var textView: UITextView!
    var imageUrl: String?
    var label: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.layer.cornerRadius = 15.0
        detailImageView.clipsToBounds = true
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2.0
        textView.layer.cornerRadius = 15.0
        detailImageView.downloadImage(from: imageUrl!)
        textView.text = label        
    }
    
    
}
