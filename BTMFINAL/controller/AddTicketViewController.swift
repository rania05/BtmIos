//
//  AddTicketViewController.swift
//  btm
//
//  Created by imen manai on 12/9/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire

class AddTicketViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    

  
    var moyDB : String?
    var moyen : String?
    var gouver : String?
    var lignee : String?
    var Sdepart : String?
    @IBOutlet weak var moy: UILabel!
    @IBOutlet weak var gouv: UILabel!
    @IBOutlet weak var ligne: UILabel!
    @IBOutlet weak var depart: UILabel!
    @IBOutlet weak var loadmap: UIButton!
    var arriveeDB : String?
    let arrive = ["borjcedria","hammem lif"]
    var pickerData: [String] = [String]()
    var pickerArrivee =  UIPickerView()
    @IBOutlet weak var arrivee: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // Do any additional setup after loading the view.
    }
    @IBAction func acheterAction(_ sender: Any) {
        
        let Nmoyen = moy.text
        let Ndepart = depart.text
        let Nligne = ligne.text
        let Ngouv =  gouv.text
       
        
         
         let parameters: [String: Any] = [
        "moyenTransport": Nmoyen,
            "image": "train",

        "stationDepart":Ndepart,
        "ligne": Nligne,
        "gouv": Ngouv,
      
        "stationArrive": arriveeDB
       
             
             
             
         ]
         
         
         AF.request("http://192.168.1.10:3000/api/tickets", method: .post, parameters: parameters, encoding: JSONEncoding.default)
             .responseString { response in
                 var statusCode = response.response?.statusCode
               print(statusCode)
                 
                 if statusCode == 200
                   {
                    print("ticket ajoutee")
                     
                   }
                   else {
                     
                     print("Check your Information")
                   }
                
             }
        
        
        
    }
    
    @IBAction func Onclickloadmap(_ sender: Any) {
        self.performSegue(withIdentifier: "mapload", sender: self)

        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           
        self.arriveeDB = arrive[row]
        return self.arriveeDB
       }
    
       
    
    
    }
    
    // cell slect

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


