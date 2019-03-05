//
//  ViewController.swift
//  Restaurants
//
//  Created by mac on 04.03.2019.
//  Copyright © 2019 Oleg_Psiarovsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var data = [RestaurantsData]()
    var filteredData = [RestaurantsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.orange
        
        data = [RestaurantsData(image: UIImage(named: "scorini")!, name: "Scorini", details: "Architect Pauchenko Street, 28"), RestaurantsData(image: UIImage(named: "zirka")!, name: "Zirka", details: "Shevchenko street, 1B"), RestaurantsData(image: UIImage(named: "sorento")!, name: "Sorento", details: "Architect Pauchenko Street, 46"), RestaurantsData(image: UIImage(named: "prima")!, name: "Prima", details: "Architect Pauchenko Street, 17/7"), RestaurantsData(image: UIImage(named: "fransua")!, name: "Fransua", details: "No information"), RestaurantsData(image: UIImage(named: "garden")!, name: "Family Garden", details: "Street Velyka Prospektovna, 34/32")]

        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Restaurants"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    // MARK: - SearchController methods
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func updateSearchResults(for SearchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredData = data.filter({( data : RestaurantsData) -> Bool in
            return data.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    
    // MARK: - Table View methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredData.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        let data: RestaurantsData
        
        if isFiltering() {
            data = filteredData[indexPath.row]
        } else {
            data = self.data[indexPath.row]
        }
        
        cell.myImageView.image = data.image
        cell.nameLabel.text = data.name
        cell.detailLabel?.text = data.details
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if isFiltering(){
                for item in data {
                    if item === filteredData[indexPath.row] {
                        data = data.filter() {$0 !== item}
                    }
                }
                filteredData.remove(at: indexPath.row)
                tableView.reloadData()
            } else {
                data.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seque" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let data: RestaurantsData
                if isFiltering() {
                    data = filteredData[indexPath.row]
                } else {
                    data = self.data[indexPath.row]
                }
                let controller = segue.destination  as! DetailsViewController
                controller.label = data.details
                controller.image = data.image
            }
        }
    }
}

