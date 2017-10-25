//
//  BarnetMenuViewController.swift
//  Speak Out!
//
//  Created by admin on 27/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class BarnetMenuViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        showViewControllerForSegment(index)
    }
    
    var activeViewController: UIViewController? {
        didSet {
            oldValue?.view.removeFromSuperview()
            
            guard let activeViewController = activeViewController else { return }
            activeViewController.view.frame = contentView.bounds
            contentView.addSubview(activeViewController.view)
            activeViewController.didMove(toParentViewController: self)
        }
    }
    
    // To show from the first time the BarGraphViewController when the MoodStatistics is segued from the bar menu (YES!)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let strongSelf = self
        strongSelf.showViewControllerForSegment(strongSelf.segmentedControl.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showViewControllerForSegment(_ index: Int) {
        let viewController = viewControllerForSegment(index)
        activeViewController = viewController
    }
    
    func viewControllerForSegment(_ index: Int) -> UIViewController {
        switch index {
        case 0:   return storyboard!.instantiateViewController(withIdentifier: "MapOfBarnetViewController")
        case 1:   return storyboard!.instantiateViewController(withIdentifier: "GetInvolvedViewController")
        default:  return UIViewController()
        }
    }

}
