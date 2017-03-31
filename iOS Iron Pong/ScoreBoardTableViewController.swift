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

    override func viewDidLoad() {
        super.viewDidLoad()


        
        
    }
    
    func readJSONData() {
        
        if let path = Bundle.main.path(forResource: "mockUserAPI", ofType: "json")
        {
            if let jsonData = try Data(bytesNoCopy: path, count: .DataReadingMappedIfSafe, deallocator: nil)
            {
                if let jsonResult: NSDictionary = JSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
                {
                    if let persons : NSArray = jsonResult["person"] as? NSArray
                    {
                        // Do stuff
                    }
                }
            }
        }
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 


}
