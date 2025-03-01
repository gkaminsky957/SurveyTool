//
//  HomeScreenViewModel.swift
//  SurveyTool
//
//  Created by Gennady Kaminsky on 2/6/25.
//

import SwiftUI

class HomeScreenViewModel: ObservableObject {
    @Published var surveys: [SurveyModel] = []
    @Published var shouldShowEmptyView: Bool = true
    
    private let surveyStorageService: HomeServiceProtocol?
    
    init(surveyStorageService: HomeServiceProtocol? = SurveyStorageService()) {
        self.surveyStorageService = surveyStorageService
    }
    
    func fetchSurveys() {
        surveys = surveyStorageService?.getSurveys() ?? []
        shouldShowEmptyView = surveys.isEmpty
    }
    
    func updateSurveyYesCount(survey: SurveyModel) {
        if let index = surveys.firstIndex(where: { $0.id == survey.id } ) {
            surveys[index].yesCount += 1
            surveyStorageService?.saveSurveys(surveys: surveys)
        }
    }
    
    func updateSurveyNoCount(survey: SurveyModel) {
        if let index = surveys.firstIndex(where: { $0.id == survey.id } ) {
            surveys[index].noCount += 1
            surveyStorageService?.saveSurveys(surveys: surveys)
        }
    }
    
    func addSurveyYesCount(survey: SurveyModel) {
        survey.yesCount += 1
        surveys.append(survey)
        surveyStorageService?.saveSurveys(surveys: surveys)
    }
    
    func addSurveyNoCount(survey: SurveyModel) {
        survey.noCount += 1
        surveys.append(survey)
        surveyStorageService?.saveSurveys(surveys: surveys)
    }
    
    func generateNewSurvey() -> SurveyModel {
        // The generated guestion will be taken from the list below based on
        // randomly generated index.
        let surveyQuestions: [String] = [
            "Sharks are categorizedas mammals",
            "The blue whake is the biggest known animal to have ever existed",
            "Sea otters use favorite rock to break their food open",
            "The hummingbird egg is the world's largest bird egg",
            "Bats are blind and use ultrasound to determine their way while flying",
            "It takes two weeks for a sloth to digest a single meal",
            "The Goliath frog of West Africa is the largest living frog.",
            "Canines sweat through glands in their paws."
        ]
        let index = Int.random(in: 0..<surveyQuestions.count)
        return SurveyModel(surveyQuestion: surveyQuestions[index],
                           yesCount: 0,
                           noCount: 0)
    }
}
