//
//  RegisterViewController.swift
//  btm
//
//  Created by ESPRIT on 11/17/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//
import Alamofire
import UIKit
import PKHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var repasswordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var error: UILabel!
    
    @IBOutlet weak var uLabel: UILabel!
    
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var fLabel: UILabel!
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
        if CheckForm() {
            
        
        let parameters: [String: Any] = [
            "mail" : email,
            "username" : username,
            "password" : password,
            "num" : phone,
            "nom" :  "null" ,
            "prenom" :  "null" ,
            "role" :  "null" ,
            "daten" :  "1997-06-01 23:58:57" ,
            "adresse" :  "null"

            
        ]
        AF.request("http://192.168.43.142:3000/api/users/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
               
                print(response.value)
                
                if response.value == "1"
                  {
                    self.dismiss(animated: true, completion: nil)
                    HUD.flash(.progress, delay: 1.0)


                  }
                  else {
                    HUD.flash(.progress, delay: 1.0)

                    
                    print("c bon ak walyt maana")
                  }
            }
        }
        
        
        
    }
    
    func isValidEmail(_ email: String) -> Bool {


        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"





        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)


        return emailPred.evaluate(with: email)


    }
    
     func CheckForm() -> Bool{



         let username: String = usernameTextField.text ?? ""


         let num: String = repasswordTextField.text ?? ""


         let mail: String = emailTextField.text ?? ""


         let password: String = passwordTextField.text ?? ""




         


         var B:Bool = true
         
         if ((mail == "") || (mail.count > 40) || !(isValidEmail(mail)))


           {


             DispatchQueue.main.async{


             self.mLabel.isHidden = false


             self.mLabel.text = "Mail Non Valide"


             self.emailTextField.layer.borderWidth = 2


             


             self.emailTextField.becomeFirstResponder()}


             B = false


         }else


         {


             DispatchQueue.main.async{


             self.emailTextField.layer.borderWidth = 0


                


             self.emailTextField.becomeFirstResponder()}


         }


         if ((num == "") || !(num.count == 8) || !(CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: num))))


           {


             DispatchQueue.main.async{


             self.cLabel.isHidden = false


             self.cLabel.text = " 8 caracteres max "


             self.repasswordTextField.layer.borderWidth = 2


             


             self.repasswordTextField.becomeFirstResponder()}


             B = false


         }else


         {


             DispatchQueue.main.async{


             self.repasswordTextField.layer.borderWidth = 0


          


             self.repasswordTextField.becomeFirstResponder()}


         }

        if ((password == "") || (password.count < 5) || (password.count > 10))


          {


            DispatchQueue.main.async{


            self.fLabel.isHidden = false


            self.fLabel.text = "longueur entre 5 et10"


            self.passwordTextField.layer.borderWidth = 2


           


            self.passwordTextField.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.passwordTextField.layer.borderWidth = 0


            


            self.passwordTextField.becomeFirstResponder()}


        }

        if ((username == "") || (username.count < 5) || (username.count > 7))


          {


            DispatchQueue.main.async{


            self.error.isHidden = false


            self.error.text = "longueur entre  5..7"


            self.usernameTextField.layer.borderWidth = 2


           


            self.usernameTextField.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.usernameTextField.layer.borderWidth = 0


            


            self.usernameTextField.becomeFirstResponder()}


        }
         
         return B

 }
    
    



}
    
   

