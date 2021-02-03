//
//  ProfileViewController.swift
//  BTMFINAL
//
//  Created by imen manai on 12/30/20.
//

import UIKit
import Alamofire
import PKHUD


class ProfileViewController: UIViewController {
   
    @IBOutlet weak var Editprofile: UIButton!
    let Userdefaults = UserDefaults.standard

    
    @IBOutlet weak var daten: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var logout: UIButton!
    var db = localDB()
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = UserDefaults.standard.string(forKey: "username")
        nom.text =  UserDefaults.standard.string(forKey: "mail")
        prenom.text = UserDefaults.standard.string(forKey: "numero")
        daten.text = UserDefaults.standard.string(forKey: "adress")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func deco(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let aNavViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.present(aNavViewController, animated: true, completion: nil)
        UserDefaults.standard.removeObject(forKey: "isLogin")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "nom")
        UserDefaults.standard.removeObject(forKey: "prenom")
        UserDefaults.standard.removeObject(forKey: "mail")
        UserDefaults.standard.removeObject(forKey: "daten")



    }
    

    @IBAction func modifier(_ sender: Any) {
        let usernamee = username.text
        let email = nom.text
        let numero = prenom.text
        let password = mail.text
        let adress = daten.text

        let parameters: [String: Any] = [
            "id" : UserDefaults.standard.string(forKey: "id"),
            "username" : usernamee,
            "nom" : UserDefaults.standard.string(forKey: "nom"),
            "prenom" : UserDefaults.standard.string(forKey: "prenom"),
            "daten" : UserDefaults.standard.string(forKey: "daten"),
            "num" : numero,
            "mail" : email,
            "password" : password,
            "adresse" : adress,
            "role" : "user",
            
            
        ]
        AF.request("http://192.168.43.142:3000/api/users", method: .patch, parameters: parameters, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299)
            .responseString { response in
               
                var statusCode = response.response?.statusCode
                print(response.value)
                
                if statusCode == 201
                  {
                    self.Userdefaults.setValue(email!, forKey: "mail")
                    self.Userdefaults.setValue(numero, forKey: "num")
                    self.Userdefaults.setValue(usernamee!, forKey: "username")
                    self.Userdefaults.setValue(adress, forKey: "adress")
                    HUD.flash(.progress, delay: 2.0)

                    
                  }
                  else {
                    
                    print("c bon ak walyt maana")
                    HUD.flash(.progress, delay: 2.0)
                    HUD.flash(.success, delay: 1.0)


                  }
            }
    }
}
