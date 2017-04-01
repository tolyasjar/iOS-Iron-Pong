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
    var players = [Game]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readDummyData()
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreBoard", for: indexPath) as! ScoreboardTableViewCell
        let playerName = self.players[indexPath.row]
        cell.playerOneLabel?.text = playerName.playerOne
        
        return cell
    }
 


}
