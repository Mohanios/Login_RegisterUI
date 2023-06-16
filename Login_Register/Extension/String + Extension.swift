//
//  Extension + String.swift
//  Login_Register
//
//  Created by Mohanraj on 22/02/23.
//

import Foundation
import UIKit

extension String {
    var isPhonenumberValid : Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count && self.count == 10
            } else{
                return false
            }
        } catch {
            return false
        }
    }
    
    var isPasswordValid: Bool {
          let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
          let passwordtest = NSPredicate(format: "SELF MATCHES %@",passwordRegex)
          return passwordtest.evaluate(with: self)
      }
    var isValidEmail: Bool{
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
         let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
         return emailTest.evaluate(with: self)
     }
    
    var isValidUserName: Bool{
        let UserNameRegEx = "^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$"
        let UserNameTest = NSPredicate(format: "SELF MATCHES %@", UserNameRegEx)
        return UserNameTest.evaluate(with: self)
    }
    

}


extension String {
 func processDate(string: String, fromFormat: String, toFormat: String) -> String? {
  let formatter = DateFormatter()
  formatter.dateFormat = fromFormat
  guard let date = formatter.date(from: string) else { return nil }
  formatter.dateFormat = toFormat
  return formatter.string(from: date)
 }
}
