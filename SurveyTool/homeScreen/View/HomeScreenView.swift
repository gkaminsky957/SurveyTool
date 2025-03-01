//
//  HomeScreenView.swift
//  SurveyTool
//
//  Created by Gennady Kaminsky on 2/6/25.
//

import SwiftUI

struct HomeScreenView: View {
    @ObservedObject private var viewModel: HomeScreenViewModel
    @State private var showCreateSurveyView: Bool = false
    @State private var shouldGoToSurveyDetails: Bool = false
    @State private var selectedSurveyCard: SurveyModel?
    
    init(viewModel: HomeScreenViewModel = HomeScreenViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.shouldShowEmptyView {
                    Spacer()
                    Text("Your currently have no surveys. To create a new survey please click button below!")
                        .fontWeight(.bold)
                        .font(Font.system(.title))
                        .multilineTextAlignment(.center)
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing:  25) {
                            ForEach(viewModel.surveys, id: \.id) { survey in
                                SurveyCard(survey: survey)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectedSurveyCard = survey
                                        shouldGoToSurveyDetails = true
                                    }
                            }
                        }
                    }
                }
                Spacer()
                
                Button(action: {
                    showCreateSurveyView.toggle()
                }) {
                    Text("Create New Survey")
                        .padding(.vertical, 10)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.vertical, 10)
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .navigationDestination(isPresented: $shouldGoToSurveyDetails) {
                if let selectedSurveyCard = selectedSurveyCard {
                    SurveyDetailView(survey: selectedSurveyCard,
                                     leftButtonPress: { survey in
                        viewModel.updateSurveyYesCount(survey: survey)
                    },
                                     rightButtonPress: { survey in
                        viewModel.updateSurveyNoCount(survey: survey)
                        
                    })
                    .navigationTitle("Answer the question")
                } else {
                    EmptyView()
                }
            }
            .navigationDestination(isPresented: $showCreateSurveyView) {
                SurveyDetailView(survey: viewModel.generateNewSurvey(),
                                 leftButtonPress: { survey in
                    viewModel.addSurveyYesCount(survey: survey)
                },
                                 rightButtonPress: { survey in
                    viewModel.addSurveyNoCount(survey: survey)
                })
                .navigationTitle("Create a Survey")
            }
            .onAppear {
                viewModel.fetchSurveys()
            }
        }
    }
}

#Preview {
    HomeScreenView()
}
