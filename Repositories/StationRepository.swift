//
//  StationRepository.swift
//  BTMFINAL
//
//  Created by macbook on 12/28/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class StationRepository {
    @discardableResult
    func getAllStation(completionHandler : @escaping (_ station : [Station]) -> Void ) -> Alamofire.DataRequest {
        return AF.request("http://192.168.43.142:3000/api/Station/", method: .get, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
            do {
                let json = try! JSON(data:AFdata.data! , options: .allowFragments)
                let data = json["data"]
                var stations : [Station] = []
                for i in data {
                    print(i)
                    stations.append(Station(json: i.1))
                }
                completionHandler(stations)
            
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
    }
    @discardableResult
    func getStationByVille(ville : String ,completionHandler : @escaping (_ station : [Station]) -> Void ) -> Alamofire.DataRequest {
        print(ville);
        return AF.request("http://192.168.43.142:3000/api/Station/ville/\(ville)", method: .get, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
            do {
                let json = try! JSON(data:AFdata.data! , options: .allowFragments)
                let data = json["data"]
                var stations : [Station] = []
                for i in data {
                    print(i)
                    stations.append(Station(json: i.1))
                }
                completionHandler(stations)
            
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
    }
    @discardableResult
    func getStationByLigne(lig : String ,completionHandler : @escaping (_ station : [Station]) -> Void ) -> Alamofire.DataRequest {
        print(lig);
        return AF.request("http://192.168.43.142:3000/api/Station/ligne/\(lig)", method: .get, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
            do {
                let json = try! JSON(data:AFdata.data! , options: .allowFragments)
                let data = json["data"]
                var stations : [Station] = []
                for i in data {
                    print(i)
                    stations.append(Station(json: i.1))
                }
                completionHandler(stations)
            
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
    }
    @discardableResult
    func getStationByTransport(nom : String ,completionHandler : @escaping (_ station : [Station]) -> Void ) -> Alamofire.DataRequest {
        print(nom);
        return AF.request("http://192.168.43.142:3000/api/Station/transport/\(nom)", method: .get, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
            do {
                let json = try! JSON(data:AFdata.data! , options: .allowFragments)
                let data = json["data"]
                var stations : [Station] = []
                for i in data {
                    print(i)
                    stations.append(Station(json: i.1))
                }
                completionHandler(stations)
            
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
    }
}
