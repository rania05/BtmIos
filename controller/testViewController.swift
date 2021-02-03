




import UIKit


 


import Alamofire





class testViewController: UIViewController {





    


    // Text And Error Fields


    @IBOutlet weak var RegisterButton: UIButton!


    


    @IBOutlet weak var nameField: UITextField!


    @IBOutlet weak var lastNameField: UITextField!


    @IBOutlet weak var userNameField: UITextField!


    @IBOutlet weak var dateField: UIDatePicker!


    @IBOutlet weak var numeroField: UITextField!


    @IBOutlet weak var mailField: UITextField!


    @IBOutlet weak var passwordField: UITextField!


    @IBOutlet weak var adresseField: UITextField!


    @IBOutlet weak var RpasswordField: UITextField!


    @IBOutlet weak var error: UILabel!


    


    


    override func viewDidLoad() {


        super.viewDidLoad()


        


        // Do any additional setup after loading the view.


    }


    func datePickerChanged(selectedDate:UIDatePicker)-> String {


        let dateFormatter = DateFormatter()


        dateFormatter.dateFormat = "MM-dd-YYYY"


        let strDate = dateFormatter.string(from: dateField.date)


        return strDate


    }


    


    func Assign() -> User{


        // getData


        let name: String = nameField.text ?? ""


        let prenom: String = lastNameField.text ?? ""


        let username: String = userNameField.text ?? ""


        let datee:String = datePickerChanged(selectedDate: dateField)


        let date: String = datee


        let num: String = numeroField.text ?? ""


        let mail: String = mailField.text ?? ""


        let password: String = passwordField.text ?? ""


        let adresse: String = adresseField.text ?? ""


        


        let user = User.init(nom: name, prenom: prenom, username: username, adresse: adresse, numero: num, password: password, date:date, mail: mail)


        return user


    }


    


    


    @IBAction func OnRegisterTapped(_ sender: Any) {


        //GetUserData


        let user:User = Assign()


        if(CheckForm())


        {


                let parameters = ["nom":  user.nom as Any , "prenom": user.prenom as Any, "username":user.username as Any, "adresse":user.adresse as Any, "daten": user.date as Any , "mail":user.mail as Any, "num":user.numero as Any, "password":user.password as Any, "role":"Admin"] as [String : Any]





                AF.request("http://localhost:3000/api/users/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON


                { AFdata in


                    do {


                        guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {


                            print("Error: Cannot convert data to JSON object")


                            return


                        }


                        print(jsonObject)


                        let accesstoken:String = jsonObject["token"] as? String ?? "token NotFound"


                        // save token and mail to the keychainewrraper


                        let _: Bool = KeychainWrapper.standard.set(accesstoken, forKey: "accesstoken")


                        let _: Bool = KeychainWrapper.standard.set(user.mail ?? "MailNotFound", forKey: "mailUser")


                        let iduser:Int = jsonObject["id"] as? Int ?? 0


                        let idusr = iduser


                        print("LogIn Id User\(idusr)")


                        let _: Bool = KeychainWrapper.standard.set(idusr , forKey: "id")


                        let _: String? = KeychainWrapper.standard.string(forKey: "accesstoken")


                        let message:String = jsonObject["message"] as! String


                        if (message == "Registred successfully please check your mail to verify youre account")


                        {


                            DispatchQueue.main.async{


                                self.error.isHidden = false


                                self.error.text = message


                                self.error.textColor = UIColor.blue





                            }


                        }else{


                            DispatchQueue.main.async{


                                self.error.isHidden = false


                                self.error.text = message


                            }


                        }


                        


                    } catch {


                        print("Error: Trying to convert JSON data to string")


                        return}


                }


        }


    }





    


    @IBAction func HaveAnAccount(_ sender: Any) {


        self.dismiss(animated: true, completion: nil)


    }


    


    


    func CheckForm() -> Bool{


        


        var B:Bool = true


        let name: String = nameField.text ?? ""


        let prenom: String = lastNameField.text ?? ""


        let username: String = userNameField.text ?? ""


        let num: String = numeroField.text ?? ""


        let mail: String = mailField.text ?? ""


        let password: String = passwordField.text ?? ""


        let passwordR: String = RpasswordField.text ?? ""


        let adresse: String = adresseField.text ?? ""


        


        if !(passwordR == password) || (passwordR == "")


          {


            DispatchQueue.main.async{


            self.error.isHidden = false


            self.error.text = "Not The Same Password Repeated"


            self.RpasswordField.layer.borderWidth = 2


            self.RpasswordField.layer.borderColor =  colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)


            self.RpasswordField.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.RpasswordField.layer.borderWidth = 0


            self.RpasswordField.layer.borderColor =  colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)


            self.RpasswordField.becomeFirstResponder()}


        }


        if ((password == "") || (password.count < 5) || (password.count > 10))


          {


            DispatchQueue.main.async{


            self.error.isHidden = false


            self.error.text = "Password Required and Must be in 5..10"


            self.passwordField.layer.borderWidth = 2


            self.passwordField.layer.borderColor =  colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)


            self.passwordField.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.passwordField.layer.borderWidth = 0


            self.passwordField.layer.borderColor =  colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)


            self.passwordField.becomeFirstResponder()}


        }


        if ((mail == "") || (mail.count > 40) || !(isValidEmail(mail)))


          {


            DispatchQueue.main.async{


            self.error.isHidden = false


            self.error.text = "Mail Not Valid"


            self.mailField.layer.borderWidth = 2


            self.mailField.layer.borderColor =  colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)


            self.mailField.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.mailField.layer.borderWidth = 0


            self.mailField.layer.borderColor =  colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)


            self.mailField.becomeFirstResponder()}


        }


        if ((num == "") || !(num.count == 8) || !(CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: num))))


          {


            DispatchQueue.main.async{


            self.error.isHidden = false


            self.error.text = "This Field Accepts Only 8 Numeric Entries"


            self.numeroField.layer.borderWidth = 2


            self.numeroField.layer.borderColor =  colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)


            self.numeroField.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.numeroField.layer.borderWidth = 0


            self.numeroField.layer.borderColor =  colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)


            self.numeroField.becomeFirstResponder()}


        }


        if ((adresse == "") || (adresse.count < 7) || (adresse.count > 30))


          {


            DispatchQueue.main.async{


            self.error.isHidden = false


            self.error.text = "Username Required and Must be in 7..30"


            self.adresseField.layer.borderWidth = 2


            self.adresseField.layer.borderColor =  colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)


            self.adresseField.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.adresseField.layer.borderWidth = 0


            self.adresseField.layer.borderColor =  colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)


            self.adresseField.becomeFirstResponder()}


        }


        if ((username == "") || (username.count < 3) || (username.count > 10))


          {


            DispatchQueue.main.async{


            self.error.isHidden = false


            self.error.text = "Username Required and Must be in 3..10"


            self.userNameField.layer.borderWidth = 2


            self.userNameField.layer.borderColor =  colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)


            self.userNameField.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.userNameField.layer.borderWidth = 0


            self.userNameField.layer.borderColor =  colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)


            self.userNameField.becomeFirstResponder()}


        }


        if ((prenom == "") || (prenom.count < 3) || (prenom.count > 10))


          {


            DispatchQueue.main.async{


            self.error.isHidden = false


            self.error.text = "lastname is required and Must be in 3..10"


            self.lastNameField.layer.borderWidth = 2


            self.lastNameField.layer.borderColor =  colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)


            self.lastNameField.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.lastNameField.layer.borderWidth = 0


            self.lastNameField.layer.borderColor =  colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)


            self.lastNameField.becomeFirstResponder()}


        }


        if ((name == "") || (name.count < 3) || (name.count > 10))


          {


            DispatchQueue.main.async{


            self.error.isHidden = false


            self.error.text = "name is required and Must be in 3..10"


            self.nameField.layer.borderWidth = 2


            self.nameField.layer.borderColor =  colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)


            self.nameField.becomeFirstResponder()}


            B = false


            


        }else


        {


            DispatchQueue.main.async{


            self.nameField.layer.borderWidth = 0


            self.nameField.layer.borderColor =  colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)


            self.nameField.becomeFirstResponder()}


        }


        return B


    }


    


    


    func isValidEmail(_ email: String) -> Bool {


        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"





        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)


        return emailPred.evaluate(with: email)


    }


}


