//
//  UserRepository.swift
//  BTMFINAL
//
//  Created by imen manai on 12/27/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserRepository{
    @discardableResult
    func loginUser(email : String,password : String, completionHandler : @escaping (_ user : User) -> Void ) -> Alamofire.DataRequest {
        let parameters: [String: Any] = [
            "mail" : email,
            "password" : password
        ]
        return AF.request("http://192.168.43.142:3000/api/users/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
            do {
//                guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {
//                    print("Error: Cannot convert data to JSON object")
//                    return
//                }
                let json = try! JSON(data:AFdata.data!, options: .allowFragments)
                print(json)
                let response = User()
                response.id = json["id"].intValue
                response.nom = json["nom"].stringValue
                response.prenom = json["prenom"].stringValue
                response.daten = json["daten"].stringValue

                

                response.num = json["num"].stringValue
                response.username = json["username"].stringValue
                response.adresse = json["adresse"].stringValue
                response.mail = json["mail"].stringValue
                
                completionHandler(response)
            
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
    }
}
