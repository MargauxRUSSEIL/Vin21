//
//  WineCellar.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 11/02/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct WineCellar: View {
    @ObservedObject var model: Model
    
    var body: some View {
        
        
        NavigationView {
            VStack (alignment: .leading) {
                Button("Add Shelf") {
                    model.add(etagere: Etagere.test())
                }.padding()
                ForEach(model.etageres) { (etagere) in
                    EtagereView(model: model, etagere: etagere)
                }
                Spacer()
            }


//            List {
//                Section(header: Text("Header 1")) {
//                    ForEach(model.wines) { wine in
//                        NavigationLink(destination: WineDetail(wine: wine)) {
//                            WineView(model: model, wine: wine)
//                        }
//                    }
//                }
//                Section(header: Text("Header 2")) {
//                    ForEach(model.wines) { wine in
//                        NavigationLink(destination: WineDetail(wine: wine)) {
//                            WineView(model: model, wine: wine)
//                        }
//                    }
//                }
//            }
//            List(model.wines) { wine in
//                NavigationLink(destination: WineDetail(wine: wine)) {
//                    WineView(model: model, wine: wine)
//                }
//            }
            .navigationBarTitle("Wine cellar")
        }
    }
}
