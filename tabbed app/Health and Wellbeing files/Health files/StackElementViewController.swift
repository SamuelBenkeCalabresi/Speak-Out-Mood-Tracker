//
//  StackElementViewController.swift
//  Speak Out!
//
//  Created by admin on 05/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class StackElementViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var knowMoreButton: UIButton!
    @IBOutlet weak var contentPageTextView: UITextView!
    
    var urlForButton = ""
    
    // Computed property to set title of view
    var headerString: String? {
        didSet {
            configureTitleView()
        }
    }
    // Computed property to set content of view
    var bodyString: String? {
        didSet {
            configureContentView()
        }
    }
    
    func configureTitleView () {
        headerLabel.text = headerString
    }
    
    func configureContentView () {
        contentPageTextView.text = bodyString
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func openURL(_ sender: UIButton) {
        openWebsiteInSafari(with: urlForButton)
    }
    
    func openWebsiteInSafari(with link:String) {
        guard let url = URL(string: link) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    override func viewDidLayoutSubviews() {
        contentPageTextView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }

}
