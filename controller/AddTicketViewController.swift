//
//  AddTicketViewController.swift
//  btm
//
//  Created by imen manai on 12/9/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import Braintree
import UserNotifications
import SwiftyJSON
import PKHUD


class AddTicketViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource, BTViewControllerPresentingDelegate, BTAppSwitchDelegate {
    var data: [JSON] = []
    var x : String?
    var yii : Int? = 1
    var l1 : Int? = 1
    var l2 : Int? = 1
    var db = localDB()
    var user = User()
    var stations : [Station] = []
    var lignee : String?
    var prix = 500
    let Userdefaults = UserDefaults.standard

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
        self.arriveeDB = arrive[row]
            
        return self.arriveeDB
        default:
            return " data not found"
            
        }
       }

    // houni nekhdem
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            arrivee.text =  arrive[row]

           
            StationRepository().getStationByLigne(lig: lignee!) { [self] (String) in
           
              
              
                self.arrivee.resignFirstResponder()
                
               
                

            }
            getleve2(arr: arrive[row])
            print("enqq l2",self.l2!)
            if abs(l2! - l1!) % 3 == 0{
                prix = abs(l2! - l1!) * 150 + 500
                price.text = String(prix)
            }
            else {prix = 500
                price.text = String(prix)
            }


        default:
            return
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return arrive.count
        
      
            
        default:
            return 1
            
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
    
    var braintreeClient: BTAPIClient?

    

    var idMoy : Int?
    var moyDB : String?
    var moyen : String?
    var gouver : String?
    var Sdepart : String?
   
    var nb : Int?
    @IBOutlet weak var moy: UILabel!
    @IBOutlet weak var gouv: UILabel!
    @IBOutlet weak var ligne: UILabel!
    @IBOutlet weak var depart: UILabel!
    @IBOutlet weak var loadmap: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var buyb: UIButton!
    @IBOutlet var locnow: UIView!
    @IBOutlet weak var locc: UIButton!
    var arriveeDB : String?
    var arrive = ["Zahra","rades","benArous","raoued"]
    var pickerData: [String] = [String]()
    var pickerArrivee =  UIPickerView()
    @IBOutlet weak var arrivee: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buyb.layer.cornerRadius = 20.0
        loadmap.layer.cornerRadius = 20.0
        locc.layer.cornerRadius = 20.0

        braintreeClient = BTAPIClient(authorization: "sandbox_nd8qxtgf_4s6xrp2ph9qqczdw")!
     

        arrivee.placeholder = "station de arrivee"
        arrivee.textAlignment = .center
        arrivee.inputView =  pickerArrivee
        pickerArrivee.delegate = self
        pickerArrivee.dataSource = self
        pickerArrivee.tag = 1
        moy.text = moyen!
        gouv.text = gouver!
        ligne.text = lignee!
        depart.text = Sdepart!
        price.text = String (prix)
        getData1()
        getlevel(dp: Sdepart!)
        print("enqq l!",self.l1!)
        print(self.yii!,"inside ena ")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Onclickloadmap(_ sender: Any) {
        self.performSegue(withIdentifier: "mapload", sender: self)

        
        
        
    }
    
    @IBAction func acheterAction(_ sender: Any) {
        
        let Nmoyen = moy.text
        let Ndepart = depart.text
        let Nligne = ligne.text
        let Ngouv =  gouv.text
        let p =  700
        user = db.read()[0]
        let iduser = UserDefaults.standard.string(forKey: "id")

        if yii! == 1 {
            payer()

        }
        else
        {
print("aandou abonnement")        }
         
         let parameters: [String: Any] = [
        "moyenTransport": Nmoyen,
        "image": "null",
        "stationDepart":Ndepart,
        "ligne": Nligne,
        "prix": p,
        "gouv": Ngouv,
        "iduser": iduser,
        "stationArrive": arriveeDB,
            "dateD": "null",
            "dateF": "null"

            
            
         ]
     
       
      
            
         
         
         AF.request("http://192.168.43.142:3000/api/tickets", method:
                        .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString {  response in
                 var statusCode = response.response?.statusCode
               print(statusCode)
                 
                 if statusCode == 200
                   {
                    print("ticket ajoutee")
                    self.nb = self.nb! - 1
                    self.modifierPlaces(nbPlaces: self.nb!)
                    HUD.flash(.success, delay: 1.0)

                    
                    
                   }
                   else {
                     
                     print("Check your Information")
                   }
                
             }
                
                let center = UNUserNotificationCenter.current()
                let content = UNMutableNotificationContent()
                content.title = "Reminder"
                content.body  = "vous avez reserver un ticket , n oubliez pas l horraire"
                content.sound  = .default
                let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
                
                center.add(request)
                {(error) in
                    if error != nil  {
                        print("error \(error? .localizedDescription ?? "error locql notif " )")
                }
            
                }
        
        
    }
    
     
        
        
        
    
    func modifierPlaces( nbPlaces : Int  ) {
      
       
            
        print("enaa idmoy",idMoy!)
        print("nbPlaace",nbPlaces)
      
        AF.request("http://192.168.43.142:3000/api/Station/nb/\(idMoy!)/\(nbPlaces)", method: .patch, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299)
            .responseString { response in
               
                var statusCode = response.response?.statusCode
                print(response.value)
                
                if statusCode == 201
                  {
                   
                    print("erreur")
                  }
                  else {
                    
                    print("c bon ak walyt maana")
                  }
            }
    
            
        }
    func getData1() {

        self.data = []
        let  id = UserDefaults.standard.string(forKey: "id")
        let Nmoyen = moy.text

        //IP SELIM http://192.168.1.17:3000/api/tickets
        //IP esprit bloc a http://172.16.158.52:3000/api/tickets
        AF.request("http://192.168.43.142:3000/api/abonnements/duree/\(id!)/\(Nmoyen!)" , method: .get ).responseJSON { response in
            let json = try! JSON(data:response.data! , options: .allowFragments)
            if let item = json["data"].array{
                
            for i in item {
                
                 let  d = i["duration"].int
                print( d ,"enaa d")
                
                let  dd = i["duree"].string
                let dint = Double(dd!)
                print( dint ,"enaa dint")
                if ((abs(dint!)*30.417) > Double(d!))
                {
                    
                    self.yii!+=1
                    print(self.yii!,"inside ena ")
                    
                }
                
               
                
                }
                
        
            }
           

        
        
    }

        
    }
 
   

    
  





    
  
func payer(){
    let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
            payPalDriver.viewControllerPresentingDelegate = self
            payPalDriver.appSwitchDelegate = self // Optional
   
    let request = BTPayPalRequest(amount: "2.14")
            request.currencyCode = "EUR" // Optional; see BTPayPalRequest.h for more options

       
         payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
             if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                 print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                HUD.flash(.success, delay: 1.0)


                 // Access additional information
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
}
    
}


    
    
    func getlevel(dp : String) {

        self.data = []
       

        //IP SELIM http://192.168.1.17:3000/api/tickets
        //IP esprit bloc a http://172.16.158.52:3000/api/tickets
        AF.request("http://192.168.43.142:3000/api/Station/level/\(dp)/" , method: .get ).responseJSON { response in
            let json = try! JSON(data:response.data! , options: .allowFragments)
            if let item = json["data"].array{
                
            for i in item {
                
                 let  d = i["level"].int
                print("levelllll1",d)
                self.l1 = d!
                
               
                
                }
                
        
            }
           

        
        
    }
       
    
    
    }
    
    func getleve2(arr : String) {

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
    

}
   

