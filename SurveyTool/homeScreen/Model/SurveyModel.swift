//
//  SurveyModel.swift
//  SurveyTool
//
//  Created by Gennady Kaminsky on 2/6/25.
//

import Foundation

class SurveyModel: Codable, Identifiable {
    var id: String
    var surveyQuestion: String
    var yesCount: Int
    var noCount: Int
    
    var yesCountPercent: String {
        let allCount = yesCount  + noCount
        
        guard allCount > 0 else { return "0%"}
        
        return "\((yesCount * 100) / allCount)%"
    }
    
    var noCountPercent: String {
        let allCount = yesCount  + noCount
        
        guard allCount > 0 else { return "0%"}
        
        // Since percent calculation involves roundig off
        // it might be a case when "yes" and "no" answers together
        // do not come to 100%. Therefore, the following work around
        let percentNoCount = 100 - (yesCount * 100) / allCount
        return "\(percentNoCount)%"
    }
    
    init(id: String = UUID().uuidString,
         surveyQuestion: String,
         yesCount: Int,
         noCount: Int) {
        self.id = id
        self.surveyQuestion = surveyQuestion
        self.yesCount = yesCount
        self.noCount = noCount
    }
}
