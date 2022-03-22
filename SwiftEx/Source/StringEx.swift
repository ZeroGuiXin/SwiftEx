//
//  StringEx.swift
//  SwiftExtension
//
//  Created by xuzexin on 2022/3/21.
//

import Foundation

extension String{
    
    // URL编码
    var encodeUrl: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    // URL解码
    var decodeUrl: String?
    {
        return self.removingPercentEncoding
    }
    

    var doubleValue: Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    var intValue: Int?  {
        return NumberFormatter().number(from: self)?.intValue
    }
    
    var floatValue: Float? {
        return NumberFormatter().number(from: self)?.floatValue
    }
    
    var firstToInt: Int? {
        let firstString = self.split(separator: ".").compactMap { "\($0)" }.first ?? ""
        return firstString.intValue
    }
    var lastToInt: Int? {
        let firstString = self.split(separator: ".").compactMap { "\($0)" }.last ?? ""
        return firstString.intValue
    }
    
    var dic: [String: Any]? {
        let data = data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }
    
    func remove(subString: String) -> String{
        var string = self
        let startIndex = string.startIndex
        let  endIndex = string.index(startIndex, offsetBy: subString.count)
        let  range = startIndex...endIndex
        string.removeSubrange(range)
        return string
    }
    
    // 截取取字符串（头到填入值之间的字符串）
    func zx_substring(to : Int) -> (String){
        let index = self.index(self.startIndex, offsetBy: to)
        return self.substring(to: index)
    }
    // 截取取字符串（填入值到结尾之间的字符串）
    func zx_substring(from : Int) -> (String){
        let index = self.index(self.startIndex, offsetBy: from)
        return self.substring(from: index)
    }
    // 截取取字符串（输入值之间的字符串）
    func zx_substring(first : Int, last : Int) -> (String){
        
        let index1 = self.index(self.startIndex, offsetBy: first)
        let index2 = self.index(self.startIndex, offsetBy: last)
        return self.substring(with: index1..<index2)
    }
    
    func jsonToDic() -> [String: Any]{
    
        let data = self.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        let jsonDic = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
        return jsonDic
    }
    
    //转成JSON String
    static func string(object : Any) -> String? {
    
        do {
            let JSONData = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStr  = String.init(data: JSONData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            return jsonStr
            
        } catch let _ {
            return nil
        }
        return nil
    }
}
