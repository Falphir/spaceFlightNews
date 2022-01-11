//
//  ArticleViewController.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 11/01/2022.
//

import UIKit

class ArticleViewController : UIViewController {
    
    var fetchedArticle = [Article]()
    
    @IBOutlet weak var ArticleImage: UIImageView!
    
    @IBOutlet weak var ArticleTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        parseData()
        
    }
    
    //---------------- API ----------------//
    
    func parseData(){

        fetchedArticle = []
        
        var id = "13120"

        let url = "https://api.spaceflightnewsapi.net/v3/articles/" + id
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)

        let task = session.dataTask(with: request) { (data, response, error) in

            if(error != nil){
                print("error")

            } else {
                
                let fetchedData = try JSONSerialization.jsonObject(with: data!, options: . mutableLeaves) as! NSArray

                for eachFetchedArticle in fetchedData {

                    let eachArticle = eachFetchedArticle as! [String: Any]

                    let idArticle = eachArticle["id"] as! Int
                    let titleArticle = eachArticle["title"] as! String
                    //let urlArticle = eachArticle["url"] as! URL
                    //let imageUrlArticle = eachArticle["imageUrl"] as! URL
                    let newsSiteArticle = eachArticle["newsSite"] as! String
                    let summaryArticle = eachArticle["summary"] as! String?
                    let publishedAtArticle = eachArticle["publishedAt"] as! String
                    let updatedAtArticle = eachArticle["updatedAt"] as! String
                    let featuredArticle = eachArticle["featured"] as! Bool
                    //let launchesArticle = eachArticle["launches"] as! Array<String>
                    //let eventsArticle = eachArticle["events"] as! Array<String>


                    self.fetchedArticle.append(Article(id: idArticle, title: titleArticle, newsSite: newsSiteArticle, publishedAt: publishedAtArticle, updatedAt: updatedAtArticle, featured: featuredArticle))
                }

                    
                }
            }
        }
        task.resume()
    }



 class Article {

     var id: Int?
     var title: String?
     //var url: URL?
     //var imageUrl: URL?
     var newsSite: String?
     //var summary: String?
     var publishedAt: String?
     var updatedAt: String?
     var featured: Bool?
     var launches: String?
     var events: String?


     init(id: Int, title: String, newsSite: String, publishedAt: String, updatedAt: String, featured: Bool){

         self.id = id
         self.title = title
         //self.url = url
         //self.imageUrl = imageUrl
         self.newsSite = newsSite
         self.publishedAt = publishedAt
         self.updatedAt = updatedAt
         self.featured = featured
     }
}
    //---------------- FIM API ----------------//
    
    func ArticleView() {
        ArticleTitle.text = fetchedArticle.title
    }
    
    
}
