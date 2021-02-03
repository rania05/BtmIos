//
//  TicketViewController.swift
//  btm
//
//  Created by imen manai on 12/9/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON


class TicketViewController: UITableViewController  {

    
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
        
        let image = container!.viewWithTag(4) as! UIImageView

        let statD = container!.viewWithTag(1) as! UILabel
        
        let statA = container!.viewWithTag(2) as! UILabel
        let prix = container!.viewWithTag(3) as! UILabel
        
        let img = item["image"] as? String
        let  prixx = item["prix"] as? Double
        print(prixx)
        
        
        image.image = UIImage(named: img!)
        statD.text = item["stationDepart"] as? String
        statA.text = item ["stationArrive"] as? String
        prix.text = String(prixx!)
        
        
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? NSIndexPath
        
        
    let ticket = self.Ticket[index!.row]
  
        let id = ticket["id"] as! Int
        let date = ticket["date"] as! String
        let image = ticket["image"] as! String
        let iduser = ticket["iduser"] as! Int
        let moyenTransport = ticket["moyenTransport"] as! String
        let stationDepart = ticket["stationDepart"] as! String
        let stationArrive = ticket["stationArrive"] as! String
        let prix = ticket["prix"] as! Double
      
        
        
            print(ticket)
        
        
        
        
    }
    func getData(){
        self.data = []
        //IP SELIM http://192.168.1.17:3000/api/tickets
        AF.request("http://192.168.1.10:3000/api/tickets" , method: .get ).responseJSON { response in

            if let responseValue = response.value as! [String : Any]? {
                
                if let responseTickets = responseValue["data"] as! [[String : Any]]? {
                    
                    self.Ticket = responseTickets
                    self.tableView.reloadData()
                }
                
            }
            
       
            
        }
        
    }
  
}
