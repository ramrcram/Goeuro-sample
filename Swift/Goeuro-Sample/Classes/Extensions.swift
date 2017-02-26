//
//  Extensions.swift
//
//  Created by Ramesh on 17/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit

extension UIView{
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
extension UIButton{
    
    private struct AssociatedKeys {
        static var DescriptiveName = "DEC"
    }
    
    var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.DescriptiveName,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
extension UIImageView {
    
    func getDataFromUrl(url:String, completion:@escaping ((_ data: NSData?) -> Void)) {
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { (data, response, error) in
            completion(NSData(data: data!))
            }.resume()
    }
    func downloadImage(url:String){
        getDataFromUrl(url: url) { data in
            DispatchQueue.main.async {
                self.contentMode = UIViewContentMode.scaleAspectFit
                self.image = UIImage(data: data! as Data)
            }
        }
    }
}
extension Double {
    
    /// Formats the receiver as a currency string using the specified three digit currencyCode. Currency codes are based on the ISO 4217 standard.
    func formatAsCurrency(currencyCode: String,locale:String) -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.currencyCode = currencyCode
        currencyFormatter.maximumFractionDigits = floor(self) == self ? 0 : 2
        currencyFormatter.locale = Locale(identifier: locale)
        return currencyFormatter.currencySymbol + currencyFormatter.string(from:NSNumber(value: self))!
    }
}

extension TimeInterval {
    func timeIntervalAsString(_ format : String = "dd days, hh hours, mm minutes, ss seconds, sss ms") -> String {
        var asInt   = NSInteger(self)
        let ago = (asInt < 0)
        if (ago) {
            asInt = -asInt
        }
        let ms = Int(self.truncatingRemainder(dividingBy: 1) * (ago ? -1000 : 1000))
        let s = asInt % 60
        let m = (asInt / 60) % 60
        let h = ((asInt / 3600))%24
        let d = (asInt / 86400)
        
        var value = format
        value = value.replacingOccurrences(of: "hh", with: String(format: "%0.2d", h))
        value = value.replacingOccurrences(of: "mm",  with: String(format: "%0.2d", m))
        value = value.replacingOccurrences(of: "sss", with: String(format: "%0.3d", ms))
        value = value.replacingOccurrences(of: "ss",  with: String(format: "%0.2d", s))
        value = value.replacingOccurrences(of: "dd",  with: String(format: "%d", d))
        if (ago) {
            value += " ago"
        }
        return value
    }
    
}
