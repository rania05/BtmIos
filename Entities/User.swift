//
//  User.swift
//  BTMFINAL
//
//  Created by imen manai on 12/27/20.
//

import Foundation
import SwiftyJSON
import ObjectMapper
class User : Mappable{
    
    
    var id : Int?
    var nom : String?
    var prenom : String?
    var daten : String?
    var username : String?
    var num : String?
    var mail : String?
    var password : String?
    var adresse : String?
    var role : String?
    var enabled : Int?

    init(){
        
    }
    
    init (id : Int,email : String,password : String ) {
        self.id = id
        self.mail = email
        self.password = password
    }
    init (id : Int , email : String ,  username : String ,  nom : String , prenom : String) {
        self.id = id
        self.mail = email
        self.username = username
        self.nom = nom
        self.prenom = prenom
    }
    init (id : Int , username : String , email : String , numero : String , adresse : String) {
        self.id = id
        self.username = username
        self.mail = email
        self.num = numero
        self.adresse = adresse
    }
    
        
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    init ( map : JSON) {
//        nom <- map["nom"]
//        prenom <- map["prenom"]
//        daten <- map["daten"]
//        username <- map["username"]
//        num <- map["num"]
//        mail <- map["mail"]
//        password <- map["password"]
//        adresse <- map["adresse"]
//        role <- map["role"]
//        enabled <- map["enabled"]
    }
    
//    func fromJson ( map : [String : Any]){
//        id <- map["id"]
//        nom <- map["nom"]
//        prenom <- map["prenom"]
//        daten <- map["daten"]
//        username <- map["username"]
//        num <- map["num"]
//        mail <- map["mail"]
//        password <- map["password"]
//        adresse <- map["adresse"]
//        role <- map["role"]
//        enabled <- map["enabled"]
//    }
    
    
}
