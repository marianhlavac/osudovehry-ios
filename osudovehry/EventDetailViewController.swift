//
//  EventDetailViewController.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 21/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    
    let event: Event
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)

        
        let coverPhotoImageView = UIImageView(image: event.coverPhoto)
        coverPhotoImageView.contentMode = UIViewContentMode.scaleAspectFill

        let eventNameLabel = UILabel()
        eventNameLabel.text = event.name
        
        let eventDateLabel = UILabel()
        let fmt = DateFormatter()
        fmt.dateStyle = .medium
        fmt.timeStyle = .short
        eventDateLabel.text = fmt.string(from: event.startsAt) + "-" + fmt.string(from: event.endsAt)
        
        let hairlineView = HairlineView()
        
        let eventDescLabel = UILabel()
        eventDescLabel.text = event.desc + event.desc + event.desc
        eventDescLabel.lineBreakMode = .byWordWrapping
        eventDescLabel.numberOfLines = 0
        
        let eventPriceLabel = UILabel()
        eventPriceLabel.text = "Admission is " + String(event.price) + " CZK."
        
        let eventAttendeeLabel = UILabel()
        eventAttendeeLabel.text = String(event.attendeeCount) + " attendees"
        
        stackView = UIStackView(arrangedSubviews: [ coverPhotoImageView, eventNameLabel, eventDateLabel, hairlineView, eventDescLabel ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        scrollView.addSubview(stackView)
        
        let viewDict = [
            "super": view,
            "scroll": scrollView,
            "stack": stackView,
            "cover": coverPhotoImageView,
            "name": eventNameLabel,
            "date": eventDateLabel
        ]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scroll(==super)]|",
                                                           options: .alignAllCenterX, metrics: nil, views: viewDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scroll]|",
                                                           options: .alignAllCenterX, metrics: nil, views: viewDict))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stack(==scroll)]|",
                                                                 options: .alignAllCenterX, metrics: nil, views: viewDict))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stack]|",
                                                                 options: .alignAllCenterX, metrics: nil, views: viewDict))
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[cover(==200)]",
                                                                options: [], metrics: nil, views: viewDict))
        

    
        stackView.setNeedsUpdateConstraints()
        view.setNeedsUpdateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: "share")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
        scrollView.contentSize.width = scrollView.frame.size.width
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}