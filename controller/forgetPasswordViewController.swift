//
//  forgetPasswordViewController.swift
//  btm
//
//  Created by imen manai on 12/16/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit

import Alamofire

class forgetPasswordViewController: UIViewController {

    @IBOutlet weak var cd: UILabel!
    @IBOutlet weak var pass: UILabel!
    @IBOutlet weak var errorL: UILabel!
    @IBOutlet weak var codeFT: UITextField!
    @IBOutlet weak var passwordFT: UITextField!
    var mailF : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onResetPassClicked(_ sender: UIButton) {
        let password: String = passwordFT.text ?? ""
        let code: String = codeFT.text ?? ""
print("teeeeest",mailF)
        
        
        
        if CheckForm() {
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        let parameters = [ "mail":mailF as Any, "password":password, "code":code] as [String : Any]
        
        AF.request("http://192.168.43.142:3000/api/users/forgetpasswordchange/", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
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
                
                DispatchQueue.main.async{
                    self.errorL.text = jsonObject["message"] as? String ?? "ma3malch update password"
                }
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
            
        }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func CheckForm() -> Bool{



      


        


        let password: String = passwordFT.text ?? ""


        let code: String = codeFT.text ?? ""

        


        var B:Bool = true
        
        
         if (password == "")


           {


             DispatchQueue.main.async{


             self.cd.isHidden = false


             self.cd.text = "Longueur entre 5 et 10"


             self.codeFT.layer.borderWidth = 2


            


             self.codeFT.becomeFirstResponder()}


             B = false


         }else


         {


             DispatchQueue.main.async{


             self.codeFT.layer.borderWidth = 0


             


             self.codeFT.becomeFirstResponder()}


         }


      
       if ((password == "") || (password.count < 5) || (password.count > 10))


         {


           DispatchQueue.main.async{


           self.pass.isHidden = false


           self.pass.text = "Longueur entre 5 et 10"


           self.passwordFT.layer.borderWidth = 2


          


           self.passwordFT.becomeFirstResponder()}


           B = false


       }else


       {


           DispatchQueue.main.async{


           self.passwordFT.layer.borderWidth = 0


           


           self.passwordFT.becomeFirstResponder()}


       }

       
        return B

}
   
   


}

