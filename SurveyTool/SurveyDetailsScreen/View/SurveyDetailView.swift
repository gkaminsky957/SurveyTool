//
//  SurveyDetailView.swift
//  SurveyTool
//
//  Created by Gennady Kaminsky on 2/7/25.
//

import SwiftUI

struct SurveyDetailView: View {
    private var survey: SurveyModel
    private var leftButtonPress: (( _ survey: SurveyModel) -> ())?
    private var rightButtonPress: (( _ survey: SurveyModel) -> ())?
    @Environment(\.presentationMode) var presentationMode
    
    init(survey: SurveyModel,
         leftButtonPress: @escaping (_ survey: SurveyModel) -> () = { _ in },
         rightButtonPress: @escaping (_ survey: SurveyModel) -> () = { _ in }) {
        self.survey = survey
        self.leftButtonPress = leftButtonPress
        self.rightButtonPress = rightButtonPress
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Survey Question:")
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                Text(survey.surveyQuestion)
                    .font(Font.system(.headline))
                    .italic()
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Please press buttons below to select correct answer!")
                
                    HStack {
                        Button(action: {
                            leftButtonPress?(survey)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Yes")
                                .padding(.vertical, 10)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                        }
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding(.vertical, 10)
                        
                        Button(action: {
                            rightButtonPress?(survey)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("No")
                                .padding(.vertical, 10)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                        }
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding(.vertical, 10)
                    }
            }
            .padding(.horizontal, 10)
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    SurveyDetailView(survey: SurveyModel(
        surveyQuestion: "This is test survey question that needs to be answered by pressing yes or no ",
        yesCount: 10,
        noCount: 5))
}
