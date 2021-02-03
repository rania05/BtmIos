//
//  LoginViewController.swift
//  btm
//
//  Created by ESPRIT on 11/17/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SQLite


class LoginViewController: UIViewController {
    
   
    @IBOutlet weak var usernameloginTextField: UITextField!
    
    @IBOutlet weak var pwdLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var passwordloginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let Userdefaults = UserDefaults.standard
    let userRepo = UserRepository()
    let db = localDB()
    var users:[User] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func checkLogin() {
        users = db.read()
        if (users.count > 0 ){
            print(users.count)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let NavViewController = storyBoard.instantiateViewController(withIdentifier: "Nav") as! UITabBarController
            self.present(NavViewController, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 20.0
        
    
    }
    
    @IBAction func check(_ sender: UIButton) {
        let userName = usernameloginTextField.text
        let password = passwordloginTextField.text
        
        if CheckForm() {
        let parameters: [String: Any] = [
            "mail" : userName,
            "password" : password
       
            
        ]
        userRepo.loginUser(email: userName!, password: password!) { (user) in
            self.Userdefaults.setValue(true, forKey: "isLogin")
            self.Userdefaults.setValue(user.id!, forKey: "id")
            self.Userdefaults.setValue(user.nom!, forKey: "nom")
            self.Userdefaults.setValue(user.prenom!, forKey: "prenom")
            self.Userdefaults.setValue(user.daten!, forKey: "daten")



            self.Userdefaults.setValue(user.username!, forKey: "username")
            self.Userdefaults.setValue(user.mail!, forKey: "mail")
            self.Userdefaults.setValue(user.num!, forKey: "num")
            self.Userdefaults.setValue(user.adresse!, forKey: "adresse")





            self.db.insertUser(id: user.id!, email: "String", password: "lol")
            print(user.id!)
            print(user.username!)
           
        }
        
        
          AF.request("http://192.168.43.142:3000/api/users/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
             do {
               guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                   return
               };              print(jsonObject)
             //retrieve the id
            let id:Int = jsonObject["id"] as? Int ?? 0
              self.Userdefaults.setValue(id, forKey: "id" )
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

//
//
                               }
//
//
//                  // save token and id to the keychainewrraper
//
//
                
                
             } catch {
                 print("Error: Trying to convert JSON data to string")
                  return
              }
          }
      }
      
    }
       
    @IBAction func loginTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func forgertPasszordAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NavViewController = storyBoard.instantiateViewController(identifier: "forget")

        self.present(NavViewController, animated: true, completion: nil)
        
    
    }
    func isValidEmail(_ email: String) -> Bool {


        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"





        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)


        return emailPred.evaluate(with: email)


    }
    
     func CheckForm() -> Bool{

         let mail: String = usernameloginTextField.text ?? ""
         let password: String = passwordloginTextField.text ?? ""
         var B:Bool = true
         
         if ((mail == "")  || !(isValidEmail(mail)))

           {
             DispatchQueue.main.async{
             self.mailLabel.isHidden = false
             self.mailLabel.text = "Mail Non Valide"
             self.usernameloginTextField.layer.borderWidth = 2
             self.usernameloginTextField.becomeFirstResponder()}
             B = false

         }else

         {
             DispatchQueue.main.async{
             self.usernameloginTextField.layer.borderWidth = 0
             self.usernameloginTextField.becomeFirstResponder()}


         }

        if ((password == ""))


          {
            DispatchQueue.main.async{
            self.pwdLabel.isHidden = false
            self.pwdLabel.text = "Longueur entre 5 et10"
            }


            B = false
        }else

        {
            DispatchQueue.main.async{
            }

        }

         return B

 }
    
    
 

}



