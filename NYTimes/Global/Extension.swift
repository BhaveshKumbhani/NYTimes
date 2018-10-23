//
//  Extension.swift
//  NYTimes
//
//  Created by Bhavesh Kumbhani on 22/10/18.
//  Copyright © 2018 Bhavesh Kumbhani. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

// MARK: String
extension String{
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: getLanguageBundle(), value: "", comment: "")
    }
    func setLanguageSelection() -> Void {
        udf.set(true, forKey: self)
        udf.synchronize()
    }
    func whiteSpaceTrim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    func isLanguageSelection() -> Bool {
        return udf.bool(forKey: self)
    }
    func getLanguageKey() -> String {
        return udf.value(forKey: UDFSave.selectedLanguage.rawValue) as! String
    }
    func getLanguageBundle() -> Bundle {
        let path = Bundle.main.path(forResource: getLanguageKey(), ofType: "lproj")
        return Bundle(path: path!)!
    }
}

// MARK: URLSessionConfiguration
extension URLSessionConfiguration{
    func requestTimeConfiguration(){
        self.timeoutIntervalForRequest = 3600
        self.timeoutIntervalForResource = 3600
        self.requestCachePolicy = .useProtocolCachePolicy
        self.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
    }
}

// MARK: DATA
extension Data{
    func json() -> AnyObject? {
        do {
            let dicParam = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as AnyObject
            return dicParam
        } catch let myJSONError {
            Swift.debugPrint(myJSONError)
        }
        return nil
    }
}

// MARK: UIViewController
extension UIViewController : NVActivityIndicatorViewable{
    
}

extension UIImageView{
    func circle() -> Void {
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.clipsToBounds = true
    }
}

// MARK: NSArray
extension NSArray{
    
    func getFeed() -> [Feed] {
        var list = [Feed]()
        for dic in self {
            if let d = dic as? NSDictionary{
                let objModel =  Feed(dictionary: d)
                list.append(objModel)
            }
        }
        return list
    }
}

// MARK: CGFloat
extension CGFloat{
    func isIpad() -> CGFloat {
        return  UI_USER_INTERFACE_IDIOM() == .pad ? self * 2 : self
    }
}
