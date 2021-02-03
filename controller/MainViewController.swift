//
//  MainViewController.swift
//  btm
//
//  Created by ESPRIT on 11/17/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire


class MainViewController: UIViewController {
   
    
    @IBOutlet weak var ville: UITextField!
    @IBOutlet weak var depart: UITextField!
    @IBOutlet weak var arriver: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
   
    @IBAction func ajoutabonnement(_ sender: UIButton) {
        let villee = ville.text
        let deppart = depart.text
        let arrriver = arriver.text
        
        
        let parameters: [String: Any] = [
            "ville" : villee,
            "depart" : deppart,
            "destination" : arrriver
            
        ]
    
    AF.request("http://192.168.43.142:3000/Abonnement/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseString { response in
            var statusCode = response.response?.statusCode
            print(response.value)
            
            if statusCode == 201
              {
                print("abon added")
                
              }
              else {
                
                print("c bon ak walyt maana")
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

}

