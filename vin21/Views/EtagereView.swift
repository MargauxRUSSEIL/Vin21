//
//  EtagereView.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 12/02/2021.
//

import SwiftUI
import Firebase

struct EtagereView: View {
    let model: Model
    let etagere: Etagere
    
    var body: some View {
        Section(header: Text(etagere.name)) {
            ForEach(etagere.wines) { wine in
                NavigationLink(destination: WineDetail(wine: wine)) {
                    WineView(model: model, wine: wine)
                }
            }
        }
    }
}

//struct EtagereView_Previews: PreviewProvider {
//    static var previews: some View {
//        EtagereView(model: Model(), collection: .none)
//    }
//}
