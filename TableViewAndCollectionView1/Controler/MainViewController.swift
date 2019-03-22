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
    
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alpha = 1
        collectionView.alpha = 0
        fetchArticles()
    }
    
    func fetchArticles() {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=e4178b98d50344a2b1f49578de34989e")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, respons, error) in
            if error != nil {
                print(error)
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
                    }
                
                }
            } catch let error {
                print(error)
            }
        }
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
