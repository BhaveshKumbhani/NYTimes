//
//  Global.swift
//  NYTimes
//
//  Created by Bhavesh Kumbhani on 22/10/18.
//  Copyright © 2018 Bhavesh Kumbhani. All rights reserved.
//

import UIKit

let appDel = UIApplication.shared.delegate as! AppDelegate
let nfc = NotificationCenter.default
let udf = UserDefaults.standard
let fm = FileManager.default



public typealias Parameters = [String: Any]

enum UDFSave : String{
    case selectedLanguage = "selectedLanguage"
}
enum Method : String{
    case get = "GET"
    case post = "POST"
}

enum Param : String{
    case message = "message"
    case status = "status"
    case results = "results"
}


// MARK: PARAMS
let key_days = "days"
