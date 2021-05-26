//
//  ViewControllers+Extension.swift
//  IMSH Driver
//
//  Created by Mayank on 3/24/20.
//  Copyright © 2020 John. All rights reserved.
//

import Foundation
import  UIKit
import CommonCrypto


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
//MARK: - Storyboard -
enum Storyboard : String {
    case Dashboard
    case Registration
}

extension UIViewController {
    
    class var storyboardID : String {
        
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: Storyboard) -> Self {
        
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
}


extension Storyboard {
    
    var instance : UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController> (viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass).storyboardID
        
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}

// MARK:- UIView
// ==============
extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

//         self.layer.backgroundColor = UIColor.green.cgColor
        //Here I'm masking the textView's layer with rectShape layer
         self.layer.mask = rectShape
    }
}

// MARK:- String

extension String {
   
    var localized: String {
        
        return NSLocalizedString(self, comment: self)
        
    }
    
    // To Check Whether Email is valid
    func isEmail() -> Bool
    {
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}" as String
        let emailText = NSPredicate(format: "SELF MATCHES %@",emailRegex)
        let isValid  = emailText.evaluate(with: self) as Bool
        return isValid
    }
    
    // To Check Whether Email is valid
    func isValidString() -> Bool
    {
        if self == "<null>" || self == "(null)"
        {
            return false
        }
        return true
    }
    
    // To Check Whether Phone Number is valid
    func isPhoneNumber() -> Bool
    {
        if self.isStringEmpty()
        {
            return false
        }
        let phoneRegex = "^\\d{10}$"
        let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phoneText.evaluate(with: self) as Bool
        return isValid
    }
    // To Check Whether Phone Number is valid
//      func isValidPassword() -> Bool
//      {
//          if self.isStringEmpty()
//          {
//              return false
//          }
//          let phoneRegex = "^(?=.[A-Za-z])(?=.\\d)(?=.[@$!%#?&])[A-Za-z\\d@$!%*#?&]{6,}$"
//          let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
//          let isValid = phoneText.evaluate(with: self) as Bool
//          return isValid
//      }
    
    
    func trimAll()->String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // To Check Whether URL is valid
    func isURL() -> Bool
    {
        let urlRegex = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+" as String
        let urlText = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        let isValid = urlText.evaluate(with: self) as Bool
        return isValid
    }
    
    // To Check Whether Image URL is valid
    func isImageURL() -> Bool
    {
        if self.isURL()
        {
            if self.range(of: ".png") != nil || self.range(of: ".jpg") != nil || self.range(of: ".jpeg") != nil
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return false
        }
    }
    
    static func getString(_ message: Any?) -> String
    {
        guard let strMessage = message as? String else
        {
            guard let doubleValue = message as? Double else
            {
                guard let intValue = message as? Int else
                {
                    guard let int64Value = message as? Int64 else
                    {
                        return ""
                    }
                    return String(int64Value)
                }
                return String(intValue)
            }
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            formatter.minimumIntegerDigits = 1
            guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else
            {
                return ""
            }
            return formattedNumber
        }
        return strMessage.stringByTrimmingWhiteSpaceAndNewLine()
    }
  
    
    var doubleValue: Double?
    {
        if let number = NumberFormatter().number(from: self)
        {
            return number.doubleValue
        }
        
        return nil
    }
    
    
    
    static func getLength(_ message: Any?) -> Int
    {
        return String.getString(message).stringByTrimmingWhiteSpaceAndNewLine().count
    }
    
    func converIntoCurrencey() -> String {
        
        let formatter = NumberFormatter()
        formatter.currencyCode = Locale.current.currencyCode
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: NSNumber.getNSNumber(message: self)) {
            return formattedTipAmount
        }
        return ""
    }
    
    
    
    
    func toBool() -> Bool
    {
        return (self == "0" || self == "" || self.lowercased() == "false") ?  false : true
    }
    
    
    static func checkForValidNumericString(_ message: AnyObject?) -> Bool
    {
        guard let strMessage = message as? String else
        {
            return true
        }
        
        if strMessage == "" || strMessage == "0"
        {
            return true
        }
        
        return false
    }
    
    
    // To Check Whether String is empty
    func isStringEmpty() -> Bool
    {
        return self.stringByTrimmingWhiteSpace().count == 0 ? true : false
    }
    
    mutating func removeSubString(subString: String) -> String
    {
        if self.contains(subString)
        {
            guard let stringRange = self.range(of: subString) else { return self }
            return self.replacingCharacters(in: stringRange, with: "")
        }
        return self
    }
    
    /*
     // To check whether String contains Only Letters
     func stringContainsOnlyLetters() -> Bool
     {
     let characterSet = NSCharacterSet.letterCharacterSet()
     return self.rangeOfCharacterFromSet(characterSet) != nil ? true : false
     }
     
     // To check whether String contains Only Numbers
     func stringContainsOnlyNumbers() -> Bool
     {
     let characterSet = NSCharacterSet.decimalDigitCharacterSet()
     return self.rangeOfCharacterFromSet(characterSet) != nil ? true : false
     }
     */
    
    // Get string by removing White Space & New Line
    func stringByTrimmingWhiteSpaceAndNewLine() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    // Get string by removing White Space
    func stringByTrimmingWhiteSpace() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func getSubStringFrom(begin: NSInteger, to end: NSInteger) -> String
    {
        //var strRange = begin..<end
        //let str = self.substringWithRange(strRange)
        return ""
    }
    
    func toInt() -> Int
    {
        return Int(self) ?? 0
    }
    
    
    init(any anyValue:Any?)
    {
        self = ""
        
        if let str = anyValue as? String
        {
            self = String(format: "%@", str).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        else if let num = anyValue as? NSNumber
        {
            self = String(format: "%@", num).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    
    func contains(ignoreCase arrString: [String]?) -> Bool {
        
        guard let arrString = arrString else {
            
            return false
        }
        
        return arrString.filter { self.lowercased().contains(ignoreCase: $0.lowercased()) }.count > 0
    }
    
    //case insensitive contains
    func contains(ignoreCase aString: String?) -> Bool {
        
        guard let aString = aString else {
            
            return false
        }
        
        return (self.lowercased().range(of: aString.lowercased()) != nil) ? true : false
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    
//    func sha512() -> String {
//           let data = Data(self.utf8)
//           var digest = [UInt8](repeating: 0, count:Int(CC_SHA512_DIGEST_LENGTH))
//           data.withUnsafeBytes {
//               _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
//           }
//           let hexBytes = digest.map { String(format: "%02hhx", $0) }
//           return hexBytes.joined()
//       }
    
   

        public var sha512: String {
            let data = self.data(using: .utf8) ?? Data()
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
            data.withUnsafeBytes {
                _ = CC_SHA512($0.baseAddress, CC_LONG(data.count), &digest)
            }
            return digest.map({ String(format: "%02hhx", $0) }).joined(separator: "")
        }
    
}

extension NSNumber
{
    static func getNSNumber(message: Any?) -> NSNumber
    {
        guard let number = message as? NSNumber else
        {
            guard let strNumber = message as? String else
            {
                return 0
            }
            guard let intNumber = Int(strNumber) else
            {
                guard let doubleNumber = Double(strNumber) else
                {
                    return 0
                }
                return NSNumber(value: Double(doubleNumber))
            }
            return NSNumber(value: Int(intNumber))
        }
        return number
    }
}


extension Int
{
    static func getInt(_ value: Any?) -> Int
    {
        guard let intValue = value as? Int else
        {
            let strInt = String.getString(value)
            guard let intValueOfString = Int(strInt) else { return 0 }
            
            return intValueOfString
        }
        return intValue
    }
    
    func toCGFloat() -> CGFloat
    {
        return CGFloat(self)
    }
    
    func toBool() -> Bool
    {
        return self == 0 ? false : true
    }
    
    func toString(changeToDoubleDigit:Bool = false) -> String {
        
        let number = NSNumber(integerLiteral: self)
        let str = String(format:"%@",number).trimAll()
        
        return ((self < 10 && self > 0 && changeToDoubleDigit) ? "0\(str)" : str)
    }
}

//MARK- Double
extension Double
{
    static func getDouble(_ value: Any?) -> Double
    {
        guard let doubleValue = value as? Double else
        {
            let strDouble = String(any:value)
            guard let doubleValueOfString = Double(strDouble) else { return 0.0 }
            
            return doubleValueOfString
        }
        
        return doubleValue
    }
}

//MARK- Bool
extension Bool
{
    static func getBool(_ value: Any?) -> Bool
    {
        guard let boolValue = value as? Bool else
        {
            let strBool = String.getString(value)
            guard let boolValueOfString = Bool(strBool) else { return false }
            
            return boolValueOfString
        }
        return boolValue
    }
}

extension String {
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{5,22}$"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }
}

