//
//  Constant.swift
//  CodingAssignment
//
//  Created by mayank on 30/01/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation

let APP_NAME        =   "Bank Of Badoda"
let userDef         =   UserDefaults.standard
let BASE_URL        =   "https://wmsuat.bankofbaroda.co.in/Rest/"


// StoryBoards
let MAIN_STORYBOARD     = "Main"
let SIP_STORYBOARD      = "SIP"

// Error Codes
enum API_STATUS_CODE:Int{
    case STATUS_CODE_FOR_SUCCESS        = 200
    case STATUS_CODE_FOR_ERROR          = 400
    case STATUS_CODE_FOR_ERROR2         = 401
    case STATUS_CODE_FOR_SERVER_ERROR   = 404
}

//ServiceURLS
enum SERVICEURL:String{
    case USER_API                  =   "users"
}
struct GlobleValue {
    static var IdentifierValue = ""
    static var UnquieIdentifierValue = ""
     static var ClientName = ""
     static var ClientEmail = ""
     static var ClientNO = ""
     static var ClientManagerName = ""
    static var setupRequestDataArray = [[String : Any]]()
    static var InvestertAccDataArray = [[String : Any]]()
    static var HoldingDataArray = [[String : Any]]()
    static var TransactionDataArray = [[String : Any]]()
    static var SIPDueDataArray = [[String : Any]]()
    static var InvestmentMaurityDataArray = [[String : Any]]()
    static var RealizedGainLossDataArray = [[String : Any]]()
    static var CoprateActionDataArray = [[String : Any]]()
    static var InsuranceDataArray = [[String : Any]]()
    static var AssetAllocationDataArray = [[String : Any]]()
    static var OrderStatusDataArray = [[String : Any]]()
    static var potfolioDataDic = [String : Any]()
    static var fundDetailArray = [[String : Any]]()
     static var ClientProfileArray = [[String : Any]]()
    
}
