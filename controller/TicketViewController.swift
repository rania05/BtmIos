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

    var db = localDB()
    var user = User()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
            }
    
    
    @IBAction func train(_ sender: Any) {
        user = db.read()[0]

        getDataTrain()
        

        tableView.reloadData()
    }
    @IBAction func metro(_ sender: Any) {
        user = db.read()[0]
        getDataMetro()
        

        tableView.reloadData()
    }
    @IBAction func bus(_ sender: Any) {
        user = db.read()[0]
        getDataBus()
        

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
        let date = container!.viewWithTag(5) as! UILabel
        
        let prix = container!.viewWithTag(3) as! UILabel
        
        let img = item["gouv"] as? String
        let  prixx = item["prix"] as? Double
        print(prixx)
        
        
        image.image = UIImage(named: img!)
        statD.text = item["stationDepart"] as? String
        statA.text = item ["stationArrive"] as? String
        date.text = item["date"] as? String
       
        prix.text = String(prixx!)
        
        
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? NSIndexPath
        
        
    let ticket = self.Ticket[index!.row]
  
        let id = ticket["id"] as! Int
        let date = ticket["date"] as! String
        let image = ticket["gouv"] as! String
        let iduser = ticket["iduser"] as! Int
        let moyenTransport = ticket["moyenTransport"] as! String
        let stationDepart = ticket["stationDepart"] as! String
        let stationArrive = ticket["ligne"] as! String
        let prix = ticket["prix"] as! Double
      
        
        
            print(ticket)
        
        
        
        
    }
    func getDataBus(){
        print("hereeeeee",user.id)
        self.data = []
        let  id = UserDefaults.standard.string(forKey: "id")

        AF.request("http://192.168.43.142:3000/api/tickets/b/u/\(id!)" , method: .get ).responseJSON { response in

            if let responseValue = response.value as! [String : Any]? {
                
                if let responseTickets = responseValue["data"] as! [[String : Any]]? {
                    print(response)
                    self.Ticket = responseTickets
                    self.tableView.reloadData()
                }
                
            }
            
       
            
        }
        
    }
    func getDataMetro(){
        self.data = []
        let  id = UserDefaults.standard.string(forKey: "id")

        AF.request("http://192.168.43.142:3000/api/tickets/m/u/\(id!)" , method: .get ).responseJSON { response in

            if let responseValue = response.value as! [String : Any]? {
                
                if let responseTickets = responseValue["data"] as! [[String : Any]]? {
                    print(response)
                    self.Ticket = responseTickets
                    self.tableView.reloadData()
                }
                
            }
            
       
            
        }
        
    }
    func getDataTrain() {
        user = db.read()[0]
     let  id = UserDefaults.standard.string(forKey: "id")
              print("aaaaaaaaaaaaaaa",id)
        self.data = []
        
        AF.request("http://192.168.43.142:3000/api/tickets/t/u/\(id!)" , method: .get ).responseJSON { response in

            let json = try! JSON(data:response.data! , options: .allowFragments)
            for i in json {
                print(i)
//                self.abonnements.append(Abonnement(json: i))
            }
            if let responseValue = response.value as! [String : Any]? {
                
                if let responseTickets = responseValue["data"] as! [[String : Any]]? {
                    
                    self.Ticket = responseTickets
                    print("this is tickeeet",self.Ticket)
                    self.tableView.reloadData()
                }
                
            }
       
            
        }
        
    }
  
}

