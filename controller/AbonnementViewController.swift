//
//  AbonnementViewController.swift
//  btm

//  Created by imen manai on 12/3/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD


import Braintree
class AbonnementViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource , BTViewControllerPresentingDelegate, BTAppSwitchDelegate {
    var data: [JSON] = []

    var db = localDB()
    var user = User()
    var l1 : Int? = 1
    var prix = 30

    @IBOutlet weak var valider: UIButton!
    @IBOutlet weak var price: UILabel!
    var l2 : Int? = 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var stations : [Station] = []
    var stations1 : [Station] = []
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return moyenTransport.count
        
        case 2:
            return gouv.count
        case 3:
            return ligne.count
        case 4:
            return depart.count
        case 5:
            return arrivee.count
        case 6:
            return duree.count
            
        default:
            return 1
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            
            self.moyDB =  moyenTransport[row]
            return self.moyDB
            
        
        case 2:
            self.gouvDB =  gouv[row]
            return self.gouvDB
        case 3:
            self.ligneDB = ligne[row]
            return self.ligneDB
        case 4:
            self.departDB =  depart[row]
            return self.departDB
        case 5:
            self.arriveeDB =  arrivee[row]
            return self.arriveeDB
        case 6:
            self.dureeDB  = duree[row]
            return self.dureeDB
            
        default:
            return " data not found"
            
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        
        performSegue(withIdentifier: "profile", sender:self)

                return
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            moyenPicker.text =  moyenTransport [row]
            
            StationRepository().getStationByTransport(nom: moyenTransport[row]) { (list) in
                self.stations = list;
                self.gouv = []
                
                for i in list {
                    self.gouv.append(i.gouv!)
                    
                }
                
                self.moyenPicker.resignFirstResponder()
            }
        
        case 2:
            gouvPicker.text =  gouv[row]
            StationRepository().getStationByVille(ville: gouv[row]) { (list) in
                self.stations = list;
              
                self.ligne  = []
                for i in list {
            
                    self.ligne.append(i.ligne!)
                }
                
                self.gouvPicker.resignFirstResponder()
            }
           
        case 3:
            lignePicker.text  = ligne[row]
            StationRepository().getStationByLigne(lig: ligne[row]) { (list) in
                self.stations = list;
              
                self.depart  = []
                self.arrivee  = []
                for i in list {
            
                    self.depart.append(i.nom!)
                    self.arrivee.append(i.nom!)
                }
                
                self.lignePicker.resignFirstResponder()
            }
            
        case 4:
            departPicker.text = depart[row]
            departPicker.resignFirstResponder()
            getleve1(arr: depart[row])
            print("enqq l1",self.l1!)
                prix = 15
                price.text = String(prix)

        case 5:
            arriveePicker.text =  arrivee[row]
            arriveePicker.resignFirstResponder()
            getleve2(arr: arrivee[row])
            print("enqq l2",self.l2!)
            if abs(l2! - l1!) % 3 == 0{
                prix = abs(l2! - l1!) * 12 + 30
                price.text = String(prix)
            }
            else {prix = 40
                price.text = String(prix)
            }
        case 6:
            dureePicker.text =  duree[row]
            dureePicker.resignFirstResponder()
            
            price.text = String(prix*Int(duree[row])!)
            
        default:
            return
            
        }
    }
  
    
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
    @IBOutlet weak var dureePicker: UITextField!
    
  
    @IBOutlet weak var arriveePicker: UITextField!
  
    @IBOutlet weak var departPicker: UITextField!
    
  
    @IBOutlet weak var lignePicker: UITextField!
    
    @IBOutlet weak var gouvPicker: UITextField!
    
    @IBOutlet weak var moyenPicker: UITextField!
    var braintreeClient: BTAPIClient?
    var moyDB : String?
    var gouvDB : String?
    var ligneDB : String?
    var departDB : String?
    var arriveeDB : String?
    var dureeDB : String?
 
    
    let moyenTransport = ["bus","train","metro"]
    
    var gouv = ["benarous","Tunis","Ariana"]

    var ligne = ["bonlieu sud","bonlieu nord"]
    
    var depart = ["Zahra","rades","benArous","raoued"]
    var arrivee = ["Zahra","rades","benArous","ghazela"]

    
    let duree = ["1","3","6","12"]
    
   var pickermoy =  UIPickerView()
   var pickerGouv =  UIPickerView()
   var pickerLigne =  UIPickerView()
   var pickerDepart =  UIPickerView()
   var pickerArrivee =  UIPickerView()
   var pickerDuree =  UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        braintreeClient = BTAPIClient(authorization: "sandbox_nd8qxtgf_4s6xrp2ph9qqczdw")!
        moyenPicker.placeholder = "moyen de transport"
        gouvPicker.placeholder = "gouvernerat "
        lignePicker.placeholder = "ligne"
        departPicker.placeholder = "station de depart"
        arriveePicker.placeholder = "station de arrivee"
        dureePicker.placeholder = " duree"
        moyenPicker.textAlignment = .center
        gouvPicker.textAlignment = .center
        lignePicker.textAlignment = .center
        departPicker.textAlignment = .center
        arriveePicker.textAlignment = .center
        dureePicker.textAlignment = .center
        gouvPicker.inputView =  pickerGouv
        moyenPicker.inputView =  pickermoy
        departPicker.inputView =  pickerDepart
        arriveePicker.inputView =  pickerArrivee
        dureePicker.inputView =  pickerDuree
        lignePicker.inputView =  pickerLigne
        pickermoy.delegate = self
        pickerGouv.delegate = self
        pickerLigne.delegate = self
        pickerDepart.delegate = self
        pickerArrivee.delegate = self
        pickerDuree.delegate = self
        pickermoy.dataSource = self
        pickerGouv.dataSource = self
        pickerLigne.dataSource = self
        pickerDepart.dataSource = self
        pickerArrivee.dataSource = self
        pickerDuree.delegate = self
        pickermoy.tag = 1
        pickerGouv.tag = 2
        pickerLigne.tag = 3
        pickerDepart.tag = 4
        pickerArrivee.tag = 5
        pickerDuree.tag = 6
        valider.layer.cornerRadius = 20.0
        

    }
    
    @IBAction func afficher(_ sender: Any) {
        self.performSegue(withIdentifier: "affSegue", sender: self)
        
    }
    
    @IBAction func AbonnementAction(_ sender: UIButton) {
        user = db.read()[0]
        let iduser = UserDefaults.standard.string(forKey: "id")

    print("iddddddddd",iduser)
         
         let parameters: [String: Any] = [
           
            "moyenTransport": moyDB,
            "gouv": gouvDB ,
            
            "ligne": ligneDB,
            "depart": departDB,
            "arrive": arriveeDB,
            "iduser": iduser,
            "duree": dureeDB,
            "prix" : 2.17
           
           
             
             
             
         ]
        print("debut payement")
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
                payPalDriver.viewControllerPresentingDelegate = self
                payPalDriver.appSwitchDelegate = self // Optional
          print("khdhit el code")
        let request = BTPayPalRequest(amount: "2.14")
                request.currencyCode = "EUR" // Optional; see BTPayPalRequest.h for more options

              print("taada el usd")
             payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                 if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                     print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
print (" jawi behy")
                     // Access additional information
                    HUD.flash(.success, delay: 1.0)

                     let email = tokenizedPayPalAccount.email
                     let firstName = tokenizedPayPalAccount.firstName
                     let lastName = tokenizedPayPalAccount.lastName
                     let phone = tokenizedPayPalAccount.phone

                     // See BTPostalAddress.h for details
                     let billingAddress = tokenizedPayPalAccount.billingAddress
                     let shippingAddress = tokenizedPayPalAccount.shippingAddress
                 } else if let error = error {
                     // Handle error here...
                 } else {
                     // Buyer canceled payment approval
                 }
         
         
         AF.request("http://192.168.43.142:3000/api/abonnements", method: .post, parameters: parameters, encoding: JSONEncoding.default)
             .responseString { response in
                 var statusCode = response.response?.statusCode
               
                
                 if statusCode == 200
                   {
                    print("abonnement ajoutee")

                    
                   }
                   else {
                     
                     print("Check your Information")
                   }
                
             }
        
        
        
    }
  
     
    
}
    
    
    func getleve1(arr : String) {

        self.data = []
        var x = 1
        print("enaa aar",arr)
        //IP SELIM http://192.168.1.17:3000/api/tickets
        //IP esprit bloc a http://172.16.158.52:3000/api/tickets
        AF.request("http://192.168.43.142:3000/api/Station/level/\(arr)/" , method: .get ).responseJSON { response in
            let json = try! JSON(data:response.data! , options: .allowFragments)
            if let item = json["data"].array{
                
            
                for i in item {
                    let  dd = i["level"].int
                print("levelllll2",dd)
                    self.l2 = dd!

                }
                
                
                
               
                
                
        
            }
            
           

        
        
    }
       
    
    
    }
    

    func getleve2(arr : String) {

        self.data = []
        print("enaa aar",arr)
        //IP SELIM http://192.168.1.17:3000/api/tickets
        //IP esprit bloc a http://172.16.158.52:3000/api/tickets
        AF.request("http://192.168.43.142:3000/api/Station/level/\(arr)/" , method: .get ).responseJSON { response in
            let json = try! JSON(data:response.data! , options: .allowFragments)
            if let item = json["data"].array{
                
            
                for i in item {
                    let  dd = i["level"].int
                print("levelllll2",dd)
                    self.l2 = dd!

                }
                
                
                
               
                
                
        
            }
            
           

        
        
    }
       
    
    
    }
    


}
