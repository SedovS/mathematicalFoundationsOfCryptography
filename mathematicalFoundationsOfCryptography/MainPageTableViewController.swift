//
//  MainPageTableViewController.swift
//  mathematicalFoundationsOfCryptography
//
//  Created by Apple on 10/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class MainPageTableViewController: UITableViewController {

    private var allAlgorithm = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allAlgorithm = Model.returnArr()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allAlgorithm.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainPageCell", for: indexPath) as! MainPageTableViewCell
        
        let item = allAlgorithm[indexPath.row]
        cell.refresh(item)
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "mainPageToEuclid", sender: nil)
        
    }
    
}

