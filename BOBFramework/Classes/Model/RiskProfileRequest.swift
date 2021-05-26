//
//  RiskProfileRequest.swift
//  BOB
//
//  Created by Anushree on 5/3/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation
// MARK: - TopicResponse
struct RiskProfileResquest: Encodable {

    let Source: String
    let UniqueIdentifier: String
    let Requestbody: Requestbody
}

struct Requestbody: Encodable {
    let ClientCode: String
    let RiskProfileQuestionnaire: RiskprofileQuestionnaire
}
struct RiskprofileQuestionnaire: Encodable {
    let QuestionSetCode: String
    let RiskProfileQuestionCollection: [RiskprofileQuestionCollection]
}
struct RiskprofileQuestionCollection: Encodable {
    let QuestionCode: String
    let QuestionDescription: String
    let AnswerCollection: [Answercollection]
}
struct Answercollection: Encodable {
    let AnswerCode: String
    let AnswerDescription: String
    let Selected: String
   
}
//let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//
//let decoder = JSONDecoder()
//do {
//    let customer = try decoder.decode(Customer.self, from: data)
//    print(customer)
//} catch {
//    print(error.localizedDescription)
//}
