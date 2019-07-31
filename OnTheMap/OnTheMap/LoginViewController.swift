//
//  ViewController.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-07-26.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


    @IBAction func loginAction(_ sender: Any) {
        OTMClient.requestSession(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleSessionRequest(success:error:))
       
    }
    func handleSessionRequest(success:Bool ,error:Error?){
        if success{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "Show", sender: nil)
            }
            
            }
        }
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Show" {
//            let desVc = segue.destination as! MapViewController
//            
//        }
//    }


