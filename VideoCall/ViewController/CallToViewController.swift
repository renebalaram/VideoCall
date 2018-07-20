//
//  ViewController.swift
//  VideoCall
//
//  Created by Admin on 7/18/18.
//  Copyright © 2018 com.rene. All rights reserved.
//

import UIKit

class CallToViewController: UIViewController {
    var currentUser : User!
    @IBOutlet weak var conferenceIDTextField: UITextField!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userNameLabel.text = currentUser.userName
        FireBaseConnector.listenForCalls(user: currentUser) { [unowned self] (user) in
            self.incommingCall(with: user)
        }
    }
    
    func incommingCall(with user: User){
        currentUser = user
        if(user.isInCall){
            self.performSegue(withIdentifier: "goToVideoCall", sender: user)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didJoinVideoCallPressed(_ sender: Any) {
        if let contact = conferenceIDTextField.text{
            FireBaseConnector.call(to: contact, from: currentUser) { [unowned self](message) in
                self.messageLabel.text = message
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? VideoChatViewController,
            let user = sender as? User else {
                return
        }
        vc.currentUser = user
    }
    
}

