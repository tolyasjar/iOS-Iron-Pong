//
//  ScoreBoardTableViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//


//Jonathan is currently working on this
import UIKit

class ScoreBoardTableViewController: UITableViewController {
    var players = [Game]() // for dummy data
    var games = [Game]()
    var users = [User]()
    
    var currentUser = User()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = Foundation.UserDefaults.standard
        let nickName  = userDefaults.string(forKey: "nickName")
        let _id  = userDefaults.string(forKey: "_id")
        
        currentUser.nickName = nickName
        currentUser.id = _id

        
        populatUsers()
        populatScoreBoard()
        //readDummyData()
    }
    
    func readDummyData() {
        
        if let path = Bundle.main.path(forResource: "mockGameAPI", ofType: "json") {
            do {
                
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                
                do {
                    
                    let arrays = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    if let arrayOFDictionaries = arrays as? [[String: Any]] {
                        let game = Game()

                        for dictionary in arrayOFDictionaries {
                            print(dictionary)

                            game.playerOne = dictionary["playerOne"] as? String
                            game.playerTwo = dictionary["playerTwo"] as? String
                            game.playerOneScore = dictionary["playerOneScore"] as? Double
                            game.playerTwoScore = dictionary["playerTwoScores"] as? Double
                        
                            players.append(game)
                        }
                    }
                    
                } catch {}
            } catch {}
        }
        
    }
    //MARK:- GET Users from API

    func populatUsers() {
    
    let url = URL(string: "https://iron-pong.herokuapp.com/api/users")!
    URLSession.shared.dataTask(with: url) { (data, responce, error) in
    let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
    
    for item in json {
    
    let player = User()
    
    player.id = item["_id"] as? String
    player.nickName = item["nickName"] as? String
    
    self.users.append(player)
    }
    }.resume()
    
    }

    //MARK:- GET Games from API
    
    func populatScoreBoard() {
        
        let url = URL(string: "https://iron-pong.herokuapp.com/api/games")!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            
            for item in json {
                
                let game = Game()

                    game.playerOne = item["playerOne"] as? String
                    game.playerTwo = item["playerTwo"] as? String
                    game.playerOneScore = item["playerOneScore"] as? Double
                    game.playerTwoScore = item["playerTwoScore"] as? Double
                
                    self.games.append(game)
            }
            
            DispatchQueue.main.async {
            self.tableView.reloadData()
                
            }
            }.resume()
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        //return players.count
        return games.count
    }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreBoard", for: indexPath) as! ScoreboardTableViewCell
        /* API Problem
            for i in 0 ..< users.count  {
                
                print(self.games[indexPath.row].playerOne!)
            if (users[i].id! == self.games[indexPath.row].playerOne!) {
                print("Found")
                cell.playerOneLabel.text = users[i].nickName //self.games[indexPath.row].playerOne!
                print("Found")

                }
                if (users[i].id! == self.games[indexPath.row].playerTwo!) {
                    cell.playerOneLabel.text = users[i].nickName //self.games[indexPath.row].playerOne!
                    
                }
            }
 */
    
        cell.playerOneLabel.text = self.games[indexPath.row].playerOne!
        cell.playerTwoLabel.text = self.games[indexPath.row].playerTwo!
        
        let score1 = self.games[indexPath.row].playerOneScore
        let score2 = self.games[indexPath.row].playerTwoScore
        
        cell.playerOneScoreLabel.text = String(format: "%.0f", score1!)
        cell.playerTwoScoreLabel.text = String(format: "%.0f", score2!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.identifier == "ToCurrentUserVC2" {
    
    let destinationNavigationController = segue.destination as! UINavigationController
    let currentUserTableViewController = destinationNavigationController.topViewController as! CurrentUserTableViewController
    
    currentUserTableViewController.currentUser = currentUser
        }
    
    }
    

 


}
