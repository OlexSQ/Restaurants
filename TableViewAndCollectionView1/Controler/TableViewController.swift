//
//  ViewController.swift
//  TableViewAndCollectionView1
//
//  Created by mac on 04.03.2019.
//  Copyright © 2019 Oleg_Psiarovsky. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func fetchArticles() {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=e4178b98d50344a2b1f49578de34989e")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, respons, error) in
            if error != nil {
                print(error!)
                return
            }
            self.articles = [Article]()
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as![String: AnyObject]
                if let articlesFromJson = json["articles"] as? [[String: AnyObject]] {
                    for articles in articlesFromJson {
                        let article = Article()
                        if let title = articles["title"] as? String, let desc = articles["description"] as? String, let url = articles["url"] as? String, let urlToImage = articles["urlToImage"] as? String {
                            article.desc = desc
                            article.headLine = title
                            article.url = url
                            article.imageUrl = urlToImage
                        }
                        self.articles?.append(article)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    // MARK: - Table View methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        cell.myImageView.clipsToBounds = true
        cell.myImageView.layer.cornerRadius = 45.0
        
        cell.myImageView.downloadImage(from: (articles?[indexPath.row].imageUrl!)!)
        cell.nameLabel.text = articles?[indexPath.row].headLine
        cell.detailLabel?.text = articles![indexPath.row].desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableSeque" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! DetailsViewController
                destinationVC.label = articles?[indexPath.row].desc
                destinationVC.imageUrl = articles?[indexPath.row].imageUrl
            }
        }
    }
    
}

extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

