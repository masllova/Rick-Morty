//
//  MainView.swift
//  Rick&Morty
//
//  Created by Александра Маслова on 17.08.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                header
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 14) {
                        ForEach(viewModel.personages, id: \.id) { personage in
                            NavigationLink {
                                DetailView(personage: personage).navigationBarBackButtonHidden(true)
                            } label: {
                                PersonageCard(personage: personage)
                            }
                        }
                    }.padding(20)
                }
                .onAppear { viewModel.fetchPersonages() }
            } .background(Color.darkBackground)
        }
    }
    
    var header: some View {
        HStack {
            Text(LabelsCollection.characters)
                .foregroundColor(.label)
                .padding(.leading, 24)
                .padding(.bottom, 29)
                .font(.navTitle)
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
