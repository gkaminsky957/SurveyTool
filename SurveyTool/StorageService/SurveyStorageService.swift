//
//  SurveyStorageService.swift
//  SurveyTool
//
//  Created by Gennady Kaminsky on 2/6/25.
//

import Foundation

protocol HomeServiceProtocol {
    func getSurveys() -> [SurveyModel]
    func saveSurveys(surveys: [SurveyModel])
}

protocol UserDefaultsProtocol {
    func data(forKey defaultName: String) -> Data?
    func set(_ value: Any?, forKey defaultName: String)
    func synchronize() -> Bool
}

extension UserDefaults: UserDefaultsProtocol { }

class SurveyStorageService: HomeServiceProtocol {
    private let userDefaults: UserDefaultsProtocol
    private let userDefaultsKey = "keySurveys"
    
    init?(userDefaults: UserDefaults? = UserDefaults(suiteName: "Surveys")) {
        guard let userDefaults = userDefaults else { return nil }
        self.userDefaults = userDefaults
    }
    
    func getSurveys() -> [SurveyModel] {
        guard let retrievedData = userDefaults.data(forKey: userDefaultsKey) else { return [] }
        guard let surveys = try? PropertyListDecoder().decode([SurveyModel].self, from: retrievedData) else { return [] }

        return surveys
    }
    
    func saveSurveys(surveys: [SurveyModel]) {
        let dataToBeSaved = try? PropertyListEncoder().encode(surveys)
        userDefaults.set(dataToBeSaved, forKey: userDefaultsKey)
        _ = userDefaults.synchronize()
    }
}
