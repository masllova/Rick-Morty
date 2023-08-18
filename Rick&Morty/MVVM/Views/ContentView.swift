//
//  ContentView.swift
//  Rick&Morty
//
//  Created by Александра Маслова on 17.08.2023.
//

import SwiftUI

struct ContentView: View {
    let m = NetworkingManager()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .onTapGesture {
                    m.loadPersonages(from: URL(string: "https://rickandmortyapi.com/api/character")!) { personages in
                        if let loadedPersonages = personages {
                            for personage in loadedPersonages {
                                print("\(personage.name) id: \(personage.id)")
                            }
                        } else {
                            print("ooops")
                        }
                    }
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
