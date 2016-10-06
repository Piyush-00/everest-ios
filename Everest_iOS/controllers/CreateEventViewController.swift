//
//  CreateEventViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class CreateEventViewController: InputTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let createEventViewContainer = CreateEventViewContainer()
        createEventViewContainer.contentTableview?.delegate = self
        
        self.view.addSubview(createEventViewContainer)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "testCell")
        cell.backgroundView?.backgroundColor = UIColor.black
        return cell
    }
}

