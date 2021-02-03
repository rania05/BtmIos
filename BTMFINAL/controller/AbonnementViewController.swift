//
//  AbonnementViewController.swift
//  btm
//
//  Created by imen manai on 12/3/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire

class AbonnementViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var dureePicker: UITextField!
    
  
    @IBOutlet weak var arriveePicker: UITextField!
  
    @IBOutlet weak var departPicker: UITextField!
    
  
    @IBOutlet weak var lignePicker: UITextField!
    
    @IBOutlet weak var gouvPicker: UITextField!
    
    @IBOutlet weak var moyenPicker: UITextField!
    
    var moyDB : String?
    var gouvDB : String?
    var ligneDB : String?
    var departDB : String?
    var arriveeDB : String?
    var dureeDB : String?
 
    
    let moyenTransport = ["bus","train","metro"]
    
    let gouv = ["ben arous","tunis","ariana"]

    let ligne = ["bonlieu sud","bonlieu nord"]
    
    let depart = ["megrine","rades","zhara"]
    
    let arrivee = ["borjcedria","hammem lif"]
    
    let duree = ["1 mois","3 mois","1 ans"]
    
   var pickermoy =  UIPickerView()
   var pickerGouv =  UIPickerView()
   var pickerLigne =  UIPickerView()
   var pickerDepart =  UIPickerView()
   var pickerArrivee =  UIPickerView()
   var pickerDuree =  UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
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
        

    }
    
    @IBAction func afficher(_ sender: Any) {
        self.performSegue(withIdentifier: "affSegue", sender: self)
        
    }
    
    @IBAction func AbonnementAction(_ sender: UIButton) {
       
         
         let parameters: [String: Any] = [
            
            "moyenTransport": moyDB,
            "gouv": gouvDB ,
            
            "ligne": ligneDB,
            "depart": departDB,
            "arrive": arriveeDB,
            "duree": dureeDB
           
           
             
             
             
         ]
         
         
         AF.request("http://192.168.1.10:3000/api/abonnements", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            moyenPicker.text =  moyenTransport [row]
            moyenPicker.resignFirstResponder()
        
        case 2:
            gouvPicker.text =  gouv[row]
            gouvPicker.resignFirstResponder()
        case 3:
            lignePicker.text  = ligne[row]
            lignePicker.resignFirstResponder()
        case 4:
            departPicker.text = depart[row]
            departPicker.resignFirstResponder()
        case 5:
            arriveePicker.text =  arrivee[row]
            arriveePicker.resignFirstResponder()
        case 6:
            dureePicker.text =  duree[row]
            dureePicker.resignFirstResponder()
            
        default:
            return
            
        }
    }
    
    
}
