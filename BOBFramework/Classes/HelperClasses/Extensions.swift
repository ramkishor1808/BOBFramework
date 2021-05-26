//
//  Extensions.swift
//  CodingAssignment
//
//  Created by mayank on 30/01/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome
import CryptoSwift
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension String {
  func aesEncrypt() throws -> String {
    let KEY = "6568709081876983"
    let IV = "6568709081876983"
       let encrypted = try AES(key: KEY, iv: IV, padding: .pkcs7).encrypt([UInt8](self.data(using: .utf8)!))
       return Data(encrypted).base64EncodedString()
   }

   func aesDecrypt() throws -> String {
     let KEY = "6568709081876983"
    let IV = "6568709081876983"
       guard let data = Data(base64Encoded: self) else { return "" }
       let decrypted = try AES(key: KEY, iv: IV, padding: .pkcs7).decrypt([UInt8](data))
       return String(bytes: decrypted, encoding: .utf8) ?? self
   }
    
}


extension Dictionary {
  
        var jsonDic: String {
            let invalidJson = "Not a valid JSON"
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
                return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
            } catch {
                return invalidJson
            }
        }

        func printJson() {
            print(jsonDic)
        }

    
    func convertToJson() -> String{

           var Json : String!
           let dictionary = self
           if let theJSONData = try? JSONSerialization.data(
               withJSONObject: dictionary,
               options: []) {
               let theJSONText = String(data: theJSONData,encoding: .utf8)
               Json = theJSONText
           }
           return Json

       }
}

extension UIImageView{
    func set_ImageView_Border(borderColor : UIColor, borderWidth : CGFloat, corner : CGFloat){
        self.layer.cornerRadius    =   corner
        self.layer.borderColor     =   borderColor.cgColor
        self.layer.borderWidth     =   borderWidth
    }
    
    func setImage(unitCode : String,imageName : UIImageView){
        imageName.image  = UIImage.fontAwesomeIcon(code: unitCode, style: .brands, textColor: .clear, size: CGSize(width: 30.0, height: 30.0))
    }
}
extension UITableView{
    
    func cellClass<T : UITableViewCell> (_ cell: T.Type, with indexPath: IndexPath, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        guard let scene = self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? T else {
            
            fatalError("Cell with identifier \(cell.identifier), not found in.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
            
        }
        
        return scene
    }
    
    /**
     * Here We are showing the No records Label pass Your Text
     */
    func noRecordsMessage(_ message: String?)
    {
        let messageLabel = UILabel(frame: CGRect(x:40,y:0,width:self.bounds.size.width - 40, height:self.bounds.size.height ))
        messageLabel.text = String.getString(message)
        messageLabel.textColor = UIColor.gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()
          messageLabel.font = UIFont(name: "Avenir Next", size: 15)
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    
    func loadXibForCellResuse(_ identifier: String?) -> Void {
        
        let nib = UINib(nibName: String.getString(identifier), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String.getString(identifier))
    }
    
    
    func loadXibForHeader(_ identifier: String?) -> Void {
        let nib = UINib(nibName: String.getString(identifier), bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: String.getString(identifier))
    }
    
    
    func numberOfRows(_ row: Int?, message: String?) -> Int {
        
        if Int.getInt(row) > 0
        {
            self.removeEmptyMessage()
            return Int.getInt(row)
            
        } else {
            noRecordsMessage(message)
            return 0
        }
        
        
    }
    
    func numberOfSection(_ section: Int?, message: String?) -> Int {
        
        if Int.getInt(section) > 0
        {
            self.removeEmptyMessage()
            return Int.getInt(section)
        } else {
            self.removeEmptyMessage()
            noRecordsMessage(message)
            return 0
        }
    }
    
    
    
    func scrollToLastIndex() -> Void {
        
        if self.contentSize.height > self.frame.size.height {
            let height = self.contentSize.height - self.frame.size.height
            self.contentOffset = CGPoint.init(x: 0, y: height)
        }
    }
    
    
    //Get Last row in Section
    
    func isLastRow(_ indexPath: IndexPath) -> Bool {
        let totalRow = self.numberOfRows(inSection: indexPath.section)
        
        if(indexPath.row == totalRow - 1) {
            return true
        }
        
        return false
    }
    
    func reloadDataInMainThread() -> Void {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    private func indexPathForLastRow() -> IndexPath {
        return IndexPath(row: numberOfRows(inSection: numberOfSections - 1) - 1, section: numberOfSections - 1)
    }
    
    
    // Remove Message Label
    func removeEmptyMessage() {
        self.backgroundView = nil
    }
}
extension UITableViewCell {
    
    static var identifier:String {
        return String(describing:self)
    }
}

//CollectionView Ext

extension UICollectionView {
    
    
    func cellClass<T : UICollectionViewCell> (_ cell: T.Type, with indexPath: IndexPath, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        guard let scene = self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T else {
            
            fatalError("Cell with identifier \(cell.identifier), not found in.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
            
        }
        
        return scene
    }
    
    
    private func noRecordsMessage(_ message: String?)
    {
        let messageLabel = UILabel(frame: CGRect(x:0,y:0,width:self.bounds.size.width, height:self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        
    }
    
    func loadXibForCellResuse(_ identifier: String?) -> Void {
        let nib = UINib(nibName: String.getString(identifier), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: String.getString(identifier))
    }
    
    
    
    
    func numberOfRow(_ row: Int?, message: String?) -> Int {
        
        if Int.getInt(row) > 0
        {
            self.removeEmptyMessage()
            return Int.getInt(row)
            
        } else {
            noRecordsMessage(message)
            return 0
        }
        
        
    }
    
    func reloadDataInMainThread() -> Void {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    
    private func removeEmptyMessage()
    {
        self.backgroundView = nil
    }
}


extension UICollectionViewCell {
  
  static var identifier:String {
    return String(describing:self)
  }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    func set_TextField_Border(textfield : UITextField, borderColor : UIColor, borderWidth : CGFloat, corner : CGFloat){
        textfield.layer.cornerRadius    =   corner
        textfield.layer.borderColor     =   borderColor.cgColor
        textfield.layer.borderWidth     =   borderWidth
    }
}

extension UIImageView{
    func set_ImageView_Border(imageView : UIImageView, borderColor : UIColor, borderWidth : CGFloat, corner : CGFloat){
        imageView.layer.cornerRadius    =   corner
        imageView.layer.borderColor     =   borderColor.cgColor
        imageView.layer.borderWidth     =   borderWidth
    }
}

extension UILabel{
    func set_Label_Border(label : UILabel, corner : CGFloat){
        label.layoutIfNeeded()
        label.layer.cornerRadius    =   corner
        label.clipsToBounds         =   true
    }
    func shadowOpacity(view : UILabel,radius : CGFloat){
        view.layer.shadowColor    = UIColor.black.cgColor
        view.layer.shadowOffset   = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity  = 0.5
        view.layer.shadowRadius   = 2
        view.layer.cornerRadius   = radius
    }
}

extension UIButton {
    func set_Button_Border(button : UIButton, borderColor : UIColor, borderWidth : CGFloat, corner : CGFloat){
        button.layer.cornerRadius    =   corner
        button.layer.borderColor     =   borderColor.cgColor
        button.layer.borderWidth     =   borderWidth
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0 ,height:0.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5.0
        button.layer.masksToBounds = false
    }
    
    func setShadowButton(btnMaster:UIButton)
    {
        btnMaster.layer.shadowColor = UIColor.black.cgColor
        btnMaster.layer.shadowOffset = CGSize(width: 0.0 ,height:0.0)
        btnMaster.layer.shadowOpacity = 0.5
        btnMaster.layer.shadowRadius = 5.0
        btnMaster.layer.masksToBounds = false
    }
    
    func setShadow(button : UIButton){
        button.layer.shadowColor     = UIColor(red: 122.0/255.0, green: 30.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor//black.cgColor
        button.layer.shadowOffset  = CGSize(width: 0.0, height: 5.0)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius  = 0.0
    }
    enum viewSide {
        case Left,Right,Top,Bottom
    }
    
    func addBorder(withColor color: CGColor, Thickness thickness : CGFloat){
        let border = CALayer()
        border.backgroundColor = color
        
        border.frame = CGRect(x: 0, y: self.center.y+(self.frame.height/2 - thickness), width: self.frame.size.width, height: thickness)
        self.layer.addSublayer(border)
    }
    
    
}

extension UIView{
    func set_View_Border(viewName : UIView, borderColor : UIColor, borderWidth : CGFloat, corner : CGFloat){
        viewName.layer.cornerRadius =   corner
        viewName.layer.borderColor  =   borderColor.cgColor
        viewName.layer.borderWidth  =   borderWidth
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundTowCorner(view: UIView) {
        let path = UIBezierPath(roundedRect:view.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds;
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer;
    }
    func shadowOpacity(view : UIView,radius : CGFloat){
        view.layer.shadowColor    = UIColor.black.cgColor
        view.layer.shadowOffset   = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity  = 0.5
        view.layer.shadowRadius   = 2
        view.layer.cornerRadius   = radius
    }
    func setDottedView(fieldName : UIView){
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor =  UIColor.darkGray.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = fieldName.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: fieldName.bounds).cgPath
        fieldName.layer.addSublayer(yourViewBorder)
    }
    func setColouredDottedView(fieldName : UIView,colorName : UIColor){
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.layoutIfNeeded()
        yourViewBorder.strokeColor =  colorName.cgColor//UIColor.darkGray.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = fieldName.frame
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: fieldName.bounds).cgPath
        fieldName.layer.addSublayer(yourViewBorder)
    }
}

extension UITextView{
    func set_TextView_Border(textViewName : UITextView, borderColor : UIColor, borderWidth : CGFloat, corner : CGFloat){
        textViewName.layer.cornerRadius =   corner
        textViewName.layer.borderColor  =   borderColor.cgColor
        textViewName.layer.borderWidth  =   borderWidth
    }
    
    func setLeftPaddingPoints_TextView(_ amount: CGFloat, textview: UITextView){
        textview.textContainerInset = UIEdgeInsets(top: 0, left: amount, bottom: 0, right: 8)
    }
}

extension Double {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
}

extension UISearchBar {
    public func setSerchTextcolor(color: UIColor) {
        let clrChange = subviews.flatMap { $0.subviews }
        guard let sc = (clrChange.filter { $0 is UITextField }).first as? UITextField else { return }
        sc.textColor = color
    }
}

