//
//  Station.swift
//  BTMFINAL
//
//  Created by macbook on 12/28/20.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class Station : Mappable {
    
    var nom : String?
    var longitude : String?
    var latitude : String?
    var idTransport : Int?
    var id : Int?
    var gouv : String?
    var ligne : String?
    
    init() {
        
    }
    
    init(json : JSON) {
        self.nom = json["nom"].stringValue
        self.longitude = json["longitude"].stringValue
        self.latitude = json["latitude"].stringValue
        self.gouv = json["ville"].stringValue
        self.ligne = json["ligne"].stringValue
        self.id = json["id"].intValue
        self.idTransport = json["idTransport"].intValue
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    
}
