//
//  Etagere.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 12/02/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Etagere: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let wines: [Wine]


    func set(model: Model, wines: [Wine]) {
        guard let id = id else { return }
        
        let newEtagere = Etagere(id: id, name: name, wines: wines)
        model.updateEtagere(id: id, with: newEtagere)
    }
    
    static func test() -> Etagere {
        Etagere(
            id: .none,
            name: "Etagère",
            wines: []
        )
    }
}


private extension Etagere {
}
