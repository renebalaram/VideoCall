//
//  ViewController.swift
//  VideoCall
//
//  Created by Admin on 7/18/18.
//  Copyright © 2018 com.rene. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var conferenceIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didJoinVideoCallPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToVideoCall", sender: nil)
    }
    
}

