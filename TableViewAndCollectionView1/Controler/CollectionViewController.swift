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
    var articles: [Article]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchArticles()
        let itemSize = UIScreen.main.bounds.width / 3 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 10.0, right: 0.0)
        layout.itemSize = CGSize(width: itemSize, height: 1.5 * itemSize)
        
        layout.minimumLineSpacing = 35
        layout.minimumInteritemSpacing = 10
        
        myCollectionView.collectionViewLayout = layout
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
                            self.myCollectionView.reloadData()
                        }
                    }
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        if Int(indexPath.row) % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(red: 176.0 / 255.0, green: 202.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0)
        } else {
            cell.contentView.backgroundColor = UIColor(red: 190.0 / 255.0, green: 177.0 / 255.0, blue: 206.0 / 255.0, alpha: 1.0)
        }
        cell.contentView.clipsToBounds = true
        cell.contentView.layer.cornerRadius = 10.0
        
        cell.myImageView.clipsToBounds = true
        cell.myImageView.layer.cornerRadius = (UIScreen.main.bounds.width / 3 - 10) / 3.0
        cell.myImageView.layer.borderWidth = 1.0
        
        cell.myImageView.downloadImage(from: (articles?[indexPath.row].imageUrl!)!)
        cell.namrLabel.text = articles?[indexPath.row].headLine
        cell.detailsLabel.text = articles![indexPath.row].desc
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionSeque" {
            let indexPaths : NSArray = myCollectionView.indexPathsForSelectedItems! as NSArray
            let indexPath : IndexPath = indexPaths[0] as! IndexPath
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.label = articles?[indexPath.row].desc
            destinationVC.imageUrl = articles?[indexPath.row].imageUrl
        }
    }

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


