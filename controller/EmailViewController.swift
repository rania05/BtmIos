//
//  EmailViewController.swift
//  BTMFINAL
//
//  Created by imen manai on 1/25/21.
//

import UIKit
import Alamofire


class EmailViewController: ViewController {

    @IBOutlet weak var mailFLab: UILabel!
    @IBOutlet weak var emailT: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func confirm(_ sender: Any) {
        let mail: String = emailT.text ?? ""
        
        if CheckForm() {
        let parameters = [ "mail":mail as Any] as [String : Any]

        AF.request("http://192.168.43.142:3000/api/users/forgetpasswordconfirmation/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
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
                    
                }

            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
            
    }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let index = sender as? NSIndexPath
       
  
     
       if segue.identifier == "forgetSegue"{
           
           
           if let destination =  segue.destination as? forgetPasswordViewController{
               destination.mailF = emailT.text
          
       
       
           }
   }
   }
    func isValidEmail(_ email: String) -> Bool {


        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"





        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)


        return emailPred.evaluate(with: email)


    }
    
    
    func CheckForm() -> Bool{



        let mail: String = emailT.text ?? ""


        


       


        


        var B:Bool = true
        
        if ((mail == "") || (mail.count > 40) || !(isValidEmail(mail)))


          {


            DispatchQueue.main.async{


            self.mailFLab.isHidden = false


            self.mailFLab.text = "Mail Not Valid"


            self.emailT.layer.borderWidth = 2


            


            self.emailT.becomeFirstResponder()}


            B = false


        }else


        {


            DispatchQueue.main.async{


            self.emailT.layer.borderWidth = 0


               


            self.emailT.becomeFirstResponder()}


        }


      


       
        return B

}
   
   


}
