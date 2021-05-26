//
//  ApiManager.swift

import Foundation
import UIKit

typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]

class APIManager: NSObject {
    
    
    static  let shareInstance = APIManager()
    typealias NetworkClosure = (_ netResponse : ASNetObject) -> (Void)
    
    func AuthenticationRequest(method : String,TPA : String , parameter : String,callback:@escaping NetworkClosure) {
        let Url = String(format: "\(BASE_URL)\(method)")
         guard let serviceUrl = URL(string: Url) else { return }
         var request = URLRequest(url: serviceUrl)
         request.httpMethod = "POST"
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue("\(TPA)", forHTTPHeaderField: "TPA")
        let data = Data(parameter.utf8)
         request.httpBody = data
         let session = URLSession.shared
         session.dataTask(with: request) { (data, response, error) in

             if let data = data {
                 do {
                     let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                     let responseObj = ASNetObject.init(response: json as AnyObject?, err: error as NSError?, status: (response as? HTTPURLResponse)?.statusCode, message: "")
                    print(responseObj)
                     callback(responseObj);
                    
                 } catch {
                     print(error)
                 }
             }
         }.resume()
    }
    /// GET FROM API
    ///
    /// - Parameters:
    ///   - url: URL API
    ///   - method: methods
    ///   - parameters: parameters
    ///   - encoding: encoding
    ///   - headers: headers
    ///   - completion: completion
    ///   - failure: failure
//    static func request(_ url: String, method: HTTPMethod, parameters: Parameters, isloader: Bool =  true, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (_ response: Data) ->(), failure: @escaping (_ error: String, _ errorCode: Int) -> ()) {
//        
//        let configuration = URLSessionConfiguration.af.default
//        configuration.timeoutIntervalForRequest = 40
//        configuration.timeoutIntervalForResource = 40
//        manager = Session(configuration: configuration)
//        
////        if isloader {
////            SVProgressHUD.show()
////        }
//        
////        let apiURL = url
//        print("-- URL API: \(url), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
//        
//        manager.request(
//            url,
//            method: method,
//            parameters: parameters,
//            encoding: encoding,
//            headers: headers).responseString(
//                queue: DispatchQueue.main,
//                encoding: String.Encoding.utf8) { response in
//                    guard let dataResult = response.data else { return }
//                    let responseString = String(data: dataResult, encoding: .utf8)
//                    print("Api Json Response = \(String(describing: responseString!))")
//                    switch(response.result) {
//                    case .success(_):
////                        SVProgressHUD.dismiss()
//                        guard let callback = response.data else {
//                            failure(self.generateRandomError(), 0)
//                            return
//                        }
//                        completion(callback)
//                        break
//                    case .failure(_):
////                        SVProgressHUD.dismiss()
//                        print(response.result as Any)
//                        guard let callbackError = response.data else {
//                            return
//                        }
//                        print("MAP GLOBAL ERROR FOR: \(callbackError)")
//                        break
//                    }
//                    print("--\n \n CALLBACK RESPONSE: \(response)")
//        }
//    }
//    
    /// GENERATE RANDOM ERROR
    ///
    /// - Returns: string error randoms
    static func generateRandomError() -> String {
        return "Oops. There is an error. Please reload."
    }
    
}
