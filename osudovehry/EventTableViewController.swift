//
//  EventTableViewController.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 21/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import UIKit
import SwiftyJSON

enum EventTableType {
    case all
    case upcoming
}

class EventTableViewController: UITableViewController {
    
    let type: EventTableType
    var events = [Event]()
    
    init(type: EventTableType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        
        // Add data receiving observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.update), name: NotificationTypes.dataChange, object: nil)
        
        // Create tabBarItem
        tabBarItem = UITabBarItem(title: type == .all ? "All" : "Upcoming", image: nil, selectedImage: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        switch type {
        case .upcoming:
            events = APIWrapper.service.getUpcomingEvents()
        case .all:
            events = APIWrapper.service.getEvents()
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set navigation title, depending on table type
        switch type {
        case .upcoming:
            tabBarController?.navigationItem.title = "Upcoming Events"
        case .all:
            tabBarController?.navigationItem.title = "All Events"
        }
        
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = events[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)!")
        
        let event = events[indexPath.row]
        
        navigationController?.pushViewController(EventDetailViewController(event: event), animated: true)
    }
}
