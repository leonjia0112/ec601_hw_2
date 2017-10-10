//
//  ViewController.swift
//  message_app
//
//  Created by Pei Jia on 10/5/17.
//  Copyright © 2017 leojia. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postData = [String]()
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a  nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // set the firebase reference
        ref = Database.database().reference()
        
        // retrieve the posts and listen to changes
        ref?.child("posts").observe(.childAdded, with: { (snapshot) in
            // code to execute when a child is added under "posts"
            // take the value from the snapshot and added it to the postData array
            let postTemp = snapshot.value as? String
            
            // it won't execute if the data is nil
            if let actualPost = postTemp {
                
                // append data to our post array
                self.postData.append(actualPost)
                
                // reload table view
                self.tableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }
}

