//
//  GameViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    var otherPlayer = User()
    var currentUser = User()
    var currentUserScore = Int()
    var otherPlayerScore = Int()
    var winner = String()
    var loser = String()

    @IBOutlet weak var playerOneNameLabel: UILabel!
    @IBOutlet weak var playerTwoNameLabel: UILabel!
    
    @IBOutlet weak var playerOneScoreTextField: UITextField!
    
    @IBOutlet weak var playerTwoScoreTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerOneScoreTextField.delegate = self
        self.playerTwoScoreTextField.delegate = self
        
        let userDefaults = Foundation.UserDefaults.standard
        let nickName  = userDefaults.string(forKey: "nickName")
        let _id  = userDefaults.string(forKey: "_id")
        
        currentUser.nickName = nickName
        currentUser.id = _id

        // Do any additional setup after loading the view.
        
        print("current user name: \(self.currentUser.nickName!)")
        print("other user name: \(self.otherPlayer.nickName!)")
        
        self.playerOneNameLabel.text = self.currentUser.nickName!
        self.playerTwoNameLabel.text = self.otherPlayer.nickName!
    }
    
    
    
    @IBAction func submitGameButtonPressed(_ sender: Any) {
        
        guard let currentUserScore = Int(self.playerOneScoreTextField.text!) else {
            
            let alertController = UIAlertController(title: "Oops!", message: "Error logging game. Please re-submit and make sure to enter whole numbers.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        guard let otherPlayerScore = Int(self.playerTwoScoreTextField.text!) else {
            
            let alertController = UIAlertController(title: "Oops!", message: "Error logging game. Please re-submit and make sure to enter whole numbers.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        self.currentUserScore = currentUserScore
        self.otherPlayerScore = otherPlayerScore
        
        if self.currentUserScore > self.otherPlayerScore {
            
            self.winner = self.currentUser.id!
            self.loser = self.otherPlayer.id!
            
        } else {
            
            self.winner = self.otherPlayer.id!
            self.loser = self.currentUser.id!
        }


        print(self.currentUser.id!)
        print(self.otherPlayer.id!)
        print(self.winner)
        print(self.loser)
        print(self.currentUserScore)
        print(self.otherPlayerScore)
        
        self.postGame()
        self.performSegue(withIdentifier: "BackToQueueSegue", sender: self)
    }
    

    func postGame() {
        
        
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
        ]
        let parameters = [
            "playerOne": "\(self.currentUser.id!)",
            "playerTwo": "\(self.otherPlayer.id!)",
            "winner": "\(self.winner)",
            "loser": "\(self.loser)",
            "playerOneScore": self.currentUserScore,
            "playerTwoScore": self.otherPlayerScore
            ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://iron-pong.herokuapp.com/api/games")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
            }
        })
        
        dataTask.resume()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
