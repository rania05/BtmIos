//
//  RegisterViewController.swift
//  btm
//
//  Created by ESPRIT on 11/17/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//
import Alamofire
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var repasswordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    
    
    func setUpElements() {
        
    }
    @IBAction func signupTapped(_ sender: UIButton) {
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let phone = repasswordTextField.text
        let parameters: [String: Any] = [
            "mail" : email,
            "username" : username,
            "password" : password,
            "num" : phone
            
        ]
        AF.request("http://192.168.1.10:3000/users/signup", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
               
                print(response.value)
                
                if response.value == "1"
                  { 
                    self.dismiss(animated: true, completion: nil)

                  }
                  else {
                    
                    print("c bon ak walyt maana")
                  }
            }
        
        
        
    }
    
   

}
