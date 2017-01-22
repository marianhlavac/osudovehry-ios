//
//  ResultsTableViewController.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 21/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var events = [Event]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // Table properties
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Add data receiving observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.update), name: NotificationTypes.dataChange, object: nil)
        
        // Create tabBarItem
        tabBarItem = UITabBarItem(title: "Results", image: nil, selectedImage: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        events = APIWrapper.service.getEventsWithResults()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set navigation title
        tabBarController?.navigationItem.title = "Results"
        
        // Set this class as data source
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = events[indexPath.row].name + " vyhrál tým " + events[indexPath.row].results[0] +
                                ", na druhém místě se umístil tým " + events[indexPath.row].results[1] + " a na třetím tým " +
                                events[indexPath.row].results[2]
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }

}
