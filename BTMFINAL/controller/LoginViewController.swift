//
//  LoginViewController.swift
//  btm
//
//  Created by ESPRIT on 11/17/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire



class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailF: UITextField!
    
    @IBOutlet weak var codeF: UITextField!
    @IBOutlet weak var passwordF: UITextField!
    @IBOutlet weak var usernameloginTextField: UITextField!
    
    @IBOutlet weak var passwordloginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let Userdefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func check(_ sender: UIButton) {
        let userName = usernameloginTextField.text
        let password = passwordloginTextField.text
        let parameters: [String: Any] = [
            "mail" : userName,
            "password" : password
            
            
        ]
        
        
          AF.request("http://192.168.1.10:3000/api/users/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
              do {
                  guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {
                      print("Error: Cannot convert data to JSON object")
                      return
                  }
              print(jsonObject)
              //retrieve the id
              let id:Int = jsonObject["id"] as? Int ?? 0
              print(id)
              //convert the id
              let idu = String(id)
              print(idu)
              let accesstoken:String = jsonObject["token"] as? String ?? "token NotFound"
              let confirmed:String = jsonObject["message"] as? String ?? "confirmed NotFound"
            

                  
                if (!(accesstoken == "token NotFound")){
                                  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let NavViewController = storyBoard.instantiateViewController(withIdentifier: "Nav") as! UITabBarController

                    self.present(NavViewController, animated: true, completion: nil)
                    UserDefaults.standard.set(true, forKey: "isLogin")
                        UserDefaults.standard.synchronize()
                    

                                  
                               }
                  
            
                  // save token and id to the keychainewrraper
              
              } catch {
                  print("Error: Trying to convert JSON data to string")
                  return
              }
          }
      }
      
    
       
    @IBAction func loginTapped(_ sender: UIButton) {
       
    }
    
    @IBAction func forgertPasszordAction(_ sender: UIButton) {
        AF.request("http://192.168.1.10:3000/api/users/forgetpasswordconfirmation/", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                print(prettyPrintedJson)
                
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
            

        }
    
    }
 

}


