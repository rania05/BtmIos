//
//  Abonnement.swift
//  BTMFINAL
//
//  Created by macbook on 12/28/20.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class Abonnement : Mappable {
    var id : Int?
    var dateD : String?
    var duree : String?
    var image : String?
    var iduser : String?
    var moyenT : String?
    var ligne : String?
    var prix : Double?
    var depart : String?
    var arrive : String?
    var gouv : String?
    
    init() {
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
    
    init(json : JSON) {
        self.id = json["id"].int
        self.dateD = json["dateD"].stringValue
        self.duree = json["duree"].stringValue
        self.image = json["image"].stringValue
        self.iduser = json["iduser"].stringValue
        self.moyenT = json["moyenT"].stringValue
        self.ligne = json["ligne"].stringValue
        self.depart = json["depart"].stringValue
        self.arrive = json["arrive"].stringValue
        self.gouv = json["gouv"].stringValue
        self.prix = json["prix"].doubleValue
    }
}
