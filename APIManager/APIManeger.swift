//
//  APIManeger.swift
//  NYTimes
//
//  Created by Bhavesh Kumbhani on 22/10/18.
//  Copyright © 2018 Bhavesh Kumbhani. All rights reserved.
//

import UIKit

let API_KEY =   "cfe5e25d1cdb49b7abce89b1bf03dbc9"

enum VoidResult {
    case success(Any)
    case failure(String)
}
class APIManeger: NSObject {
    static let shared : APIManeger = {
        let instance = APIManeger()
        return instance
    }()
    func isConnected() -> Bool {
      return  appDel.reachability.connection == .none ? false : true
    }
    func createRequest(strURL: String, params: Parameters, method: String)->URLRequest{

        var request = URLRequest(url: URL.init(string: strURL)!)
        if params.count > 0 && method == Method.post.rawValue{
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                Swift.debugPrint("error in request JSONSerialization", error.localizedDescription)
            }
        }
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        return request
    }
}

extension APIManeger{
    
    func getList(param: Parameters, completion: @escaping (_ result: VoidResult) -> ()) -> Void {
        
        if !isConnected() {
            completion(.failure(Localizable.key_alt_msg_offline.localized()))
            return
        }
        let urlString = String.init(format: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/%d.json?api-key=%@", param[key_days] as! CVarArg,API_KEY)
        let request = self.createRequest(strURL: urlString, params: [:], method:  Method.get.rawValue)
        let config = URLSessionConfiguration.default
        config.requestTimeConfiguration()
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if error == nil, let dicMain = data?.json() as? [String: Any] {
                Swift.debugPrint("JSON:",dicMain)
                
                if let status = dicMain[Param.status.rawValue] as? String, status == "OK", let dataList  = dicMain[Param.results.rawValue] as? NSArray{
                    let feedList = dataList.getFeed()
                    print("feedList:",feedList)
                    completion(.success(feedList))
                }else{
                    completion(.failure(""))
                }
            
            }else{
                completion(.failure(""))
            }
        })
        task.resume()
    }
}

