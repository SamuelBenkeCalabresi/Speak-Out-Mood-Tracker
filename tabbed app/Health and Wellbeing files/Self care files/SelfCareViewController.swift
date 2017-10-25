//
//  SelfCareViewController.swift
//  Speak Out!
//
//  Created by admin on 03/07/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class SelfCareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))

    }
    
    func backAction(){
        dismiss(animated: true, completion: nil)
    }

}
