//
//  Extensions.swift
//  Repearl
//
//  Created by Abhinav Kolli on 8/20/22.
//

import Foundation
import FirebaseDatabase

// Returns the Json representation of any object
extension Encodable {
    var toJson: String  {
        guard let data =  try? JSONEncoder().encode(self) else {
            return ""
        }
        let dict =  try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        
        let invalidJson = "Not a valid JSON"
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict!, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    var toDictionary: [String : Any]? {
        guard let data =  try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]

        
    }
}

// Returns the corresponding objects from firebaseDatabase snapshot responses
extension DataSnapshot {
    
    func toArray() -> Array<Any>{
        return (self.value as? NSArray)! as! Array<Any>
    }
    
    
    func toObject<T: Codable>( _ objType: T.Type) -> T{

        switch objType {
        case is String.Type:
            return (self.value as? NSString)! as! T
            
//        case is Array<Any>.Type:
//        commented because Array<Any> does not conform to codable
//        and Firebase arrays can only contain primitive values.
//            (Arrays that are not a child of a parent Codable object)
            
        case is Int.Type:
            return (self.value as? NSNumber)?.intValue as! T
            
        case is Float.Type:
            return (self.value as? NSNumber)?.floatValue as! T
            
        case is Double.Type:
            return (self.value as? NSNumber)?.doubleValue as! T
            
        default: // Type is NSDictionary
            
            let value =  (self.value as? NSDictionary)!
            let jsonData = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)

            // Decode
            let jsonDecoder = JSONDecoder();
            
            do {
                let object = try jsonDecoder.decode(T.self, from: jsonData);
                return object;
            } catch {
                let typeWrapper = try! jsonDecoder.decode(TypeWrapper<T>.self, from: jsonData);
                return typeWrapper.object;
            }
        }

    }
}

extension String {
    static func getRandomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
