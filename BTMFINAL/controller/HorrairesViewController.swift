//
//  HorrairesViewController.swift
//  btm
//
//  Created by ESPRIT on 11/18/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import Alamofire
import Foundation
import UIKit
import SwiftyJSON
class HorrairesViewController: UITableViewController {
   
    
    @IBOutlet var tabkeView: UITableView!
    
 
    
    var testBool = false
    var Ticket  : [[String : Any]] = [[String : Any]]()
    var data: [JSON] = []

    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !testBool {
        getData()
        tabkeView.reloadData()
        }
        testBool = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        testBool = true
    
        tabkeView.reloadData()
                
                
           
              
            }
  
    
    override func tableView(_ tabkeView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Ticket.count
        
    }
    
  
  
    override func tableView(_ tabkeView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabkeView.dequeueReusableCell(
            withIdentifier : "test" , for: indexPath)
        
  
        let item = self.Ticket[indexPath.row]
  
        let container = cell.viewWithTag(0)
        
         let numero = container!.viewWithTag(1) as! UILabel
        
        let ligne = container!.viewWithTag(2) as! UILabel
        
        let nom = container!.viewWithTag(3) as! UILabel
          let heure = container!.viewWithTag(4) as! UILabel
        let ville = container!.viewWithTag(5) as! UILabel
        let type = container!.viewWithTag(6) as! UILabel
        
      
          let numeroo = item["numero"] as? Int
        ligne.text = item["ligne"] as? String
        nom.text = item ["nom"] as? String
      
         heure.text = item ["heure"] as? String
         numero.text = String(numeroo!)
        ville.text = item ["ville"] as? String
        type.text = item ["type"] as? String
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? NSIndexPath
        
        
    let ticket = self.Ticket[index!.row] as! Dictionary<String,Any>
        
  
       
        let type = ticket["type"] as! String
        let ville = ticket["ville"] as! String
        let station = ticket["nom"] as! String
        let ligne = ticket["ligne"] as! String
        
      
        if segue.identifier == "msegue"{
            
            
            if let destination =  segue.destination as? AddTicketViewController{
  
                destination.moyen = type
                destination.gouver = ville
                destination.lignee = ligne
                destination.Sdepart = station
            print(ticket)
        
        
        
            }
    }
    }
    
    
    override func tableView(_ tabkeView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        performSegue(withIdentifier: "msegue", sender: indexPath)

    }
    
    func getData(){
        self.data = []
        //IP SELIM http://192.168.1.17:3000/api/tickets
        //IP esprit bloc a http://172.16.158.52:3000/api/tickets
        AF.request("http://192.168.1.10:3000/api/moyenTransport/t/metro" , method: .get ).responseJSON { response in

            if let responseValue = response.value as! [String : Any]? {
                
                if let responseTickets = responseValue["data"] as! [[String : Any]]? {
                    
                    self.Ticket = responseTickets
                    self.tabkeView.reloadData()
                }
                
            }
            
       
            
        }
        
    }
        
    }
  
    
  
      
   
    

    
    
   
           
      
      
      
      
    
   

