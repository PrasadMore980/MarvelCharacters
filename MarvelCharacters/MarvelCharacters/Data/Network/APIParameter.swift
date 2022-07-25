import Foundation
import CryptoKit

struct APIParameters {
    static var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "APIParameter", ofType: "plist") else { return "" }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else { return "" }
        return value
      }
    }
    
    static var privateKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "APIParameter", ofType: "plist") else { return "" }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "PRIVATE_KEY") as? String else { return "" }
        return value
      }
    }
    
    static var timestamp : String {
        return "\(Date.timeIntervalBetween1970AndReferenceDate)"
    }
    
    static var hashed: String {
        let hashed = generateMD5()
        return hashed
    }
    
    static func generateMD5() -> String {
        let stringToHash = timestamp + APIParameters.privateKey + APIParameters.apiKey
        let hashed = Insecure.MD5.hash(data: stringToHash.data(using: .utf8)!)
            .map {String(format: "%02x", $0)}
            .joined()
        return hashed
    }
}
