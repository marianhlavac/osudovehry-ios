//
//  IntroViewController.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 23/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    var stackView: UIStackView!
    var introCallback: ((Void) -> Void)!
    
    init(introCallback: @escaping ((Void) -> Void)) {
        super.init(nibName: nil, bundle: nil)
        self.introCallback = introCallback
        
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "OsudoveHryLogo"))
        logoImageView.contentMode = .center
        
        let firstTextLabel = UILabel()
        firstTextLabel.text = "Intro 01".localized
        firstTextLabel.lineBreakMode = .byWordWrapping
        firstTextLabel.numberOfLines = 0
        
        let callToActionButton = UIButton(type: .roundedRect)
        callToActionButton.setTitle("Alrighty then!", for: .normal)
        callToActionButton.addTarget(self, action: #selector(IntroViewController.skipIntro), for: .touchUpInside)
        callToActionButton.frame = CGRect(x: 0, y: 0, width: 220, height: 20)
        callToActionButton.backgroundColor = UIColor.white
        
        stackView = UIStackView(arrangedSubviews: [logoImageView, firstTextLabel, callToActionButton])
        stackView.axis = .vertical
        stackView.frame = view.bounds
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "IntroPatternBackground"))
        view.addSubview(stackView)
        
        // Constraints
        
        let viewDict = [
            "super": view,
            "logo": logoImageView,
            "text": firstTextLabel,
            "cta": callToActionButton
        ]
        /*
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[cta]-60-|",
                                                           options: .alignAllCenterX, metrics: nil, views: viewDict))*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func skipIntro() {
        introCallback()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
