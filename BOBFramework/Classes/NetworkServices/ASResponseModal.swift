//
//  ASResponseModal.swift
//  FearFighter
//
//  Created by Praveen kumar & Zaman Meraj on 2/24/16.
//  Copyright © 2016 Praveen kumar & Zaman Meraj. All rights reserved.
//

import Foundation

struct ASNetObject {
    let statusCode:Int?
    let responseDict:AnyObject?
    let error:NSError?
    let serverMessage : String?
    
    
    init(response:AnyObject?, err:NSError? , status:Int?, message:String?){
        
        self.statusCode = status;
        self.error = err;
        self.responseDict = response;
        self.serverMessage = message;
    }
}

//struct responseDict : Codable{
//    
//    let session_token : String?
//    let profile : Profile?
//    
//    
//}
