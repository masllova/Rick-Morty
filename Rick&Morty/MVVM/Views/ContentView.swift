//
//  ContentView.swift
//  Rick&Morty
//
//  Created by Александра Маслова on 17.08.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.personages, id: \.id) { personage in
                // Отображение информации о персонаже
                Text(personage.name)
                
            }
        }
        .onAppear {
            viewModel.fetchPersonages()
            print(viewModel.personages)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
