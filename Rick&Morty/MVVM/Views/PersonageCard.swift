//
//  PersonageCard.swift
//  Rick&Morty
//
//  Created by Александра Маслова on 18.08.2023.
//

import SwiftUI

struct PersonageCard: View {
    var personage: Personage
    var body: some View {
        VStack (spacing: 16) {
            AsyncImage(url: URL(string: personage.image)) { image in
                image
                    .resizable()
                    .frame(width: 140, height: 140)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView().frame(width: 140, height: 140)
            }
            Text(personage.name)
                .font(.originalTitle)
                .frame(width: 109, height: 22)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .foregroundColor(.label)
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .padding(.bottom, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.lightBackground)
                .frame(width: 156, height: 202)
        )
        
    }
}
