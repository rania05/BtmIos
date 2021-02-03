//
//  AffAbonnementViewController.swift
//  btm
//
//  Created by imen manai on 12/16/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

class AffAbonnementViewController: UITableViewController  {
 
    
    @IBOutlet var tableAb: UITableView!
    var testBool = false
    var abonnements : [Abonnement] = []
    var Ticket  : [[String : Any]] = [[String : Any]]()
    var data: [JSON] = []
    var db = localDB()
    var user = User()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        user = db.read()[0]
       
        
                 
                
           
              
            }
    
    override func tableView(_ tableAb: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Ticket.count
        
    }
    
    
    override func tableView(_ tableAb: UITableView, didSelectRowAt indexPath: IndexPath) {
    

    }
    override func tableView(_ tableAb: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableAb.dequeueReusableCell(
            withIdentifier : "test1" , for: indexPath)
        
  
        let item = self.Ticket[indexPath.row]
  
        let container = cell.viewWithTag(0)
        
      

        let ville = container!.viewWithTag(1) as! UILabel
        
        let ligne = container!.viewWithTag(2) as! UILabel
        let depart = container!.viewWithTag(3) as! UILabel
        let arrive = container!.viewWithTag(4) as! UILabel
        let dateD = container!.viewWithTag(5) as! UILabel
        let duree = container!.viewWithTag(6) as! UILabel
        let prix = container!.viewWithTag(7) as! UILabel
        
       
        let  prixx = item["prix"] as? Double
        print(prixx)
        
        
       
        ville.text = item["gouv"] as? String
        ligne.text = item ["ligne"] as? String
        depart.text = item["depart"] as? String
        arrive.text = item ["arrive"] as? String
        dateD.text = item["dateD"] as? String
        duree.text = item ["duree"] as? String
         prix.text = String(prixx!)
        
       
    
        return cell
    }
    
    func getData(){
        self.data = []
        //IP SELIM http://192.168.1.17:3000/api/tickets
        let  id = UserDefaults.standard.string(forKey: "id")

        AF.request("http://192.168.43.142:3000/api/abonnements/b/\(id!)" , method: .get ).responseJSON { response in

            
            let json = try! JSON(data:response.data! , options: .allowFragments)
            for i in json {
                print(i)
//                self.abonnements.append(Abonnement(json: i))
            }
            if let responseValue = response.value as! [String : Any]? {
                
                if let responseTickets = responseValue["data"] as! [[String : Any]]? {
                    
                    self.Ticket = responseTickets
                    print("this is tickeeet",self.Ticket)
                    self.tableAb.reloadData()
                }
                
            }
            
       
            
        }
        
    }
    
    
    @IBAction func filterBus(_ sender: Any) {
        getData()
        testBool = true
    
        tableAb.reloadData()
    }
    
    @IBAction func filterTrain(_ sender: Any) {
        getData1()
        testBool = true
    
        tableAb.reloadData()
    }
    
    @IBAction func filterMetro(_ sender: Any) {
        getData2()
        testBool = true
    
        tableAb.reloadData()
    }
    
    func getData1(){
        self.data = []
        //IP SELIM http://192.168.1.17:3000/api/tickets
        let  id = UserDefaults.standard.string(forKey: "id")

        AF.request("http://192.168.43.142:3000/api/abonnements/t/\(id!)" , method: .get ).responseJSON { response in

            
            let json = try! JSON(data:response.data! , options: .allowFragments)
            for i in json {
                print(i)
//                self.abonnements.append(Abonnement(json: i))
            }
            if let responseValue = response.value as! [String : Any]? {
                
                if let responseTickets = responseValue["data"] as! [[String : Any]]? {
                    
                    self.Ticket = responseTickets
                    print("this is tickeeet",self.Ticket)
                    self.tableAb.reloadData()
                }
                
            }
            
       
            
        }
        
    }
    
    func getData2(){
        self.data = []
        //IP SELIM http://192.168.1.17:3000/api/tickets
        let  id = UserDefaults.standard.string(forKey: "id")

        AF.request("http://192.168.43.142:3000/api/abonnements/m/\(id!)" , method: .get ).responseJSON { response in

            
            let json = try! JSON(data:response.data! , options: .allowFragments)
            for i in json {
                print(i)
//                self.abonnements.append(Abonnement(json: i))
            }
            if let responseValue = response.value as! [String : Any]? {
                
                if let responseTickets = responseValue["data"] as! [[String : Any]]? {
                    
                    self.Ticket = responseTickets
                    print("this is tickeeet",self.Ticket)
                    self.tableAb.reloadData()
                }
                
            }
            
       
            
        }
        
    }
}

