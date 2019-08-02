//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-07-26.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit

class ListViewController: UIViewController  {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
extension ListViewController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentModel.sLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let location = StudentModel.sLocations[indexPath.row]
        
        if location.firstName == "" {
            cell.textLabel?.text = "No Name"
        }
        else {
         cell.textLabel?.text = location.firstName + location.lastName
         cell.detailTextLabel?.text = location.mediaURL
         
        }
        return cell
    }
    
    
}
