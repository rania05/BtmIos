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

    var testBool = false
    var Ticket  : [[String : Any]] = [[String : Any]]()
    var data: [JSON] = []

    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !testBool {
        getData()
        tableView.reloadData()
        }
        testBool = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        testBool = true

        tableView.reloadData()
                
        
                 
                
           
              
            }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Ticket.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier : "test" , for: indexPath)
        
  
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
        AF.request("http://192.168.1.10:3000/api/abonnements" , method: .get ).responseJSON { response in

            if let responseValue = response.value as! [String : Any]? {
                
                if let responseTickets = responseValue["data"] as! [[String : Any]]? {
                    
                    self.Ticket = responseTickets
                    self.tableView.reloadData()
                }
                
            }
            
       
            
        }
        
    }
  
}
