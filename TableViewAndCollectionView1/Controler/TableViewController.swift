//
//  ViewController.swift
//  Restaurants
//
//  Created by mac on 04.03.2019.
//  Copyright © 2019 Oleg_Psiarovsky. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    
    // MARK: - Table View methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        
        cell.myImageView.clipsToBounds = true
        cell.myImageView.layer.cornerRadius = 45.0
        
        cell.myImageView.backgroundColor = UIColor.green
        cell.nameLabel.text = "News"
        cell.detailLabel?.text = "Минимальная зарплата в Украине должна возрасти с нынешних 150 долларов до 300 долларов. Это является задачей Кабинета Министров"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

