//
//  Wine.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 10/02/2021.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift


struct Wine: Identifiable, Codable {
    @DocumentID var id: String?
    let color: String
    let title: String
    let producer: String
    let region: String
    let type: String
    let millesime: String
    let number: Int
    let place: String
    let comment: String
    let cepage: String
    let when: String
    let before: String
    
    static func test() -> Wine {
        Wine(
            id: .none,
            color: "rouge",
            title: "testTitle",
            producer: "testProducer",
            region: "",
            type: "",
            millesime: "testMillesime",
            number: 1,
            place: "Etagère 1",
            comment: "",
            cepage: "",
            when: "",
            before: ""
        )
    }
}
