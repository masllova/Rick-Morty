//
//  DetailView.swift
//  Rick&Morty
//
//  Created by Александра Маслова on 18.08.2023.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var personage: Personage
    var body: some View {
        ZStack {
            Color.darkBackground.ignoresSafeArea()
            VStack {
                backButton
                ScrollView (showsIndicators: false) {
                    title
                    createTitle(by: LabelsCollection.info)
                    infoPanel
                    createTitle(by: LabelsCollection.origin)
                    originPanel
                    createTitle(by: LabelsCollection.episodes)
                    episodesPanel
                }
            }.padding(.horizontal, 24)
        }
    }
    
    var backButton: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image.chevron.frame(width: 24, height: 24)
            }
            Spacer()
        }.padding(.top, 16)
    }
    var title: some View {
        VStack {
            AsyncImage(url: URL(string:  personage.image)) { image in
                image
                    .resizable()
                    .frame(width: 148, height: 148)
                    .cornerRadius(16)
            } placeholder: { ProgressView().frame(width: 148, height: 148) }
            Text(personage.name)
                .font(.detailTitle)
                .foregroundColor(.label)
                .padding(.top, 24)
            Text(personage.status.rawValue)
                .font(.subTitle)
                .foregroundColor(.accent)
                .padding(.top, 8)
        }.padding(.top, 18)
    }
    @ViewBuilder
    var infoPanel: some View {
        HStack {
            VStack (alignment: .leading, spacing: 16) {
                Text(LabelsCollection.species)
                Text(LabelsCollection.type)
                Text(LabelsCollection.gender)
            }
            .font(.subTitle)
            .foregroundColor(.subLabel)
            Spacer()
            VStack (alignment: .trailing, spacing: 16) {
                Text(personage.species.rawValue)
                if personage.type == "" {
                    Text(LabelsCollection.none)
                } else {
                    Text(personage.type)
                        .multilineTextAlignment(.trailing)
                        .frame(height: 20)
                        .minimumScaleFactor(0.1)
                }
                Text(personage.gender.rawValue)
            }
            .font(.subTitle)
            .foregroundColor(.label)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.lightBackground)
        )
        .padding(.top, 16)
    }
    @ViewBuilder
    var originPanel: some View {
        HStack {
            ZStack {
                Color.darkBackground
                Image.planet.frame(width: 24, height: 24)
            }
            .cornerRadius(10)
            .frame(width: 64, height: 64)
            VStack(alignment: .leading, spacing: 10) {
                if personage.origin?.name == "" {
                    Text(Status.unknown.rawValue)
                        .font(.originalTitle)
                        .foregroundColor(.label)
                } else {
                    Text(personage.origin?.name ?? "")
                        .font(.originalTitle)
                        .foregroundColor(.label)
                }
                Text(personage.origin?.type ?? "")
                    .font(.description)
                    .foregroundColor(.accent)
            }.padding(.horizontal, 16)
            Spacer()
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.lightBackground)
        )
        .padding(.top, 16)
    }
    var episodesPanel: some View {
        ForEach(personage.episodes, id: \.id) { episode in
            HStack {
                VStack (alignment: .leading, spacing: 16) {
                    Text(episode.name)
                        .font(.originalTitle)
                        .foregroundColor(.label)
                    HStack {
                        Text(clearEpisodeCode(episode.episodeCode))
                            .font(.description)
                            .foregroundColor(.accent)
                        Spacer()
                        Text(episode.airDate)
                            .font(.date)
                            .foregroundColor(.description)
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.lightBackground)
            )
            .padding(.top, 16)
        }
    }
    func createTitle(by str: String) -> some View {
        HStack {
            Text(str)
                .font(.originalTitle)
                .foregroundColor(.label)
            Spacer()
        }.padding(.top, 24)
    }
    func clearEpisodeCode(_ str: String) -> String {
        var clearStr = LabelsCollection.episode
        let numbers = str.compactMap { Int(String($0)) }
        
        if numbers[0] != 0 { clearStr += String(numbers[0]) }
        clearStr += String(numbers[1])
        clearStr += LabelsCollection.season
        if numbers[2] != 0 { clearStr += String(numbers[2]) }
        clearStr += String(numbers[3])
        
        return clearStr
    }
}
