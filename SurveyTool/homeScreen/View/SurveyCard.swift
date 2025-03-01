//
//  SurveyCard.swift
//  SurveyTool
//
//  Created by Gennady Kaminsky on 2/6/25.
//

import SwiftUI

struct SurveyCard: View {
    private var survey: SurveyModel
    
    init(survey: SurveyModel) {
        self.survey = survey
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(survey.surveyQuestion)
                .fontWeight(.bold)
                .font(Font.system(.headline))
                .foregroundColor(Color.gray)
                .padding([.horizontal, .top], 10)
            Divider()
                .frame(height: 4)
                .padding(.horizontal, 10)
            HStack {
                Text("Confirmed (Yes) response:")
                  .italic()
                  .foregroundColor(Color.black)
                Spacer()
                Text(String(survey.yesCountPercent))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 10)
            }
            .padding(.leading, 15)
            HStack {
                Text("Unconfirmed (No) response:")
                    .italic()
                    .foregroundColor(Color.black)
                Spacer()
                Text(survey.noCountPercent)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 10)
            }
            .padding([.leading, .bottom], 15)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.brown,
                radius: CGFloat(4),
                x: CGFloat(0),
                y: CGFloat(4))
        .padding(.horizontal, 10)
    }
}

#Preview {
    SurveyCard(survey: SurveyModel(
        surveyQuestion: "This is test survey question that needs to be answered by pressing yes or no ",
        yesCount: 10,
        noCount: 15))
}
