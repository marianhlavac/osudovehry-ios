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
        eventNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let eventDateLabel = UILabel()
        let fmt = DateFormatter()
        fmt.dateStyle = .medium
        fmt.timeStyle = .short
        eventDateLabel.text = fmt.string(from: event.startsAt) + " ― "
        let startDay = Calendar.current.dateComponents([.day], from: event.startsAt)
        let endDay = Calendar.current.dateComponents([.day], from: event.endsAt)
        fmt.dateStyle = startDay.day == endDay.day ? .none : .medium
        eventDateLabel.text = eventDateLabel.text! + fmt.string(from: event.endsAt)
        
        let hairlineView = HairlineView()
        
        let eventDescLabel = UILabel()
        eventDescLabel.text = event.desc
        eventDescLabel.lineBreakMode = .byWordWrapping
        eventDescLabel.numberOfLines = 0
        
        let eventPriceLabel = UILabel()
        eventPriceLabel.text = "Admission".localized + String(event.price) + " CZK."
        
        let eventAttendeeLabel = UILabel()
        eventAttendeeLabel.text = String(event.attendeeCount) + " " + "attendees".localized
        
        let moreInfoButton = UIButton(type: .roundedRect)
        moreInfoButton.setTitle("More info".localized, for: .normal)
        moreInfoButton.addTarget(self, action: #selector(EventDetailViewController.openInfo), for: .touchUpInside)
        
        if (event.url == "") {
            moreInfoButton.isHidden = true
        }
        
        _ = [
            coverPhotoImageView, eventNameLabel, eventDateLabel, hairlineView, eventDescLabel,
            hairlineView, eventPriceLabel, eventAttendeeLabel, moreInfoButton
            ].map() {
                $0.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview($0)
        }
        
        let viewDict = [
            "super": view,
            "scroll": scrollView,
            "cover": coverPhotoImageView,
            "name": eventNameLabel,
            "date": eventDateLabel,
            "desc": eventDescLabel,
            "price": eventPriceLabel,
            "attendees": eventAttendeeLabel,
            "moreinfo": moreInfoButton
        ]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scroll(==super)]|",
                                                           options: .alignAllCenterX, metrics: nil, views: viewDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scroll]|",
                                                           options: .alignAllCenterX, metrics: nil, views: viewDict))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:
            "V:|[cover(==200)]-10-[name]-[date]-20-[desc]-20-[price]-[attendees]-20-[moreinfo]|",
                                                                 options: [], metrics: nil, views: viewDict))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[cover(==scroll)]|",
                                                                 options: [], metrics: nil, views: viewDict))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-|",
                                                                 options: [], metrics: nil, views: viewDict))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[date]-|",
                                                                 options: [], metrics: nil, views: viewDict))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[desc]-|",
                                                                 options: [], metrics: nil, views: viewDict))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[price(==attendees)]-[attendees]-|",
                                                                 options: [], metrics: nil, views: viewDict))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[moreinfo]-|",
                                                                 options: .alignAllCenterX, metrics: nil, views: viewDict))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(EventDetailViewController.share))
        navigationItem.rightBarButtonItem = shareButton
        
        if (event.url == "") {
            shareButton.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func openInfo() {
        UIApplication.shared.open(URL(string: event.url)!)
    }
    
    func share() {
        let vc = UIActivityViewController(activityItems: [URL(string: event.url)!], applicationActivities: [])
        present(vc, animated: true)
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
