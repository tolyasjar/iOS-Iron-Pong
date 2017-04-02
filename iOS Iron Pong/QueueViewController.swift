//
//  QueueViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class QueueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var queueTableView: UITableView!
    @IBOutlet weak var startTheGameBtn: UIButton!
    
    var queueUsers = [User]()
    
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assumption current User value   jamesjosephsewell@gmail.com
        currentUser.email = "test@gmail.com"
        currentUser.password = "somepassword"
        currentUser.nickName = "Filipino Wood Paddle"
        currentUser.id = "58e03833f36d2878e036c67c" // pick another user NOT in the queue
        
        self.getQueue()
        
        //Setting a timer , update the queue every 5 seconds
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(QueueViewController.updateQueue), userInfo: nil, repeats: true)
        
        self.startTheGameBtn.isEnabled = false
        
    }
    
    func checkIfcurrentUserCanPlay() {
        if (currentUser.nickName == queueUsers[0].nickName || currentUser.nickName == queueUsers[1].nickName) {
            self.startTheGameBtn.isEnabled = true
        }
    }

    func updateQueue()
    {
        queueUsers.removeAll()
        print("Refresh Queue")
        self.getQueue()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.queueUsers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QueueCell", for: indexPath)
        
        let user = self.queueUsers[indexPath.row]
        
        cell.textLabel?.text = user.nickName
        
        return cell
    }
    
    @IBAction func startGameButtonPressed() {
        
        
    }

    
    func getQueue() {
        
        let url = URL(string: "https://iron-pong.herokuapp.com/api/queue/")!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            
            for dictionary in json {
                
                let queue = dictionary["queueMembers"] as! [[String:Any]]
                
                for players in queue {
                    
                    let name = players["nickName"] as! String
                    let id = players["_id"] as! String
                    
                    let user = User()
                    user.nickName = name
                    user.id = id
                    
                    self.queueUsers.append(user)
                }
            }
            DispatchQueue.main.async {
                self.queueTableView.reloadData()
                
                if (self.queueUsers.count >= 2) {
                self.checkIfcurrentUserCanPlay()
                }

             }
            }.resume()
        
    }
    
    @IBAction func addCurrentUserTOQueue(_ sender: Any) {
        
        //User Alert
        let alert = UIAlertController(title: "Great! \n", message: "You are have been added to the Queue \n 👊🏻 ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        
//        //update table
//        self.queueTableView.beginUpdates()
//        self.queueTableView.insertRows(at: [IndexPath.init(row: self.users.count-1, section: 0)], with: .automatic)
//        self.queueTableView.endUpdates()
        
        //deactivate adding the user again
        self.navigationItem.rightBarButtonItem?.isEnabled = false     //assumption user loggedin or not ??

        //PUT to API
        
        let url = "https://iron-pong.herokuapp.com/api/queue/add/\(currentUser.id!)"
        
        guard let apiURL = NSURL(string: url) else {
            fatalError("URL incorrect")
        }
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: apiURL as URL)
        request.httpMethod = "PUT"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request as URLRequest) { (data :Data?, response :URLResponse?, error: Error?) in
            
            print("finished")
            
            }.resume()
        
    }
    
    @IBAction func startGameBtnPressed(_ sender: Any) {
        
        //User Alert
        let alert = UIAlertController(title: "Get Ready!", message: "You are up next! ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "👍🏻", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            print("Deleting User!")
            
            self.startTheGameBtn.isEnabled = false

            //delete userfrom queue
            //Put to API
            print(queueUsers[indexPath.row].id!)
            let url = "https://iron-pong.herokuapp.com/api/queue/delete/\(queueUsers[indexPath.row].id!)"
            
            guard let apiURL = NSURL(string: url) else {
                fatalError("URL incorrect")
            }
            
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: apiURL as URL)
            request.httpMethod = "PUT"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request as URLRequest) { (data :Data?, response :URLResponse?, error: Error?) in
                
                print("finished")
                
                }.resume()
            
            return
        }
    }
    
}

