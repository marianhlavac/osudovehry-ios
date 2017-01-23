//
//  EventTableViewCell.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 21/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    var event: Event
    let eventNameLabel = UILabel()
    
    init(_ event: Event) {
        self.event = event
        
        super.init(style: .default, reuseIdentifier: "reuseIdentifier")
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let coverImage = UIImageView(image: event.coverPhoto)
        coverImage.contentMode = .scaleAspectFill
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        coverImage.clipsToBounds = true
        contentView.addSubview(coverImage)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        coverImage.addSubview(blurView)
        
        let dayfmt = DateFormatter()
        dayfmt.dateFormat = "d"
        let monthfmt = DateFormatter()
        monthfmt.dateFormat = "MMM"
    
        let eventDayLabel = UILabel()
        eventDayLabel.text = dayfmt.string(from: event.startsAt)
        eventDayLabel.font = UIFont.systemFont(ofSize: 20)
        eventDayLabel.textColor = UIColor.white
        eventDayLabel.translatesAutoresizingMaskIntoConstraints = false
        blurView.addSubview(eventDayLabel)
        
        let eventMonthLabel = UILabel()
        eventMonthLabel.text = monthfmt.string(from: event.startsAt)
        eventMonthLabel.font = UIFont.boldSystemFont(ofSize: 12)
        eventMonthLabel.textColor = UIColor.white
        eventMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        blurView.addSubview(eventMonthLabel)
        
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventNameLabel.text = event.name
        eventNameLabel.textColor = UIColor.white
        blurView.addSubview(eventNameLabel)
        
        let viewsDict = [
            "blur": blurView,
            "name": eventNameLabel,
            "day": eventDayLabel,
            "month": eventMonthLabel,
            "cover": coverImage
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[cover]|",
                                                                 options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[cover]|",
                                                                  options: [], metrics: nil, views: viewsDict))
        
        
        coverImage.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-65-[blur]|",
                                                                 options: [], metrics: nil, views: viewsDict))
        
        coverImage.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[blur]|",
                                                                 options: [], metrics: nil, views: viewsDict))
        
        blurView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[day][month]",
                                                                  options: [], metrics: nil, views: viewsDict))
        
        blurView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-18-[month]",
                                                               options: [], metrics: nil, views: viewsDict))
        
        blurView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-64-[name]",
                                                               options: [], metrics: nil, views: viewsDict))
        
        eventDayLabel.centerXAnchor.constraint(equalTo: eventMonthLabel.centerXAnchor).isActive = true
        eventNameLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
