//
//  LogInViewController.swift
//  VideoCall
//
//  Created by Admin on 7/20/18.
//  Copyright © 2018 com.rene. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController{
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        if let userName = userTextField.text, let userPassword = passwordTextField.text {
            FireBaseConnector.logIn(userName: userName, userPassword: userPassword){ [unowned self] user, error in
                if let _ = error {
                    self.errorLabel.text = "Wrong Password"
                }
                if let user = user{
                    self.performSegue(withIdentifier: "LoggedIn", sender: user)
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ct = segue.destination as? CallToViewController,
            let user = sender as? User else {
                return
        }
        ct.currentUser = user
        
    }
}
