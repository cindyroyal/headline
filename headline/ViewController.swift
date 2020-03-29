//
//  ViewController.swift
//  headline
//
//  Created by Royal, Cindy L on 3/29/20.
//  Copyright © 2020 Royal, Cindy L. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    //test array of headlines
    var db = Firestore.firestore()
    //var newsItems = ["News 1", "News 2", "News 3"]
     var newsItems = [String]()
    

    @IBOutlet weak var theNews: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = newsItems[indexPath.row]
        return cell!
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             let selection = newsItems[indexPath.row]
             if (selection == "News 1") {
                 performSegue(withIdentifier: "News1Segue", sender: self)
             }
             else if (selection == "News 2") {
                 performSegue(withIdentifier: "News2Segue", sender: self)
             }
             else if (selection == "News 3") {
                 performSegue(withIdentifier: "News3Segue", sender: self)
             }
         }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        theNews.delegate = self
        theNews.dataSource = self
        
        db.collection("Posts").getDocuments { (snapshot, error) in
                   if error == nil && snapshot != nil {
                       for document in snapshot!.documents {
                           var documentData = document.data()
                           self.newsItems.append(documentData["post"]! as! String)
                       }
               self.theNews.reloadData()
                   }
               }
           }
    


}

