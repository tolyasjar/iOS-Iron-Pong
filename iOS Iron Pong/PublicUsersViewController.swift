//
//  PublicUsersViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class PublicUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource   {

    @IBOutlet weak var queueTableView: UITableView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        self.getUsers()
    }
    
    func getUsers() {
        
        let url = URL(string: "https://iron-pong.herokuapp.com/API/users")!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            for dictionary in json {
                print(dictionary)
                let name = dictionary["nickName"] as! String
                
                if dictionary["wins"] == nil {
                    
                    let user = User()
                    user.nickName = name
                    self.users.append(user)
                    
                } else {
                    
                    let wins = dictionary["wins"] as! Double
                    
                    let user = User()
                    user.nickName = name
                    user.wins = wins
                    self.users.append(user)

                    
                }
                


            }
            DispatchQueue.main.async {
                self.queueTableView.reloadData()
            }
            }.resume()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PublicUserCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        
        if user.wins == nil {
            cell.textLabel?.text = user.nickName
            cell.detailTextLabel?.text = "Wins: 0"

        } else {
            cell.textLabel?.text = user.nickName

            let wins = String(describing: Int(user.wins!))

            cell.detailTextLabel?.text = "Wins: \(wins)"

        }
        

        
        // Configure the cell...
        
        return cell
    }

}
